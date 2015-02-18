require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @project = create(:project)
      get :show, id: @project.id, format: :json
    end

    it 'has the project as embeded object' do
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response[:title]).to eq(@project.title)
      expect(project_response[:id]).to eq(@project.id)
    end

    it 'returns a 200 http status' do
      expect(response).to be_success
    end
  end

  describe 'GET #index' do
    before(:each) do
      4.times { create(:project) }
      get :index, format: :json
    end

    it 'returns a list of projects' do
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response.size).to eq(4)
    end

    it 'returns the user object into each product' do
      projects_response = JSON.parse(response.body, symbolize_names: true)
      projects_response.each do |project_response|
        expect(project_response[:title]).to be_present
        expect(project_response[:description]).to be_present
      end
    end

    it 'returns a 200 HTTP status' do
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @project_attributes = attributes_for(:project)
        post :create, { project: @project_attributes }
      end

      it 'renders the json representation for the project record just created' do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:title]).to eq(@project_attributes[:title])
      end

      it 'returns a 201 HTTP status' do
        expect(response.status).to eq(201)
      end
    end

    context 'when is not created' do
      before(:each) do
        @invalid_project_attributes = {description: "Some description"}
        post :create, { project: @invalid_project_attributes }
      end

      it 'renders an errors json' do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response).to have_key(:errors)
      end

      it 'renders the json errors on why the project could not be created' do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:errors][:title]).to include "can't be blank"
      end

      it 'returns a 422 HTTP status' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PUT/PATCH #update' do
  end

  describe 'DELETE #destroy' do
  end
end





