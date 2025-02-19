# encoding: utf-8
#
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'est/version'

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  if s.respond_to? :required_rubygems_version=
    s.required_rubygems_version = Gem::Requirement.new('>= 0')
  end
  s.rubygems_version = '2.2.2'
  s.required_ruby_version = '>= 1.9.3'
  s.name = 'est'
  s.version = Est::VERSION
  s.license = 'MIT'
  s.summary = 'Estimates Automated'
  s.description = 'Estimate project size'
  s.authors = ['Yegor Bugayenko']
  s.email = 'yegor256@gmail.com'
  s.homepage = 'http://github.com/teamed/est'
  s.files = `git ls-files`.split($RS)
  s.executables = s.files.grep(/^bin\//) { |f| File.basename(f) }
  s.test_files = s.files.grep(/^(test|spec|features)\//)
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE.txt']
  s.add_runtime_dependency 'nokogiri', '>0'
  s.add_runtime_dependency 'slop', '3.6.0'
end
