# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'est'
require 'nokogiri'
require 'tmpdir'
require 'slop'
require 'English'

Before do
  @cwd = Dir.pwd
  @dir = Dir.mktmpdir('test')
  FileUtils.mkdir_p(@dir) unless File.exist?(@dir)
  Dir.chdir(@dir)
  @opts = Slop.parse ['-v', '-s', @dir] do
    on 'v', 'verbose'
    on 's', 'source', argument: :required
  end
end

After do
  Dir.chdir(@cwd)
  FileUtils.rm_rf(@dir) if File.exist?(@dir)
end

Given(/^I have a "([^"]*)" file with content:$/) do |file, text|
  FileUtils.mkdir_p(File.dirname(file)) unless File.exist?(file)
  File.open(file, 'w') do |f|
    f.write(text)
  end
end

When(/^I run est$/) do
  @xml = Nokogiri::XML.parse(Est::Base.new(@opts).xml)
end

Then(/^XML matches "([^"]+)"$/) do |xpath|
  fail "XML doesn't match \"#{xpath}\":\n#{@xml}" if @xml.xpath(xpath).empty?
end

When(/^I run est it fails with "([^"]*)"$/) do |txt|
  begin
    Est::Base.new(@opts).xml
    passed = true
  rescue Est::Error => ex
    unless ex.message.include?(txt)
      raise "Est failed but exception doesn't contain \"#{txt}\": #{ex.message}"
    end
  end
  fail "Est didn't fail" if passed
end

When(/^I run bin\/est with "([^"]*)"$/) do |arg|
  home = File.join(File.dirname(__FILE__), '../..')
  @stdout = `ruby -I#{home}/lib #{home}/bin/est #{arg}`
  @exitstatus = $CHILD_STATUS.exitstatus
end

Then(/^Stdout contains "([^"]*)"$/) do |txt|
  unless @stdout.include?(txt)
    fail "STDOUT doesn't contain '#{txt}':\n#{@stdout}"
  end
end

Then(/^Stdout is empty$/) do
  fail "STDOUT is not empty:\n#{@stdout}" unless @stdout == ''
end

Then(/^XML file "([^"]+)" matches "([^"]+)"$/) do |file, xpath|
  fail "File #{file} doesn't exit" unless File.exist?(file)
  xml = Nokogiri::XML.parse(File.read(file))
  xml.remove_namespaces!
  if xml.xpath(xpath).empty?
    fail "XML file #{file} doesn't match \"#{xpath}\":\n#{xml}"
  end
end

Then(/^Exit code is zero$/) do
  fail "Non-zero exit code #{@exitstatus}" unless @exitstatus == 0
end

Then(/^Exit code is not zero$/) do
  fail 'Zero exit code' if @exitstatus == 0
end

When(/^I run bash with$/) do |text|
  FileUtils.copy_entry(@cwd, File.join(@dir, 'est'))
  @stdout = `#{text}`
  @exitstatus = $CHILD_STATUS.exitstatus
end
