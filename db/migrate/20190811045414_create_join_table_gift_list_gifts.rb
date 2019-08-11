class CreateJoinTableGiftListGifts < ActiveRecord::Migration[5.2]
  def change
    create_join_table :gift_lists, :gifts do |t|
      # t.index [:gift_list_id, :gift_id]
      # t.index [:gift_id, :gift_list_id]
    end
  end
end
