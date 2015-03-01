require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      4.times { create(:board_with_tasks) }
      get :index, project_id: 1, format: :json
    end

    it 'returns a list of boards' do
      board_response = JSON.parse(response.body, symbolize_names: true)
      expect(board_response.size).to eq(4)
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end
  end
end
