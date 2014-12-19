[![Made By Teamed.io](http://img.teamed.io/btn.svg)](http://www.teamed.io)
[![DevOps By Rultor.com](http://www.rultor.com/b/teamed/est)](http://www.rultor.com/p/teamed/est)

[![Build Status](https://travis-ci.org/teamed/est.svg)](https://travis-ci.org/teamed/est)
[![Gem Version](https://badge.fury.io/rb/est.svg)](http://badge.fury.io/rb/est)
[![Dependency Status](https://gemnasium.com/teamed/est.svg)](https://gemnasium.com/teamed/est)
[![Code Climate](http://img.shields.io/codeclimate/github/teamed/est.svg)](https://codeclimate.com/github/teamed/est)
[![Coverage Status](https://img.shields.io/coveralls/teamed/est.svg)](https://coveralls.io/r/teamed/est)

Install it first:

```bash
$ gem install est
```

Run it locally and read its output:

```bash
$ est --help
```

Every estimate should be in its own file, with `.yml` extension (YAML format).
Here is an example of an estimate file for a simple web app:

```yaml
date: 19-12-2014
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
```

All estimates found in a directory will be combined and a final
project estimate will be produced:

```bash
$ est --dir=./est
Estimate: 90 hours
Accuracy (%): +300/-45
Precision (%): 6.5
```
