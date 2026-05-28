# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est/version'
require 'logger'
require 'yaml'

# Single estimate.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2026 Yegor Bugayenko
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
        t = (Integer(e['best-case']) + Integer(e['worst-case']) + (Integer(e['most-likely']) * 4)) / 6
        Est.log.info("#{i}: (#{e['best-case']} + #{e['worst-case']} + #{e['most-likely']} * 4) / 6 = #{t}")
        t
      end.reduce(&:+)
      result = sum * k * (n / m)
      Est.log.info("#{sum} * #{k} * (#{n} / #{m}) = #{result}")
      result.floor
    end
  end
end
