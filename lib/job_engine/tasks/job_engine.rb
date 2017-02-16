require 'fileutils'

namespace :job_engine do
  desc 'Clean up generated files'
  task :clean do
    FileUtils.rm_rf('build', verbose: true)
  end
end
