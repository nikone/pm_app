require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @task = create(:task)
      get :show, id: @task.id, format: :json
    end

    it 'returns task object' do
      task_response = JSON.parse(response.body, symbolize_names: true)
      expect(task_response[:id]).to eq(@task.id)
      expect(task_response[:title]).to eq(@task.title)
      expect(task_response[:description]).to eq(@task.description)
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @user = create(:user)
        @task_attributes = attributes_for(:task, creator_id: @user.id, assignee_id: @user.id )
        post :create, { task: @task_attributes }
      end

      it 'renders the json representation for the task record just created' do
        task_response = JSON.parse(response.body, symbolize_names: true)
        expect(task_response[:title]).to eq(@task_attributes[:title])
      end

      it 'returns a 201 HTTP status' do
        expect(response.status).to eq(201)
      end
    end

    context 'when is not created' do
      before(:each) do
        @invalid_project_attributes = { title: "" }
        post :create, { task: @invalid_project_attributes }
      end

      it 'renders an errors json' do
        task_response = JSON.parse(response.body, symbolize_names: true)
        expect(task_response).to have_key(:errors)
      end

      it 'renders the json errors on why the task could not be created' do
        task_response = JSON.parse(response.body, symbolize_names: true)
        expect(task_response[:errors][:title]).to include "can't be blank"
      end

      it 'returns a 422 HTTP status' do
        expect(response.status).to eq(422)
      end
    end
  end
end
