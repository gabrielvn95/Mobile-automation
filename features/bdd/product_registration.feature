Feature: Product registration
  As a user 
  I should be able to
  Manage market inventory

  Scenario: Register a product
    Given I am registering a product in inventory
    When I enter valid product informations
    Then product will be registred sucessefully 

  Scenario: Edit a product
    Given I already registering a product
    When I edit this product informations
    Then product will be edited sucessefully

  Scenario: Delete a product
    Given I have a product in inventory
    When I delete this product
    Then product will be deleted successfully

  Scenario Outline: Decrease product amount
    Given I have a product amount "<amount>"
    When I decrease this product amount
    Then product amount will be decreased to "<newValue>" successfully

    Examples:
      | amount | newValue |
      | 10     | 9        |