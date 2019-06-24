class AddShareTokenToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :sharing_token, :string

    add_index :posts, :sharing_token, unique: true
  end
end
