require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to have_many(:taggings) }
  it { expect(subject).to have_many(:tasks) }
end
