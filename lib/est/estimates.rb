# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est/estimate'
require 'nokogiri'
require 'logger'
require 'time'

# Est main module.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2025 Yegor Bugayenko
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
      if estimates.empty?
        total = 0
      else
        total = estimates.reduce(0) do |a, e|
          Est.log.info "#{e.date}/#{e.author}: #{e.total}"
          a + e.total
        end / estimates.size
      end
      total
    end

    # Iterate them all
    def iterate
      unless @iterate
        if File.exist?(@dir) && File.directory?(@dir)
          @iterate = Dir.entries(@dir)
            .reject { |f| f.index('.') == 0 }
            .select { |f| f =~ /^.*\.est$/ }
            .map { |f| File.join(@dir, f) }
            .each { |f| Est.log.info "#{f} found" }
            .map { |f| Estimate.new(f) }
            .map { |f| Estimate::Const.new(f) }
        else
          Est.log.info "#{@dir} is absent or is not a directory"
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
