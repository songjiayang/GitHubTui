class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :repository_id
      t.string :name
      t.string :full_name
      t.string :html_url
      t.string :description
      t.string :url
      t.datetime :publish_at
      t.string :git_url
      t.string :homepage
      t.integer :size
      t.integer :stargazers_count
      t.integer :watchers_count
      t.integer :forks_count
      t.integer :language_id
      t.string :default_branch
      t.integer :process_state

      t.timestamps null: false
    end

    add_index :repositories, :language_id
    add_index :repositories, :repository_id, unique: true
  end
end
