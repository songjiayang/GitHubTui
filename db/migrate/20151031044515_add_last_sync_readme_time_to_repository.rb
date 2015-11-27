class AddLastSyncReadmeTimeToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :last_sync_readme_time, :datetime
  end
end
