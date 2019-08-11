require 'rails_helper'

RSpec.describe GiftList, type: :model do
  it { should have_and_belong_to_many(:gifts) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
end
