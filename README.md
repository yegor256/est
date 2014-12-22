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

Every estimate should be in its own file, with `.est` extension (YAML format).
Here is an example of an estimate file `simple.est` for a simple web app:

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

## Scope Champions

Scope Champions estimating method was introduced a
patent application [US 12/193,010](https://www.google.com/patents/US20100042968).
This article explains it in more details:
[Revolutionary Method Of Cost Estimating](http://www.technoparkcorp.com/innovations/scope-champions/).
In a nutshell, there are three steps.

First, you break down the entire implementation scope into items, like
it's done above, and list them under `scope`. Pay attention, you should list
only technical code-writing tasks. Testing, requirements analysis, thinking
and talking should not go into this list. Imagive, what would you do
if you would be the only programmer working with the product. Imagine, you
have to create the product from scratch, being the only programmer in house.
It is important to keep all work items on the same level of abstraction. This
means that the complexity of all items should be approximately the same.

Second, select a few items from the list (2-3), which are the most difficult
to implement. They are called "scope champions". List their numbers
under `champions`, as it's done above.

Third, estimate that champions using [three-point estimating method](https://en.wikipedia.org/wiki/Three-point_estimation).
As in the example above, every scope champion should get three numbers.
Worst case is how many hours you would spend on it, if everything would
appear to be very difficult and most probable risks would happen. Best
case is how many hours would this work take if everything would go easy
and without any risks. Most likely is how much would it take, in a normal
situation, according to your estimate.


