# (The MIT License)
# 
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT
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

  Scenario: Estimates absent directory
    Given I have a "test.txt" file with content:
    """
    hello
    """
    When I run bin/est with "--dir=./absent-dir --format=text"
    Then Exit code is zero
    And Stdout contains "Total: 0"
