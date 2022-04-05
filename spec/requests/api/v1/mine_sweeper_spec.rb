require 'swagger_helper'

RSpec.describe 'api/v1/mine_sweeper', type: :request do

  path '/api/v1/mine_sweeper/start_game' do

    post('start_game mine_sweeper') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/mine_sweeper/set_position/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    post('set_position mine_sweeper') do
      response(200, 'successful') do
        let(:game_state_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/mine_sweeper/toggle_flag/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    post('toggle_flag mine_sweeper') do
      response(200, 'successful') do
        let(:game_state_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/mine_sweeper/game_board/{game_state_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'game_state_id', in: :path, type: :string, description: 'game_state_id'

    get('game_board mine_sweeper') do
      response(200, 'successful') do
        let(:game_state_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
