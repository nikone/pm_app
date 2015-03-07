require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
=begin
  describe 'GET #index' do
    before(:each) do
      4.times { create(:board_with_tasks) }
      get :index, project_id: 1, format: :json
    end

    it 'returns a list of boards with tasks' do
      board_response = JSON.parse(response.body, symbolize_names: true)
      expect(board_response.size).to eq(4)

      board_response.each do |board|
        expect(board[:tasks].size).to eq(4)
        expect(board[:tasks].first).to include(:tags)        
      end
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end
  end
=end
end
