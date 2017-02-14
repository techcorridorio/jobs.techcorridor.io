require 'builder'

module JobEngine
  class PositionsAtomFeed
    def initialize(config, positions)
      @config = config
      @positions = positions
    end

    def to_xml
      xml = Builder::XmlMarkup.new(indent: 2)

      xml.instruct!

      xml.feed xmlns: 'http://www.w3.org/2005/Atom' do
        xml.title @config.site_name
        xml.link href: @config.base_url
        xml.updated Time.now.iso8601

        @positions.reverse_chronological.each do |position|
          xml.entry do
            xml.id position.guid
            xml.title position.page_title
            xml.link href: "#{@config.base_url}#{position.absolute_path}"
            xml.content 'See posting for details', type: 'html'
            xml.updated position.updated_at.iso8601
          end
        end
      end

      xml.target!
    end
  end
end
