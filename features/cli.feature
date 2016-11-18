Feature: Command Line Processing
  As an estimator I want to be able to
  call Est as a command line tool

  Scenario: Help can be printed
    When I run bin/est with "-h"
    Then Exit code is zero
    And Stdout contains "-v, --verbose"

  Scenario: Version can be printed
    When I run bin/est with "--version"
    Then Exit code is zero

  Scenario: Simple estimate calculating, in XML
    Given I have a "sample.est" file with content:
    """
    date: 19-08-2014
    author: Yegor Bugayenko
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
    """
    When I run bin/est with "-v -d . -t xml -f out.xml"
    Then Exit code is zero
    And Stdout contains "reading ."
    And XML file "out.xml" matches "/estimate[total='79']"

  Scenario: Simple estimate calculating, in Text
    Given I have a "sample.est" file with content:
    """
    date: 19-08-2014
    author: Yegor Bugayenko
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
    """
    When I run bin/est with "-d ."
    Then Exit code is zero
    And Stdout contains "Total: 79"
    And Stdout contains "2014-08-19: 79 hours by Yegor Bugayenko"

  Scenario: Rejects unknown options
    Given I have a "test.est" file with content:
    """
    """
    When I run bin/est with "--some-unknown-option"
    Then Exit code is not zero
