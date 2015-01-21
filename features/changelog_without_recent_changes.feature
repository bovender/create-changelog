Feature: Create a changelog that does not contain recent changes.

Scenario: Repository with identical changelog lines only in commit messages
	Given an empty Git repository
	When 2 commits with standard changelog line are added
	And I successfully run `ccl --no-recent`
	Then the stdout should not contain anything

Scenario: Repository with multiple changelog lines only in commit messages
	Given an empty Git repository
	When 3 commits with unique changelog line are added
	And I successfully run `ccl --no-recent`
	Then the stdout should not contain anything
