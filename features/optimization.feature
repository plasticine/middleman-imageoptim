Feature: Optimization
  Scenario: Basic optimization
    Given a fixture app "basic-app"
    Then the following files should exist:
      | source/images/table.jpg      |
    Then the file "source/images/table.jpg" should be 225252 bytes
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the following files should exist:
      | build/images/table.jpg |
    Then the file "build/images/table.jpg" should be less than 225252 bytes
