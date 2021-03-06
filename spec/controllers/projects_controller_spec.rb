require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  before(:each) do
    sign_in user
    user.projects << project
  end

  describe 'GET #show' do
    before(:each) do
      get :show, id: project.id, format: :json
    end

    it 'has the project as embeded object' do
      expect(response_body[:title]).to eq(project.title)
      expect(response_body[:id]).to eq(project.id)
    end

    it 'returns a 200 http status' do
      expect(response).to be_success
    end
  end

  describe 'GET #index' do
    before(:each) do
      user.projects << create(:project)
      get :index, format: :json
    end

    it 'returns a list of projects' do
      expect(response_body.size).to eq(2)
    end

    it 'returns the project object into each product' do
      response_body.each do |project_response|
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
        expect(response_body[:title]).to eq(@project_attributes[:title])
      end

      it 'is added to users project list' do
        expect(user.projects).to include(Project.find(response_body[:id]))
      end

      it 'returns a 201 HTTP status' do
        expect(response.status).to eq(201)
      end
    end

    context 'when is not created' do
      before(:each) do
        @invalid_project_attributes = { description: "Some description" }
        post :create, { project: @invalid_project_attributes }
      end

      it 'renders an errors json' do
        expect(response_body).to have_key(:errors)
      end

      it 'renders the json errors on why the project could not be created' do
        expect(response_body[:errors][:title]).to include "can't be blank"
      end

      it 'returns a 422 HTTP status' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PUT/PATCH #update' do
    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: project.id, project: { title: "An expensive project" } }
      end

      it "renders the json representation for the updated user" do
        expect(response_body[:title]).to eql "An expensive project"
      end

      it 'returns a 200 HTTP status' do
        expect(response).to be_success
      end
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { id: project.id, project: { title: "" } }
      end

      it "renders an errors json" do
        expect(response_body).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        expect(response_body[:errors][:title]).to include "can't be blank"
      end

      it 'returns a 422 HTTP status' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      delete :destroy, { id: project.id }
    end

    it 'returns a 204 HTTP status' do
      expect(response.status).to eq(204)
    end
  end
end





