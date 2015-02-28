require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_presence_of(:username) }
  it { expect(subject).to have_many(:created_tasks) }
  it { expect(subject).to have_many(:assigned_tasks) }
end
