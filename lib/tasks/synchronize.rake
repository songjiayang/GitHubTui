require 'repository_puller'

namespace :synchronize do
  task latest_repository: :environment do
    languages = %w(JavaScript Go)
    languages.each { |l|
      RepositoryPuller.new("#{l} stars:>100 created:>2015-01-01").perform!
    }
  end

  task repository_readme: :environment do
    Repository.find_each(&:synchronize_readme)
  end

  task :initialize_languge, :environment do
    languages = %w(JavaScript Go)
    Language.create(languages.map { |name| { name: name } })
  end

  desc 'fetch the last week popular repository'
  task last_week_repository: :environment do
    created_at = 7.days.ago.to_date.to_s
    RepositoryPuller.new("stars:>100 created:>#{created_at}").perform!
  end
end
