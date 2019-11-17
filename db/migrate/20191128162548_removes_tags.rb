class RemovesTags < ActiveRecord::Migration[6.0]
  def change
    drop_table :tags
    drop_table :post_tags
  end
end
