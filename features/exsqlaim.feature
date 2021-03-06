Feature: Using variables in sql

Scenario: Attempt to update query at point
  When I insert:
  """
  @userId = 1234

  SELECT name FROM users WHERE id = @userId;
  """
  And I go to end of buffer
  And I press "C-c C-i"
  Then I should not see "SELECT name FROM users WHERE id = 1234\p;"

Scenario: Update query at point
  When I insert:
  """
  @userId = 1234

  SELECT name FROM users WHERE id = @userId;

  """
  And I go to end of buffer
  And I turn on exsqlaim-mode
  And I press "C-c C-i"
  Then I should see "SELECT name FROM users WHERE id = 1234\p;"

Scenario: Font-lock should be set with exsqlaim-mode is turned on and off
  When I insert:
  """
  @userId = 1234

  SELECT name FROM users WHERE id = @userId;
  """
  And I go to word "userId"
  Then current point should have no face
  When I turn on sql-mode
  Then current point should have no face
  When I turn on exsqlaim-mode
  Then current point should have the font-lock-variable-name-face face
  When I turn off minor mode exsqlaim-mode
  Then current point should have no face

Scenario: Update query at point (semi-colon replacement)
  When I insert:
  """
  SELECT "test;test" FROM dual;

  """
  And I go to end of buffer
  And I turn on exsqlaim-mode
  And I press "C-c C-i"
  Then I should see "SELECT "test;test" FROM dual\p;"
