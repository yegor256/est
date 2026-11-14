# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est/methods/champions'
require 'minitest/autorun'
require 'yaml'

# Est main module test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2026 Yegor Bugayenko
# License:: MIT
class TestChampions < Minitest::Test
  def test_basic_calculation
    assert_equal(
      89,
      Est::Champions.new(
        YAML.safe_load(
          '
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
        '
        )
      ).total
    )
  end

  def test_scope_size_not_divisible_by_champions
    assert_equal(
      16,
      Est::Champions.new(
        YAML.safe_load(
          '
          scope:
            1: First item
            2: Second item
            3: Third item
          champions:
            1:
              best-case: 10
              worst-case: 10
              most-likely: 10
            2:
              best-case: 10
              worst-case: 10
              most-likely: 10
        '
        )
      ).total
    )
  end
end
