require 'rails_helper'

describe BoardPolicy do
  subject { BoardPolicy.new(user, board) }

  let(:user) { create(:user) }
  let(:board) { create(:board) }
  let(:project) { create(:project) }

  before(:each) do
    project.boards << board
  end

  context 'user belongs to project' do
    before(:each) do
      user.projects << project
    end

    it { expect(subject).to allow_access_to(:create) }
  end

  context 'user does not belong to project' do
    it { expect(subject).to_not allow_access_to(:create) }
  end
end