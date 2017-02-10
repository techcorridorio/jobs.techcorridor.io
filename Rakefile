require 'fileutils'
require 'middleman-gh-pages'

namespace :jobengine do
  desc 'Clean up generated files'
  task :clean do
    FileUtils.rm_rf('build', verbose: true)
  end

  desc 'Set up robot git config'
  task :config do
    sh 'git config --global user.name "JobEngine Bot"'
    sh 'git config --global user.email "info@techcorridor.io"'
  end

  task :publish => [:clean, :config, :publish]
end
