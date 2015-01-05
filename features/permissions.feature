Feature: Permissions
  Scenario: Preserving permissions
    Given a fixture app "basic-app"
    Given the file "source/images/table.jpg" has mode "0644"
    Given the file "source/images/oh_my_glob.gif" has mode "0644"
    Then the following files should exist:
      | source/images/table.jpg      |
      | source/images/oh_my_glob.gif |
    Then the mode of filesystem object "source/images/table.jpg" should match "0644"
    Then the mode of filesystem object "source/images/oh_my_glob.gif" should match "0644"
    Given a successfully built app at "basic-app" with flags "--verbose"
    Then the following files should exist:
      | build/images/table.jpg      |
      | build/images/oh_my_glob.gif |
    Then the mode of filesystem object "build/images/table.jpg" should match "0644"
    Then the mode of filesystem object "build/images/oh_my_glob.gif" should match "0644"
