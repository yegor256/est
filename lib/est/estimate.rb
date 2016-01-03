# encoding: utf-8
#
# Copyright (c) 2014-2016 TechnoPark Corp.
# Copyright (c) 2014-2016 Yegor Bugayenko
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
require 'est/methods/champions'
require 'logger'
require 'yaml'

# Single estimate.
# Author:: Yegor Bugayenko (yegor@teamed.io)
# Copyright:: Copyright (c) 2014-2016 Yegor Bugayenko
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
