@announce
Feature: Creating a complete, decorated changelog.

Scenario: Repository with identical changelog lines only in commit messages
	Given an empty Git repository
	When 2 commits with standard changelog line are added
	And I successfully run `ccl`
	Then the stdout should contain 1 line starting with "- "

Scenario: Repository with multiple changelog lines only in commit messages
	Given an empty Git repository
	When 3 commits with unique changelog line are added
	And I successfully run `ccl`
	Then the stdout should contain 3 lines starting with "- "

Scenario: Changelog lines in commit messages and tag without changelog line
	Given an empty Git repository
	When 3 commits with unique changelog line are added
	And a tag without changelog line is added
	And I successfully run `ccl`
	Then the stdout should contain 3 lines starting with "- "

Scenario: Changelog lines in commit messages and tag with different changelog line
	Given an empty Git repository
	When 3 commits with unique changelog line are added
	And a tag with unique changelog line is added
	And I successfully run `ccl`
	Then the stdout should contain 4 lines starting with "- "

Scenario: Changelog lines in commit messages and tag with same hangelog line
	Given an empty Git repository
	When 3 commits with standard changelog line are added
	And a tag with standard changelog line is added
	And I successfully run `ccl`
	Then the stdout should contain 1 line starting with "- "
