task initialize_languge: :environment do
  languages = %w(CSS JavaScript HTML Ruby)
  Language.create(languages.map { |name| { name: name } })
end
