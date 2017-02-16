require 'middleman-gh-pages'
require_relative './lib/job_engine/tasks/job_engine'

namespace :jobengine do
  desc 'Set up robot git config'
  task :config do
    sh 'git config --global user.name "JobEngine Bot"'
    sh 'git config --global user.email "info@techcorridor.io"'
  end

  task :publish => [:clean, :config, :publish]
end
