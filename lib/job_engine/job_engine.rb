module JobEngine
  class JobEngine
    def initialize(context)
      @context = context
    end

    def position
      PositionFactory.new(@context.current_page).position
    end

    def positions
      PositionCollectionFactory.new(@context.sitemap.resources).position_collection
    end

    def new_position_url
      "#{github_url}/new/master/source/positions?filename=my_position.html.md"
    end

    def edit_position_url(position)
      "#{github_url}/edit/master/#{position.source_path}"
    end

    def delete_position_url(position)
      "#{github_url}/delete/master/#{position.source_path}"
    end

    private

    def github_url
      @context.config.github_url
    end
  end
end
