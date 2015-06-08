thumbor_ng CHANGELOG
====================

This file is used to list changes made in each version of the thumbor_ng cookbook.

0.3.7
-----

- Virender Khatri - bump thumbor version to 5.0.3

- Virender Khatri - fix rubocop error

0.3.5
-----

- Virender Khatri - disable nginx status by default, added optional attribute

0.3.3
-----

- Virender Khatri - bump thumbor version to v4.12.2

- Richard Lee - PR #10, added nginx status

0.3.1
-----

- Virender Khatri - added gifsicle package for gif images

- Virender Khatri - bump thumbor version to v4.8.6

- Virender Khatri - temporarily fix to keep travis status green

0.2.8
-----

- Richard Lee - PR #9, made pip dependencies configurable via attribute `node['thumbor_ng']['pip_dependencies']`

0.2.7
-----

- Richard Lee - PR #8, added pip package for opencv-engine

- Virender Khatri - bump thumbor version to 4.8.0

0.2.5
-----

- Virender Khatri - added cron job for purging thumbor file storage

- Virender Khatri - bump thumbor version to 4.7.1

0.2.3
-----

- Virender Khatri - fixing ulimit for nginx, issue #4

- Virender Khatri - updated thumbor nginx vhost to probable cause of 499 errors

0.2.1
-----

- Virender Khatri - fixed thumbor service over writes worker logs issue

- Virender Khatri - fixed thumbor service ulimit, added to worker upstart init

- Virender Khatri - added key for saucy thumbor ppa

- Virender Khatri - added logrotate resource for nginx, required for custom log, perhaps nginx cookbook
                    would be the right place to fix this.

0.1.7
-----

- Virender Khatri - added travis ci support

- Virender Khatri - fixed foodcritic

0.1.5
-----

- Virender Khatri - bump thumbor version to 4.6.0

- Virender Khatri - added log level attribute `default['thumbor_ng']['log_level']`

- Virender Khatri - added support for ubuntu 14.04

- Virender Khatri - filtered packages dependecnies for ubuntu 12+

- Virender Khatri - thumbor service config file classified for `node['platform_family']`

- Virender Khatri - Removed default attributes with default values

0.1.0
-----

- Virender Khatri - First commit

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
