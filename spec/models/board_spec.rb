require 'rails_helper'

RSpec.describe Board, type: :model do
  it { expect(subject).to validate_presence_of(:title) }

  it { expect(subject).to belong_to(:project) }
end
