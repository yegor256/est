[![Managed by Zerocracy](http://www.zerocracy.com/badge.svg)](http://www.zerocracy.com)
[![DevOps By Rultor.com](http://www.rultor.com/b/yegor256/est)](http://www.rultor.com/p/yegor256/est)
[![We recommend RubyMine](http://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![Build Status](https://travis-ci.org/yegor256/est.svg)](https://travis-ci.org/yegor256/est)
[![Gem Version](https://badge.fury.io/rb/est.svg)](http://badge.fury.io/rb/est)
[![Dependency Status](https://gemnasium.com/yegor256/est.svg)](https://gemnasium.com/yegor256/est)
[![Code Climate](http://img.shields.io/codeclimate/github/yegor256/est.svg)](https://codeclimate.com/github/yegor256/est)
[![Coverage Status](https://img.shields.io/coveralls/yegor256/est.svg)](https://coveralls.io/r/yegor256/est)

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
date: 19-12-2017
author: Yegor Bugayenko
method: champions.pert
scope:
  1: basic Sinatra scaffolding
  2: front-end HAML files
  3: SASS stylesheet
  4: five model classes + unit/integration tests
  5: PostgreSQL migrations
champions:
  2:
    worst-case: 40
    best-case: 10
    most-likely: 18
  5:
    worst-case: 30
    best-case: 8
    most-likely: 16
```

All estimates found in a directory will be combined and a final
project estimate will be produced:

```bash
$ est --dir=./est
Total: 27
2014-12-19: 27 hours by Yegor Bugayenko
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

## Best Practices

**Don't Look Back**. Try not to look into previous estimates
made in the project. It's tempting, but try to control yourself. Create
your own estimate first and then look at others that already exist in
the project.

**Coding Time Only**. Estimate code writing time only. Don't estimate
time you would spend on discussions, thinking, modeling, diagramming,
documenting etc. The estimate should count only the time you, as a single
programmer in the project, would spend on code writing.

**Estimate Regularly**. Re-estimate the entire project from scratch regularly.
In each estimate look at the project as a whole and estimate the entire
scope. Not what's left, but the entire scope, as if you would need to
re-create it all from scretch. Even if the project is close to its end,
don't stop re-estimating it.

**Change Estimators**. Try to ask everybody in the project to estimate it
time to time (programmers only). Changing estimators will help the project
to keep numbers out of bias.

**Count On Your Skills**. Estimate the amount of work you would need to
develop the product, not some abstract programmer. Rely on your personal
skills, speed and expertise.
