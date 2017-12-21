Version 1.4.2 (2017-12-21)
------------------------------------------------------------------------

- Improved: Updated third-party components including the source code documentation component, yard, thereby fixing SECURITY VULNERABILITY CVE-2017-17042. Note that this does not affect normal operation of the tool.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.4.1 (2016-04-03)
------------------------------------------------------------------------

- Fix Debian packaging.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.4.0 (2016-04-03)
------------------------------------------------------------------------

- CHANGED: Output uses second-level rather than first-level headings now.
- FIX: Prevent Git error message due to local .gitconfig configuration.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.3.4 (2015-10-05)
------------------------------------------------------------------------

- NEW: Create Ubuntu package (ppa:bovender/bovender)

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.3.2 (2015-06-24)
------------------------------------------------------------------------

- FIX: Properly sort and identify latest tags (tags are sorted as version numbers).

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.3.1 (2015-06-24)
------------------------------------------------------------------------

- CHANGED: Added author and license information to program banner.
- FIX: Do not crash on --no-recent if there aren't indeed recent changes.
- NEW: Check if Git is installed and issue error message if it isn't.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.3.0 (2015-01-21)
------------------------------------------------------------------------

Version 1.3.0 adds a test suite that enables quality control during
development, and fixes a number of bugs that appeared during testing.

- CHANGE: Omit empty lines at end of changelog.
- FIX: Do not crash if Git repository is empty.
- FIX: Do not produce any output if no changelog information found.
- FIX: Ensure unique lines if initial commit is included.
- FIX: Include the very first commit's message in the changelog.
- FIX: Omit recent changes section if there are no recent changes.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.2.0 (2015-01-18)
------------------------------------------------------------------------

- FIX: Make "-r", "--recent" option actually work.
- FIX: Prevent combining -n and -r switch irrespective of order.
- NEW: Switch "-v", "--version" to print out the current version.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.1.0 (2015-01-18)
------------------------------------------------------------------------

- CHANGED: Accept dashes in addition to asterisks in changelog lines.
- NEW: Create gem.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


Version 1.0.0 (2015-01-18)
------------------------------------------------------------------------



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
