require 'rails_helper'

RSpec.describe Project, type: :model do
  it { expect(subject).to validate_presence_of(:title) }

  it { expect(subject).to have_many(:boards) }
  it { expect(subject).to belong_to(:company) }
  it { expect(subject).to have_and_belong_to_many(:users) }
  it { expect(subject).to have_many(:tasks) }
end