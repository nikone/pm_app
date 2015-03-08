require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:board) { create(:board) }

  before(:each) do
    sign_in user
    project.boards << board
    user.projects << project
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @board_attributes = attributes_for(:board)
        post :create, { board: @board_attributes, project_id: project.id }
      end

      it 'renders the json representation for the board record just created' do
        expect(response_body[:title]).to eq(@board_attributes[:title])
      end

      it 'returns a 201 HTTP status' do
        expect(response.status).to eq(201)
      end
    end

    context 'when is not created' do
      before(:each) do
        @invalid_board_attributes = attributes_for(:board, title: "")
        post :create, { board: @invalid_board_attributes, project_id: project.id }
      end

      it 'renders an errors json' do
        expect(response_body).to have_key(:errors)
      end

      it 'renders the json errors on why the board could not be created' do
        expect(response_body[:errors][:title]).to include "can't be blank"
      end

      it 'returns a 422 HTTP status' do
        expect(response.status).to eq(422)
      end
    end
  end

end
