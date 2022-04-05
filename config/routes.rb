Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :mine_sweeper, only: [:start_game, :set_position, :set_flag, :game_board] do
        collection do
          post :start_game
          post 'set_position/:game_state_id', to: 'mine_sweeper#set_position'
          post 'toggle_flag/:game_state_id', to: 'mine_sweeper#toggle_flag'
          get 'game_board/:game_state_id', to: 'mine_sweeper#game_board'
        end
      end
    end
  end
end
