class CreateAutosaves < ActiveRecord::Migration[6.0]
  def change
    create_table :autosaves do |t|
      t.binary :title
      t.binary :content
      t.binary :title_iv
      t.binary :content_iv

      t.timestamps
    end
  end
end
