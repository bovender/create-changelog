Feature: Creating a complete, decorated changelog

Scenario: Repository with changelog lines only in commit messages
	Given an empty Git repository
	When 2 commits with identical changelog lines are added
	And I successfully run `ccl`
	Then the stdout should contain 1 line starting with "- "

Scenario: Repository with changelog lines only in commit messages
	Given an empty Git repository
	When 2 commits with identical changelog lines are added
	When I successfully run `ccl --no-recent`
	Then the stdout should not contain anything
