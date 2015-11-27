class CreateReadmes < ActiveRecord::Migration
  def change
    create_table :readmes do |t|
      t.text :original
      t.text :raw_html
      t.integer :repository_id

      t.timestamps null: false
    end

    add_index :readmes, :repository_id, unique: true
  end
end
