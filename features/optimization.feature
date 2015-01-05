Feature: Optimization
  Scenario: Basic optimization
    Given a fixture app "basic-app"
    When I cd to "source"
    Then the following files should exist:
      | images/table.jpg |
    Then the file "images/table.jpg" should be 225252 bytes
    Then I cd to ".."
    Given a successfully built app at "basic-app" with flags "--verbose"
    When I cd to "build"
    Then the following files should exist:
      | images/table.jpg |
    Then the file "images/table.jpg" should be less than 225252 bytes
