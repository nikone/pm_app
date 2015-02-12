require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      @pr1 = Project.create(title: "title", description: "desc")
      @pr2 = Project.create(title: "title", description: "desc")

      get :index, format: :json
    end
    it 'returns a list of projects' do
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response.size).to eq(2)
    end
  end
end