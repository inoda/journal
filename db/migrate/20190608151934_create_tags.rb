class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.binary :label, null: false
      t.binary :label_iv, null: false

      t.timestamps
    end
  end
end
