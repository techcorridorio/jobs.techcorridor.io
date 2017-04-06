require 'open-uri'
require 'rss'
require 'nokogiri'

class PositionScraper
  def initialize(config)
    @config = config
  end

  def fetch
    @config[:rss_feeds].
      map { |rss_config| RSSPositionScraper.new(rss_config).fetch }.
      flatten
  end
end

class RSSPositionScraper
  def initialize(config)
    @feed_url = config[:feed_url]
    @title_filter = config[:title_filter]
    @type = config[:type]
    @location = config[:location]
    @company = config[:company]
    @company_url = config[:company_url]
    @description_selector = config[:description_selector]
  end

  def fetch
    rss = RSS::Parser.parse(@feed_url)

    rss.
      items.
      select { |item| item.title.match(@title_filter) }.
      map do |item|
        {
          type: @type,
          location: @location,
          company: @company,
          company_url: @company_url,
          title: item.title,
          source_url: item.link,
          description: parse_description(item)
        }
      end
  end

  private

  def parse_description(item)
    wrapped_description = "<html><body>#{item.description}</body></html>"
    description_doc = Nokogiri.parse(wrapped_description)
    description_doc.css('#job_description').to_s
  end
end
