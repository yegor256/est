# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'est/version'

Gem::Specification.new do |s|
  if s.respond_to?(:required_rubygems_version=)
    s.required_rubygems_version = Gem::Requirement.new('>= 0')
  end
  s.required_ruby_version = '>= 2.0'
  s.name = 'est'
  s.version = Est::VERSION
  s.license = 'MIT'
  s.summary = 'Estimates Automated'
  s.description = 'Estimate project size'
  s.authors = ['Yegor Bugayenko']
  s.email = 'yegor256@gmail.com'
  s.homepage = 'https://github.com/teamed/est'
  s.files = `git ls-files | grep -v -E '^(test/|\\.|renovate)'`.split($RS)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE.txt']
  s.add_dependency('nokogiri', '>0')
  s.add_dependency('slop', '3.6.0')
  s.metadata['rubygems_mfa_required'] = 'true'
end
