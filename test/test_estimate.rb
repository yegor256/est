# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'nokogiri'
require 'est/estimates'
require 'tmpdir'
require 'slop'

# Est main module test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2026 Yegor Bugayenko
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
