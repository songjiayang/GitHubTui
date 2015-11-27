class AddFileNameToReadmes < ActiveRecord::Migration
  def change
    add_column :readmes, :file_name, :string
  end
end
