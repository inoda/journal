class CreatePrompts < ActiveRecord::Migration[5.1]
  def change
    create_table :prompts do |t|
      t.binary :content, null: false
      t.binary :content_iv, null: false

      t.timestamps
    end
  end
end
