require 'rails_helper'

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  let(:user) { create(:user) }
  let(:project) { create(:project) }

  context 'user belongs to project' do
    before(:each) do
      user.projects << project
    end

    it { expect(subject).to allow_access_to(:show) }
    it { expect(subject).to allow_access_to(:update) }
    it { expect(subject).to allow_access_to(:destroy) }
  end

  context 'user does not belong to project' do
    it { expect(subject).to_not allow_access_to(:show) }
    it { expect(subject).to_not allow_access_to(:update) }
    it { expect(subject).to_not allow_access_to(:destroy) }
  end
end
