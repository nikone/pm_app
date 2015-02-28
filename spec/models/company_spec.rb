require 'rails_helper'

RSpec.describe Company, type: :model do
  it { expect(subject).to validate_presence_of(:name) }

  it { expect(subject).to have_many(:projects) }
end
