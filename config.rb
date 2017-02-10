###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

class Position
  attr_reader :featured, :title, :type, :company, :company_url, :location

  def initialize(data)
    @featured = data[:featured]
    @title = data[:title]
    @type = data[:type]
    @company = data[:company]
    @company_url = data[:company_url]
    @location = data[:location]
  end

  def featured?
    !!@featured
  end
end

class PositionCollection
  def self.new_from_sitemap(sitemap)
    positions = sitemap.
      resources.
      select { |resource| resource.data[:position] }.
      map { |resource| Position.new(resource.data[:position]) }

    new(positions)
  end

  attr_reader :positions

  def initialize(positions)
    @positions = positions
  end

  def count
    @positions.length
  end

  def all
    @positions
  end

  def featured
    @positions.select { |position| position.featured? }
  end
end

class JobEngine
  def initialize(context)
    @context = context
  end

  def positions
    PositionCollection.new_from_sitemap(@context.sitemap)
  end
end

# Methods defined in the helpers block are available in templates
helpers do
  def job_engine
    JobEngine.new(self)
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
