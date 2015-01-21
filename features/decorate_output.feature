@announce
Feature: Output may be decorated

Scenario: Creating complete changelog
	Given an empty Git repository
	When 2 commits with standard changelog line are added
	And I successfully run `ccl`
	Then the stdout should contain "====="
	And the stdout should contain "* * *"

Scenario: Creating changelog without recent changes
	Given an empty Git repository
	When 2 commits with standard changelog line are added
	And I successfully run `ccl --no-recent`
	Then the stdout should not contain anything

Scenario: Creating changelog with recent changes only
	Given an empty Git repository
	When 2 commits with standard changelog line are added
	And I successfully run `ccl --recent`
	Then the stdout should not contain "====="
	And the stdout should not contain "* * *"

Scenario: Creating changelog with custom 'recent' heading
	Given an empty Git repository
	When 2 commits with standard changelog line are added
	And I successfully run `ccl TEST_VERSION`
	Then the stdout should contain "TEST_VERSION"
	And the stdout should contain "====="
	And the stdout should contain "* * *"
