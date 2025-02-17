# encoding: utf-8
#
# Copyright (c) 2014-2025 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'est/version'
require 'est/estimates'
require 'nokogiri'
require 'logger'
require 'time'

# Est main module.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2025 Yegor Bugayenko
# License:: MIT
module Est
  # If it breaks.
  class Error < StandardError
  end

  # If it violates XSD schema.
  class SchemaError < Error
  end

  # Get logger.
  def self.log
    unless @logger
      @logger = Logger.new(STDOUT)
      @logger.formatter = proc { |severity, _, _, msg|
        "#{severity}: #{msg.dump}\n"
      }
      @logger.level = Logger::ERROR
    end
    @logger
  end

  class << self
    attr_writer :logger
  end

  # Code base abstraction
  class Base
    # Ctor.
    # +opts+:: Options
    def initialize(opts)
      @opts = opts
      Est.log.level = Logger::INFO if @opts.verbose?
      Est.log.info "my version is #{Est::VERSION}"
    end

    # Generate XML.
    def xml
      dir = @opts.dir? ? @opts[:dir] : Dir.pwd
      Est.log.info "reading #{dir}"
      estimates = Estimates::Const.new(Estimates.new(dir))
      sanitize(
        Nokogiri::XML::Builder.new do |xml|
          xml << "<?xml-stylesheet type='text/xsl' href='#{xsl}'?>"
          xml.estimate(attrs) do
            xml.total estimates.total
            unless estimates.iterate.empty?
              xml.ests do
                estimates.iterate.each do |est|
                  xml.est do
                    xml.date est.date
                    xml.total est.total
                    xml.author est.author
                  end
                end
              end
            end
          end
        end.to_xml
      )
    end

    private

    def attrs
      {
        'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
        'xsi:noNamespaceSchemaLocation' => "#{host('xsd')}/#{Est::VERSION}.xsd",
        'version' => Est::VERSION,
        'date' => Time.now.utc.iso8601
      }
    end

    def host(suffix)
      "http://est-#{suffix}.teamed.io"
    end

    def xsl
      "#{host('xsl')}/#{Est::VERSION}.xsl"
    end

    def sanitize(xml)
      xsd = Nokogiri::XML::Schema(
        File.read(File.join(File.dirname(__FILE__), '../assets/est.xsd'))
      )
      errors = xsd.validate(Nokogiri::XML(xml)).map(&:message)
      errors.each { |e| Est.log.error e }
      Est.log.error(xml) unless errors.empty?
      fail SchemaError, errors.join('; ') unless errors.empty?
      xml
    end
  end
end
