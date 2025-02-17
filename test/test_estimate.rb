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

require 'minitest/autorun'
require 'nokogiri'
require 'est/estimates'
require 'tmpdir'
require 'slop'

# Est main module test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2025 Yegor Bugayenko
# License:: MIT
class TestEstimate < Minitest::Test
  def test_basic_calculation
    Dir.mktmpdir 'test' do |dir|
      file = File.join(dir, 'first.est')
      File.write(
        file,
        '''
        date: 18-12-2017
        author: Jeff Lebowski
        method: champions.pert
        scope:
          1: basic Sinatra scaffolding
          2: front-end HAML files
          3: SASS stylesheet
          4: five model classes with unit tests
          5: PostgreSQL migrations
          6: Cucumber tests for PostgreSQL
          7: Capybara tests for HTML front
          8: CasperJS tests
          9: achieve 80% test coverage
        champions:
          7:
            worst-case: 40
            best-case: 10
            most-likely: 18
          4:
            worst-case: 30
            best-case: 8
            most-likely: 16
        '''
      )
      estimate = Est::Estimate.new(file)
      assert_equal Date.parse('18-12-2017'), estimate.date
      assert_equal 'Jeff Lebowski', estimate.author
      assert_equal 79, estimate.total
    end
  end
end
