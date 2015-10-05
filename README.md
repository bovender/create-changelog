[![Gem Version](https://badge.fury.io/rb/create_changelog.svg)](http://badge.fury.io/rb/create_changelog)

create-changelog
================

## Description

Ruby program with command-line interface that creates a changelog from
log lines in a Git repository that can be read and understood by end
users.

There are several approaches to creating changelog files from Git
commits (e.g., [gitchangelog][], [gitlog-to-changelog][gl2cl] and many
more). None of these quite fit my needs, so I decided to create my own
tool.

What's special about my approach is that the changelog information is
not taken from every commit, but from specially marked lines in the
commit messages and tag annotations. Changelog lines must comply with
the format:

	- [KEYWORD]: [TEXT]

Where `[KEYWORD]` may be any keyword of your liking, such as "NEW",
"FIX", and so on. (I am planning to predefine these keywords in a later
version.) `[TEXT]` is an explanation of the change. _Note that the
program currently operates on single lines, so it is not possible to
have `[TEXT]` span several lines._

The reason why I chose to have special changelog lines rather than
commit subjects is that commits are rather technical, but I want to have
a changelog that can be read by 'normal' end users.

create-changelog assumes that each tag in the repository represents a
release version. The changelog for a version consists of the tag's name,
the tag's annotation, and the unique combined, filtered changelog lines
of the tag annotation and all commits since the previous tag.


## Usage

### Creating log entries

When committing, add a line to the commit message that fits the above
definition, e.g.

	Implement Backup class.

	- NEW: Ability to back up the files.

When releasing a new version, create an annotated tag:

	Version 7.0.0-alpha.3

	This version adds a new backup feature and fixes several bugs.

If you wish, you can include additional changelog entries in the tag
annotation. These may even be the same that you used for the commit
messages (and this tool provides a way to filter the commit messages for
just these lines). The tool ensures that there are no duplicate
changelog entries.

	Version 7.0.0-alpha.3

	This version adds a new backup feature and fixes several bugs.

	- NEW: Ability to back up the files.


### Generating the log

To generate a complete change log, simply run the tool in the directory
of the Git repository, or indicate a working directory:

	ccl -d /home/me/my/repository

The output will be in markdown format. If you wish, you can further
process it using tools like [pandoc][] for example. Of course, it is
also possible to incorporate the command in the content files for a
static site generator such as [nanoc][].

If you want to track your log in the Git repository, you will not yet
have an annotated tag for the version you are preparing at the time when
you generate the changelog. In this case, the tool will use "Unpublished
changes" as the heading for the latest changes. To rather use the
version number that you are about to use in the tag, execute the tool
with an optional argument:

	ccl "Version 7.0.0-alpha.4"

You then use this same version number for your release tag.

Be aware that currently, the date of the most recent commit (that HEAD
points to) will be appended to the heading.

To exclude recent changes that were logged since the last tag:

	ccl --no-recent
	ccl -n

To just see the (undecorated) changelog entries since the last tag, use:

	ccl --recent
	ccl -r

This can be handy if you want to add a log of recent changes to your tag
annotation. For example, using the Vim text editor, issue:

	:r!ccl -r

The tool will make sure that no changelog lines are duplicated.


## Changelog format

The changelog format resembles the [suggestions][kacl] made by Olivier
Lacan, but it does not fully comply with Olivier's specification. I have
not yet have the time to implement automatic generation of subheadings.
Maybe I'll add the feature in the future.


## To do

- Add automatic subheadings
- Add ability to handle multi-line change log entries
- Add to-do list feature


## Example

<http://xltoolbox.net/changelog-ng>

... or of course [CHANGELOG.md][] in this repository.


## Code

The code is documented in [Yard][] style. The `doc` subdirectory is
git-ignored so you can safely generate the docs.


## License

Copyright 2015 Daniel Kraus <bovender@bovender.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[gitchangelog]: https://pypi.python.org/pypi/gitchangelog
[gl2cl]: https://github.com/manuelbua/gitver/blob/master/gitlog-to-changelog
[gnu-changelog]: http://www.gnu.org/prep/standards/html_node/Change-Logs.html
[pandoc]: http://johnmacfarlane.net/pandoc
[nanoc]: http://nanoc.ws
[kacl]: http://keepachangelog.com
[CHANGELOG.md]: CHANGELOG.md
[Yard]: http://www.rubydoc.info/gems/yard

<!-- vim: set tw=72 : -->
