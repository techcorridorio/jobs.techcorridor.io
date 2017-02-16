require 'job_engine'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page '/positions/index.html', layout: 'layout'
page '/positions/*', layout: 'position'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

config.site_name = 'jobs.techcorridor.io'
config.github_url = 'https://github.com/techcorridorio/jobs.techcorridor.io'

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers JobEngine::MiddlemanHelpers

configure :development do
  config.base_url = 'http://0.0.0.0:4567'

  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end

# Build-specific configuration
configure :build do
  config.base_url = 'http://jobs.techcorridor.io'

  activate :minify_css
  activate :minify_javascript

  activate :google_analytics do |ga|
    ga.tracking_id = 'UA-91743483-1'
  end
end
