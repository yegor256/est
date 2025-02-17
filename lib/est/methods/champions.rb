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
