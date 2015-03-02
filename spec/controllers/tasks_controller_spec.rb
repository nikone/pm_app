require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @task = create(:task)
      get :show, id: @task.id, format: :json
    end

    it 'returns task object' do
      task_response = JSON.parse(response.body, symbolize_names: true)
      expect(task_response[:title]).to eq(@task.title)
      expect(task_response[:id]).to eq(@task.id)
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end
  end
end
