class RepositoryPuller
  def initialize(query, options={})
    @query = query
    @options = default_option.deep_merge(options)
    @options.deep_merge({})
    @client = Octokit::Client.new
  end

  def perform!
    finished = false
    until finished
      @results = @client.search_repositories(@query, @options)
      parse_results
      @options[:page] += 1
      finished = true if @results.items.empty?
    end
  end

  private

  def default_option
    { per_page: 100, page: 1, order: :stars }
  end

  def parse_results
    column_names = (Repository.column_names - ['id', 'created_at', 'updated_at']).map(&:to_sym)
    @results.items.each do |item|
      item[:repository_id] = item.id
      item[:language_id] = Language.find_by(name: item.language).try(:id)
      Repository.create(item.to_h.slice(*column_names))
    end
  end
end