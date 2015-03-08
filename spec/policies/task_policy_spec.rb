require 'rails_helper'

describe TaskPolicy do
  subject { TaskPolicy.new(user, task) }

  let(:user) { create(:user) }
  let(:project) { create(:project_with_board) }
  let(:task) { create(:task) }

  before(:each) do
    project.boards.first.tasks << task
  end

  context 'user belongs to project which contains the task' do
    before(:each) do
      user.projects << task.board.project
    end

    it { expect(subject).to allow_access_to(:create) }
    it { expect(subject).to allow_access_to(:show) }
    it { expect(subject).to allow_access_to(:update) }
    it { expect(subject).to allow_access_to(:destroy) }
  end

  context 'user does not belong to project which contains the task' do
    it { expect(subject).to_not allow_access_to(:create) }
    it { expect(subject).to_not allow_access_to(:show) }
    it { expect(subject).to_not allow_access_to(:update) }
    it { expect(subject).to_not allow_access_to(:destroy) }
  end
end
