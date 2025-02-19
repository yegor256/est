# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est/version'
require 'logger'
require 'yaml'

# Single estimate.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2025 Yegor Bugayenko
# License:: MIT
module Est
  # Scope Champions.
  # see http://www.technoparkcorp.com/innovations/scope-champions/
  class Champions
    # Ctor.
    # +yaml+:: YAML config
    def initialize(yaml)
      @yaml = yaml
    end

    # Get total estimate.
    def total
      n = @yaml['scope'].size
      champs = @yaml['champions']
      m = champs.size
      k = 0.54
      sum = champs.map do |i, e|
        total = (e['best-case'].to_i +
          e['worst-case'].to_i +
          e['most-likely'].to_i * 4) / 6
        Est.log.info "#{i}: (#{e['best-case']} + #{e['worst-case']} +"\
          " #{e['most-likely']} * 4) / 6 = #{total}"
        total
      end.reduce(&:+)
      total = sum * k * (n / m)
      Est.log.info "#{sum} * #{k} * (#{n} / #{m}) = #{total}"
      total.to_i
    end
  end
end
