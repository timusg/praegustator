Feature: Anbu
  In order to validate environment
  As a CLI
  I want to be as objective as possible

  Scenario: run inspect
    When I run "praegustator taste"
    Then the output should contain "executed"
