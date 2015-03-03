require 'rails_helper'

RSpec.describe Task, type: :model do
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:creator) }
  it { expect(subject).to validate_presence_of(:assignee) }

  it { expect(subject).to belong_to(:creator) }
  it { expect(subject).to belong_to(:assignee) }
  it { expect(subject).to belong_to(:board) }
  it { expect(subject).to have_many(:tags) }
  it { expect(subject).to have_many(:taggings) }
end
