# encoding: utf-8
#
# Copyright (c) 2014 TechnoPark Corp.
# Copyright (c) 2014 Yegor Bugayenko
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

require 'est/estimate'
require 'nokogiri'
require 'logger'
require 'time'

# Est main module.
# Author:: Yegor Bugayenko (yegor@teamed.io)
# Copyright:: Copyright (c) 2014 Yegor Bugayenko
# License:: MIT
module Est
  # Estimates.
  class Estimates
    # Ctor.
    # +dir+:: Directory with estimates
    def initialize(dir)
      @dir = dir
    end

    # Get total estimate.
    def total
      estimates = iterate
      estimates.reduce(0) do |a, e|
        Est.log.info "#{e.date}/#{e.author}: #{e.total}"
        a + e.total
      end / estimates.size
    end

    # Iterate them all
    def iterate
      unless @iterate
        @iterate = Dir.entries(@dir)
          .reject { |f| f.index('.') == 0 }
          .select { |f| f =~ /^.*\.est$/ }
          .map { |f| File.join(@dir, f) }
          .each { |f| Est.log.info "#{f} found" }
          .map { |f| Estimate.new(f) }
          .map { |f| Estimate::Const.new(f) }
      end
      fail "no .est files found in #{@dir}" if @iterate.empty?
      @iterate
    end

    # Const estimates.
    class Const
      attr_reader :total, :iterate
      # Ctor.
      # +est+:: Original estimates
      def initialize(est)
        @iterate = est.iterate
        @total = est.total
      end
    end
  end
end
