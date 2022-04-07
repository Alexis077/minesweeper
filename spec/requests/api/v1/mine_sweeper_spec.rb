require 'swagger_helper'

RSpec.describe 'api/v1/mine_sweeper', type: :request do

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
        examples 'application/json' => {
          "id": 68,
          "start_time": "2022-04-07T01:21:13.903Z",
          "state": "playing",
          "face": "😀",
              "board": [
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"],
                  ["🟪","🟪","🟪","🟪","🟪","🟪","🟪","🟪"]
              ]
        }
      
        run_test!
      end

      response(400, 'zero mines') do
        let(:mine_sweeper) { { height: 8, width: 8, mines: 0 } }
        examples 'application/json' => {
          "error": "zero_mines"
        }
        run_test!
      end

      response(400, 'zero height') do
        let(:mine_sweeper) { { height: 0, width: 8, mines: 10 } }
        examples 'application/json' => {
          "error": "zero_height"
        }
        run_test!
      end

      response(400, 'zero width') do
        let(:mine_sweeper) { { height: 8, width: 0, mines: 10 } }
        examples 'application/json' => {
          "error": "zero_width"
        }
        run_test!
      end

      response(400, 'invalid mine count') do
        let(:mine_sweeper) { { height: 8, width: 8, mines: 65 } }
        examples 'application/json' => {
          "error": "invalid_mine_count"
        }
        run_test!
      end
    end
  end

  path '/api/v1/mine_sweeper/set_position/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'
    
    patch('set_position mine_sweeper') do
      
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
        examples 'application/json' => {
          "id": 68,
          "start_time": "2022-04-07T01:21:13.903Z",
          "state": "playing",
          "face": "😀",
          "board": [
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["1","1","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟪","2","1","1","🟩","🟩","🟩","🟩"],
              ["🟪","🟪","🟪","1","🟩","🟩","🟩","🟩"],
              ["🟪","🟪","🟪","1","🟩","🟩","🟩","🟩"]
          ]
      }
        run_test!
      end

      response(400, 'Invalid position') do

        examples 'application/json' => {
          "error": "invalid_position"
        }
        run_test!
      end
    end
  end

  path '/api/v1/mine_sweeper/toggle_flag/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    patch('toggle_flag mine_sweeper') do
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
        examples 'application/json' => {
          "id": 68,
          "start_time": "2022-04-07T01:21:13.903Z",
          "state": "playing",
          "face": "😀",
          "board": [
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["1","1","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟪","2","1","1","🟩","🟩","🟩","🟩"],
              ["🟪","🟪","🟪","1","🟩","🟩","🟩","🟩"],
              ["🚩","🟪","🟪","1","🟩","🟩","🟩","🟩"]
          ]
        }
        run_test!
      end

      response(400, 'Invalid position') do

        examples 'application/json' => {
          "error": "invalid_position"
        }
        run_test!
      end
    end
  end

  path '/api/v1/mine_sweeper/game_board/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    get('game_board mine_sweeper') do
      response(200, 'successful') do
        examples 'application/json' => {
          "id": 68,
          "start_time": "2022-04-07T01:21:13.903Z",
          "state": "playing",
          "face": "😀",
          "board": [
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟩","🟩","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["1","1","🟩","🟩","🟩","🟩","🟩","🟩"],
              ["🟪","2","1","1","🟩","🟩","🟩","🟩"],
              ["🟪","🟪","🟪","1","🟩","🟩","🟩","🟩"],
              ["🚩","🟪","🟪","1","🟩","🟩","🟩","🟩"]
          ]
        }
        run_test!
      end

      response(400, 'Invalid position') do

        examples 'application/json' => {
          "error": "Couldn't find GameState with 'id'=222"
        }
        run_test!
      end
    end
  end
end
