FROM techcorridorio/job_engine:latest

USER root

RUN pkg-deb libxslt-dev libxml2-dev
RUN bundle config build.nokogiri --use-system-libraries

ADD Gemfile /src/Gemfile
ADD Gemfile.lock /src/Gemfile.lock
RUN bundle install

USER jobengine
