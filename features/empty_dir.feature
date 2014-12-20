Feature: Command Line Processing
  As an estimator I want to be able to
  call Est as a command line tool

  Scenario: Estimates empty directory
    Given I have a "test.txt" file with content:
    """
    hello
    """
    When I run bin/est with "--dir=. --format=text"
    Then Exit code is zero
    And Stdout contains "Total: 0"
