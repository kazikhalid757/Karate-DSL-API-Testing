Feature: Validate
  Background: Define Base url
    Given url 'https://reqres.in'

  Scenario: Validate User Login [valid Email]
    Given path '/api/login'
    And request {"email": "eve.holt@reqres.in","password": "cityslicka"}
    When method POST
    And print response
    Then status 200


  Scenario: Validate User Login [Invalid Email]
    Given path '/api/login'
    And request {"email": "eve.holt@reqrdffes.in","password": "cityslicka"}
    When method POST
    And print response
    Then status 400
    And match response.error == "user not found"

  Scenario: Validate User login [Invalid Password]
    Given path '/api/login'
    And request {"email": "eve.holt@reqrdffes.in","password": "cfssfityslicka"}
    When method POST
    And print response
    Then status 400
    And match response.error == "user not found"

  Scenario: Validate User Register [Valid mail & password]
    Given path '/api/register'
    And request {"email": "eve.holt@reqres.in","password": "pistol"}
    When method POST
    And print response
    Then status 200

  Scenario: Validate User Register [Invalid mail]
    Given path '/api/register'
    And request {"email": "eve.holt@reqrdffes.in"}
    When method POST
    And print response
    Then status 400
    And match response.error == "Missing password"

  Scenario: Validate User Register [Invalid mail]
    Given path '/api/register'
    And request {"email": "eve.holt@reqrdffes.in","password": "pistol" }
    When method POST
    And print response
    Then status 400
    And match response.error == "Note: Only defined users succeed registration"

  Scenario: Validate UserCreate [Name & Job]
    Given path '/api/users'
    And request {"name": "morpheus","job": "leader"}
    When method POST
    And print response
    Then status 201


  Scenario: Validate User Update [Name & Job]
    Given path '/api/users/2'
    And request {"name": "morpheus","job": "zion resident"}
    When method PUT
    And print response
    Then status 200

  Scenario: Validate List Users
    Given path '/api/users?page=2'
    When method GET
    And print response
    Then status 200

  Scenario: Validate Find User by ID [Valid Id]
    Given path '/api/users/2'
    When method GET
    And print response
    Then status 200
    And match response.data.id == 2

  Scenario: Validate Find User by ID - Non-existing ID
    Given path '/api/users/9999'
    When method GET
    And print response
    Then status 404

  Scenario: Validate Find User by ID - Invalid ID
    Given path '/api/users/abc'
    When method GET
    And print response
    Then status 404
    And match response == {}

  Scenario:Validate Find User by Firstname
    Given path '/api/users/2'
    When method GET
    And print response
    Then status 200
    And match response.data.first_name == "Janet"


  Scenario: Validate Single Users
    Given path '/api/users/2'
    When method GET
    And print response
    Then status 200

  Scenario: Validate Single User Not Found
    Given path '/api/users/23'
    When method GET
    And print response
    Then status 404
    And match response == {}

  Scenario: Validate Single [RESOURCE]
    Given path '/api/unknown2'
    When method GET
    And print response
    Then status 200

  Scenario: Validate Single [Not found RESOURCE]
    Given path 'api/unknown/23'
    When method GET
    And print response
    Then status 404
    And match response == {}

  Scenario: Validate Delayed Response
    Given path '/api/users?delay=3'
    When method GET
    And print response
    Then status 200


  Scenario: Validate User Update [Name & Job]
    Given path '/api/users/2'
    And request {"name": "morpheus","job": "zion"}
    When method PATCH
    And print response
    Then status 200

  Scenario: Validate User Delete [Name & Job]
    Given path '/api/users/2'
    When method DELETE
    And print response
    Then status 204
    And match response == ''
