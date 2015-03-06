require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe 'GET #index' do
    before(:each) do
      @user = create(:user)
      @project = create(:project)
      @user.projects << @project
      2.times { create(:board_with_tasks, project_id: @project.id) }
    end

    context 'authoraized' do
      before(:each) do
        sign_in @user
        get :index, project_id: @project.id, format: :json
      end

      it 'returns a list of boards with tasks' do
        task_response = JSON.parse(response.body, symbolize_names: true)
        expect(task_response.size).to eq(2)

        task_response.each do |board|
          expect(board[:tasks].size).to eq(2)
          expect(board[:tasks].first).to include(:tags)        
        end
      end

      it 'returns a 200 HTTP status' do
        expect(response).to be_success
      end
    end

    context 'unauthorized' do
      before(:each) do
        sign_in create(:user)
        get :index, project_id: @project.id, format: :json
      end 

      it 'doesent allow access' do
        res = JSON.parse(response.body, symbolize_names: true)
        expect(res[:error]).to eq("You dont have permission")
      end     
    end
  end


  describe 'GET #show' do
    before(:each) do
      @user = create(:user)
      @task = create(:task)
      @user.projects << @task.board.project
    end

    context 'authoraized' do
      before(:each) do
        sign_in @user
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

    context 'unauthorized' do
      before(:each) do
        sign_in create(:user)
        get :show, id: @task.id, format: :json        
      end
      it 'doesent allow access' do
        res = JSON.parse(response.body, symbolize_names: true)
        expect(res[:error]).to eq("You dont have permission")
      end  
    end
  end

  describe 'POST #create' do
    before(:each) do
      @user = create(:user)
      @project = create(:project)
      @user.projects << @project
      sign_in @user
    end
    context 'when is successfully created' do
      before(:each) do
        @task_attributes = attributes_for(:task, creator_id: @user.id, assignee_id: @user.id )
        post :create, { task: @task_attributes, project_id: @project.id }
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
        post :create, { task: @invalid_project_attributes, project_id: @project.id }
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

    context 'not authoraized' do
      before(:each) do
        sign_in create(:user)
        @task_attributes = attributes_for(:task, creator_id: @user.id, assignee_id: @user.id )
        post :create, { task: @task_attributes, project_id: @project.id }        
      end
      it 'doesent allow access' do
        res = JSON.parse(response.body, symbolize_names: true)
        expect(res[:error]).to eq("You dont have permission")
      end  
    end
  end

end
