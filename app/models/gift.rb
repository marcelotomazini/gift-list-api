class Gift < ApplicationRecord
    has_and_belongs_to_many :giftLists

    validates_presence_of :title, :text
end
