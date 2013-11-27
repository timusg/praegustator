Feature: Praegustator
  In order to validate environment
  As a CLI
  I want to check the apache installed

  Scenario: check nginx
    When I run `praeg validate`
    Then the output should contain "should be installed"

  Scenario: check taste
    When I run `praeg taste role:foo nginx`
    Then the output should contain "should be installed"
