class CreatePostsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end

    add_index :post_tags, :post_id
    add_index :post_tags, :tag_id
  end
end
