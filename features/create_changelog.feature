Feature: Creating a complete, decorated changelog

Scenario: Repository with identical changelog lines only in commit messages
	Given an empty Git repository
	When 2 commits with identical changelog lines are added
	And I successfully run `ccl`
	Then the stdout should contain 1 line starting with "- "

Scenario: Log lines only in commit messages, generate without recent
	Given an empty Git repository
	When 2 commits with identical changelog lines are added
	When I successfully run `ccl --no-recent`
	Then the stdout should not contain anything

Scenario: Repository with multiple changelog lines only in commit messages
	Given an empty Git repository
	When 3 commits with unique changelog lines are added
	And I successfully run `ccl`
	Then the stdout should contain 3 lines starting with "- "
