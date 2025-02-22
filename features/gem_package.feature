# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT
Feature: Gem Package
  As a source code writer I want to be able to
  package the Gem into .gem file

  Scenario: Gem can be packaged
    Given I have a "execs.rb" file with content:
    """
    #!/usr/bin/env ruby
    require 'rubygems'
    spec = Gem::Specification::load('./spec.rb')
    fail 'no executables' if spec.executables.empty?
    """
    When I run bash with
    """
    set -e
    cd est
    gem build est.gemspec
    gem specification --ruby est-*.gem > ../spec.rb
    cd ..
    ruby execs.rb
    """
    Then Exit code is zero
