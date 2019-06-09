class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.binary :title, null: false
      t.binary :content, null: false
      t.binary :title_iv, null: false
      t.binary :content_iv, null: false

      t.timestamps
    end
  end
end
