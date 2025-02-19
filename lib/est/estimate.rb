# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est/version'
require 'est/methods/champions'
require 'logger'
require 'yaml'

# Single estimate.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2025 Yegor Bugayenko
# License:: MIT
module Est
  # Estimate.
  class Estimate
    # Ctor.
    # +file+:: File with YAML estimate
    def initialize(file)
      @yaml = YAML.load_file(file)
      fail "failed to read file #{file}" unless @yaml
    end

    # Get date.
    def date
      Date.strptime(@yaml['date'], '%d-%m-%Y')
    end

    # Get author.
    def author
      @yaml['author']
    end

    # Get total estimate.
    def total
      method = @yaml['method']
      fail "unsupported method #{method}" unless method == 'champions.pert'
      Champions.new(@yaml).total
    end

    # Constant estimate.
    class Const
      attr_reader :date, :author, :total
      # Ctor.
      # +est+:: Estimate
      def initialize(est)
        @date = est.date
        @author = est.author
        @total = est.total
      end
    end
  end
end
