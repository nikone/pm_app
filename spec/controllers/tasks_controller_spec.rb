require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:task) { create(:task) }

  before(:each) do
    sign_in user
    project.boards << create(:board)
    project.boards.first.tasks << task
    user.projects << project
  end

  describe 'GET #index' do
    before(:each) do
      2.times { create(:board_with_task, project_id: project.id) }
      get :index, project_id: project.id, format: :json
    end

    it 'returns a list of boards with tasks' do
      expect(response_body.size).to eq(3)

      response_body.each do |board|
        expect(board[:tasks].size).to eq(1)
        expect(board[:tasks].first).to include(:tags)        
      end
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end

    context 'unauthorized' do
      it 'user cant see the task if he doesent belong to the project' do
        sign_in create(:user)
        get :index, project_id: project.id, format: :json
        expect(response_body[:error]).to eq("You dont have permission")
      end
    end
  end


  describe 'GET #show' do
    before(:each) do
      get :show, id: task.id, format: :json
    end

    it 'returns task object' do
      expect(response_body[:id]).to eq(task.id)
      expect(response_body[:title]).to eq(task.title)
      expect(response_body[:description]).to eq(task.description)
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @task_attributes = attributes_for(:task, creator_id: user.id, 
          assignee_id: user.id, board_id: project.boards.first.id )
        post :create, { task: @task_attributes, project_id: project.id }
      end

      it 'renders the json representation for the task record just created' do
        expect(response_body[:title]).to eq(@task_attributes[:title])
      end

      it 'returns a 201 HTTP status' do
        expect(response.status).to eq(201)
      end
    end

    context 'when is not created' do
      before(:each) do
        @invalid_task_attributes = attributes_for(:task, title: "", 
          board_id: project.boards.first.id)
        post :create, { task: @invalid_task_attributes, project_id: project.id }
      end

      it 'renders an errors json' do
        expect(response_body).to have_key(:errors)
      end

      it 'renders the json errors on why the task could not be created' do
        expect(response_body[:errors][:title]).to include "can't be blank"
      end

      it 'returns a 422 HTTP status' do
        expect(response.status).to eq(422)
      end
    end
  end

end
