Feature: Pet CRUD

    Scenario: Register a pet
        Given i have a new pet
        When I register the pet in the service "/v2/pet"
        Then the response status code is "200"

    Scenario Outline: Edit a pet
        When I edit the "<name>" of the pet <id> in the service "/v2/pet"
        Then the response status code is "200"

        Examples:
            | id    | name    |
            | 31888 | dogtest |

    Scenario Outline: Searching for a pet
        When I get a pet with "<status>" in the service "/v2/pet/findByStatus"
        Then the response status code is "200"
        And I see a list of registered pets

        Examples:
            | status    |
            | available |