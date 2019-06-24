class AddShareTokenToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :sharing_token, :binary
    add_column :posts, :sharing_token_iv, :binary

    add_index :posts, :sharing_token, unique: true
  end
end
