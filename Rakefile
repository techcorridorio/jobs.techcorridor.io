require 'fileutils'
require 'middleman-gh-pages'

namespace :jobengine do
  desc 'Clean up generated files'
  task :clean do
    FileUtils.rm_rf('build', verbose: true)
  end

  task :publish => [:clean, :publish]
end
