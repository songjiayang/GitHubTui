class Repository < ActiveRecord::Base
  NOT_FOUND_CODE = '404'.freeze
  enum process_state: [:unprocessed, :liked, :disliked]
  validates :repository_id, uniqueness: true
  belongs_to :language
  has_one :readme, dependent: :destroy

  scope :liked, -> { where(process_state: Repository.process_states[:liked]) }
  scope :disliked, -> { where(process_state: Repository.process_states[:disliked]) }
  scope :unprocessed, -> { where(process_state: nil) }
  scope :without_readme, -> { where(last_sync_readme_time: nil) }
  scope :with_language, -> (language_id) { where(language_id: language_id) }
  scope :latest, -> { order(updated_at: 'desc') }
  scope :moststar, -> { order(stargazers_count: 'desc') }

  after_create :synchronize_readme

  def synchronize_readme
    check_files = %w(README.markdown README.md Readme.MD README.MD readme.md Readme.md ReadMe.md README.rdoc Readme.markdown readme.markdown README README.adoc)
    check_files.each do |file_name|
      uri = URI("https://raw.githubusercontent.com/#{full_name}/#{default_branch}/#{file_name}")
      res = Net::HTTP.get_response(uri)
      if res.code != NOT_FOUND_CODE
        create_readme original: res.body.force_encoding('UTF-8'), file_name: file_name
        break
      end
    end
  end
end
