class ReviseSharingData < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :sharing_token
    add_column :posts, :sharing_token, :binary
    add_column :posts, :sharing_token_iv, :binary
    add_column :posts, :listed_publicly, :boolean, null: false, default: false

    add_index :posts, :sharing_token, unique: true
    add_index :posts, :listed_publicly
  end
end
