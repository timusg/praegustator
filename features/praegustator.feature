Feature: Praegustator
  In order to validate environment
  As a CLI
  I want to check the apache installed

  Scenario: validate
    When I run `praeg validate`
    Then the output should contain "should be installed"

  Scenario: taste
    When I run `praeg taste role:* nginx`
    Then the output should contain "should be installed"

  Scenario: no node found
    When I run `praeg taste role:foo nginx`
    Then the output should contain "no node found for search criteria: role:foo\n"
