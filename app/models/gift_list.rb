class GiftList < ApplicationRecord
    has_and_belongs_to_many :gifts

    validates_presence_of :title, :text
end
