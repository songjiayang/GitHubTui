require 'github/markup'
class Readme < ActiveRecord::Base
  validates :repository_id, uniqueness: true
  belongs_to :repository, touch: :last_sync_readme_time

  before_save :translate_original_content

  private

  def translate_original_content
    self.raw_html = GitHub::Markup.render('*.md', original.to_s)
  end
end
