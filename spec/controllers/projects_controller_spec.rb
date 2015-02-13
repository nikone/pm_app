require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      4.times { create(:project) }
      get :index, format: :json
    end

    it 'returns a list of projects' do
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response.size).to eq(4)
    end

    it "returns a 200 HTTP status" do
      expect(response).to be_success
    end
  end
end