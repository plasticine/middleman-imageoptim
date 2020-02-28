Feature: Manifest
  Scenario: Don't reoptimize images that have already been optimized
    Given a fixture app "basic-app"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the following files should exist:
      | build/imageoptim.manifest.yml |
    Then the manifest at "build" should have the right timestamp for "build/images/table.jpg"

  Scenario: Save manifest at custom path
    Given a fixture app "basic-app"
    And app "basic-app" is using config "custom-manifest-path"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the following files should exist:
      | custom/manifest/path/imageoptim.manifest.yml |
    Then the manifest at "custom/manifest/path" should have the right timestamp for "build/images/table.jpg"

  Scenario: Don't write a manifest file if it is disabled
    Given a fixture app "basic-app"
    And app "basic-app" is using config "disabled-manifest"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the following files should not exist:
      | build/imageoptim.manifest.yml |

  Scenario: Skipping optimization when the timestamp hasn't changed
    Given a fixture app "basic-app"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Given a modification time for a file named "build/images/table.jpg"
    Given some time has passed
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the file "build/images/table.jpg" should not have been updated

  Scenario: Regenerating the build image if the source has changed
    Given a fixture app "basic-app"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Given a modification time for a file named "build/images/table.jpg"
    Given some time has passed
    Given an updated file at "source/images/table.jpg"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the file "build/images/table.jpg" should have been updated
