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
end
