# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'nokogiri'
require 'est'
require 'tmpdir'
require 'slop'

# Est main module test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2014-2025 Yegor Bugayenko
# License:: MIT
class TestEst < Minitest::Test
  def test_basic
    Dir.mktmpdir 'test' do |dir|
      opts = opts(['-v', '-d', dir])
      File.write(
        File.join(dir, 'sample.est'),
        '''
        date: 12-07-2017
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
        '''
      )
      matches(
        Nokogiri::XML(Est::Base.new(opts).xml),
        [
          '/processing-instruction("xml-stylesheet")[contains(.,".xsl")]',
          '/estimate/@version',
          '/estimate/@date',
          '/estimate[total="79"]',
          '/estimate/ests[count(est)=1]'
        ]
      )
    end
  end

  def test_empty_dir
    Dir.mktmpdir 'test' do |dir|
      opts = opts(['-v', '-d', dir])
      matches(
        Nokogiri::XML(Est::Base.new(opts).xml),
        [
          '/estimate/@version',
          '/estimate/@date',
          '/estimate[total="0"]',
          '/estimate[not(ests)]'
        ]
      )
    end
  end

  def test_empty_dir
    Dir.mktmpdir 'test' do |dir|
      opts = opts(['-v', '-d', File.join(dir, 'absent')])
      matches(
        Nokogiri::XML(Est::Base.new(opts).xml),
        [
          '/estimate/@version',
          '/estimate/@date',
          '/estimate[total="0"]',
          '/estimate[not(ests)]'
        ]
      )
    end
  end

  def opts(args)
    Slop.parse args do
      on 'v', 'verbose'
      on 'd', 'dir', argument: :required
    end
  end

  def matches(xml, xpaths)
    xpaths.each do |xpath|
      fail "doesn't match '#{xpath}': #{xml}" unless xml.xpath(xpath).size == 1
    end
  end
end
