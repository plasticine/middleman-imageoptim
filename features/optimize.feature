Feature: Generating SVG clowncars during preview mode

  Scenario: Basic optimization
    Given a fixture app "imageoptim-app"
    When I cd to "source"
    Then the following files should exist:
      | images/haters.jpg                       |
    Then the file "images/haters.jpg" should be 10088 bytes
    Then I cd to ".."
    Given a successfully built app at "imageoptim-app" with flags "--verbose"
    When I cd to "build"
    Then the following files should exist:
      | images/haters.jpg                       |
    Then the file "images/haters.jpg" should be 8958 bytes

  Scenario: Storing timpestamps to avoid re-optiming
    Given a fixture app "imageoptim-app"
    Given a successfully built app at "imageoptim-app" with flags "--verbose"
    Then the following files should exist:
      | build/imageoptim.manifest.bin                       |
    Then the manifest should have the right timestamp for "build/images/haters.jpg"

  Scenario: Skipping optimingptimization when the timestamp hasn't changed
    Given a fixture app "imageoptim-app"
    Given a successfully built app at "imageoptim-app" with flags "--verbose"
    Given a modification time for a file named "build/images/haters.jpg"
    Given some time has passed
    Given a successfully built app at "imageoptim-app" with flags "--verbose"
    Then the file "build/images/haters.jpg" should not have been updated

  Scenario: Regenerating the build image if the source has changed
    Given a fixture app "imageoptim-app"
    Given a successfully built app at "imageoptim-app" with flags "--verbose"
    Given a modification time for a file named "build/images/haters.jpg"
    Given some time has passed
    Given an updated file at "source/images/haters.jpg"
    Given a successfully built app at "imageoptim-app" with flags "--verbose"
    Then the file "build/images/haters.jpg" should have been updated
