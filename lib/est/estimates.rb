# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est/estimate'
require 'logger'
require 'nokogiri'
require 'time'

# Est main module.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2026 Yegor Bugayenko
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
      items = iterate
      return 0 if items.empty?
      items.reduce(0) do |a, e|
        Est.log.info("#{e.date}/#{e.author}: #{e.total}")
        a + e.total
      end / items.size
    end

    # Iterate them all
    def iterate
      unless @iterate
        if File.exist?(@dir) && File.directory?(@dir)
          entries = Dir.entries(@dir).reject { |f| f.index('.').zero? }
          files = entries.grep(/^.*\.est$/).map { |f| File.join(@dir, f) }
          files.each { |f| Est.log.info("#{f} found") }
          @iterate = files.map { |f| Estimate::Const.new(Estimate.new(f)) }
        else
          Est.log.info("#{@dir} is absent or is not a directory")
          @iterate = []
        end
      end
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
