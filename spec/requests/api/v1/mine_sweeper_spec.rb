require 'swagger_helper'

RSpec.describe 'api/v1/mine_sweeper', type: :request do

  before do
    allow_any_instance_of(Minesweeper::RandomMineGenerator).to receive(:populate_board) do |generator|
      # Define las posiciones de las minas
      mine_positions = [
        [0, 0],
        [1, 2],
        [3, 4],
        # Agrega más posiciones si es necesario
      ]

      mine_positions.each do |position|
        y, x = position
        generator.board[y][x] = Mine.new(y: y, x: x, state: :hidden)
      end
    end
  end

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        examples: {
          example.metadata[:example_group][:description] => {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
  end

  path '/api/v1/mine_sweeper/start_game' do

    post('start_game mine_sweeper') do
      
      tags 'Start Game'
      consumes 'application/json'

      parameter name: :mine_sweeper, in: :body, schema: {
        type: :object,
        properties: {
          height: { type: :integer },
          width: { type: :integer },
          mines: { type: :integer }
        },
        required: [ 'height', 'width', 'mines' ],
        example: {
          height: 8,
          width: 8,
          mines: 10
        }
      }
      
      response(200, 'Game started') do
        let(:mine_sweeper) { { height: 8, width: 8, mines: 2 } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['state']).to eq('playing')
        end
      end

      response(400, 'Error') do

        context "zero mines" do
          let(:mine_sweeper) { { height: 8, width: 8, mines: 0 } }
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq('zero_mines')
          end
        end
      
        context "zero height" do
          let(:mine_sweeper) { { height: 0, width: 8, mines: 10 } }
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq('zero_height')
          end
        end

        context "zero width" do
          let(:mine_sweeper) { { height: 8, width: 0, mines: 10 } }
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq('zero_width')
          end
        end

        context "invalid mine count" do
          let(:mine_sweeper) { { height: 8, width: 8, mines: 65 } }
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq('invalid_mine_count')
          end
        end
      end
    end
  end

  path '/api/v1/mine_sweeper/set_position/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'
    
    patch('set_position mine_sweeper') do
      let!(:game_state_id) { GameState.create_game_state(10, 8, 8).id }

      tags 'Set new position'
      consumes 'application/json'
      parameter name: :position, in: :body, schema: {
        type: :object,
        properties: {
          position: {
            x: { type: :integer },
            y: { type: :integer }
          }
          
        },
        required: [ 'position'],
        example: {
          position:{
            x: 0,
            y: 1
          }
        }
      }

      response(200, 'successful') do
        context "Discover a common cell" do
          let(:position) {{position: { x: 0, y: 1 }}}        
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['state']).to eq('playing')
          end
        end

        context "Game over" do
          let(:position) {{position: { x: 0, y: 0 }}}
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['state']).to eq('lost')
          end
        end
      end


      response(400, 'Error') do
        context "Invalid position" do
          let(:position) {{position: { x: -1, y: 0 }}}
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq('invalid_position')
          end
        end
      end
    end
  end

  path '/api/v1/mine_sweeper/toggle_flag/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    patch('toggle_flag mine_sweeper') do
      let!(:game_state_id) { GameState.create_game_state(10, 8, 8).id }

      tags 'Add or remove flag'
      consumes 'application/json'
      parameter name: :position, in: :body, schema: {
        type: :object,
        properties: {
          position: {
            x: { type: :integer },
            y: { type: :integer }
          }
        },
        required: [ 'position'],
        example: {
          position:{
            x: 0,
            y: 7
          }
        }
      }
  
      response(200, 'successful') do
        context "Set Flag" do
          let(:position) {{position: { x: 1, y: 1 }}}
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['state']).to eq('playing')
          end
        end
      end

      response(400, 'Error') do
        context "Invalid position to set flag" do
          let(:position) {{position: { x: 9, y: 9 }}}
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq('invalid_position')
          end
        end
      end
    end
  end

  path '/api/v1/mine_sweeper/game_board/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    get('game_board mine_sweeper') do
      let(:game_state_id) { GameState.create_game_state(10, 8, 8).id }

      response(200, 'successful') do
        context "Find game" do
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['state']).to eq('playing')
          end
        end
      end

      response(400, 'Error') do
        context "Game not found" do
          let(:game_state_id) { 1000 }
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['error']).to eq("Couldn't find GameState with 'id'=1000")
          end
        end
      end
    end
  end
end
