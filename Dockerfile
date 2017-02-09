FROM techcorridorio/jobengine:latest

USER root
ADD Gemfile /src/Gemfile
ADD Gemfile.lock /src/Gemfile.lock
RUN bundle install

USER jobengine
