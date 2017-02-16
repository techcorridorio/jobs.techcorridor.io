require 'fileutils'

namespace :job_engine do
  desc 'Clean up generated files'
  task :clean do
    FileUtils.rm_rf('build', verbose: true)
  end

  desc 'Check links in built site'
  task :check_links do
    sh 'middleman build --verbose'
    sh 'linkchecker "build/"'
  end
end
