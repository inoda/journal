class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.binary :title, null: false
      t.binary :content
      t.binary :title_iv
      t.binary :content_iv

      t.timestamps
    end
  end
end
