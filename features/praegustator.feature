Feature: Praegustator
  In order to validate environment
  As a CLI
  I want to check the apache installed

  Scenario: check apache
    When I run "praeg taste"
    Then the output should contain "executed"
