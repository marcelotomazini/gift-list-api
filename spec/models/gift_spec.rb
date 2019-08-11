require 'rails_helper'

RSpec.describe Gift, type: :model do
  it { should have_and_belong_to_many(:giftLists) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
end
