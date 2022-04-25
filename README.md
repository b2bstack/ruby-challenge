# Challenge TODO

This solution bassically use 3 models:

* User (Manage the users)
  * Has many Todos
* Todo (Manage the todos. E.g: List of task)
  * Belongs to User
  * Has many TodoItems
* TodoItems (Manage the todo items. E.g: Items of task)
  * Belongs to Todo

Gems used:
* To the token I used: "jwt"
* For more security I used: "rack-cors, rack-attack"
* Simplify environment: "dotenv"
* For API documentation: "apipie"
* For pagination: "kaminari"

## API Documentation
To see the API documentation, you can access the path of application:

  E.g: `http://localhost:3000/api/doc/`

P.s. The documentation of return of payload is pending to make.

## Initialize
To run locally you need this requisits:
### Requisits
* Ruby 3.1.2
* Docker (docker-compose)

If you have this requisits above, you can run the following command:

 1. Run the command in root path of the project:
    ```
    $ docker-compose up
    ```
 2. Install dependencies:
    ```
    $ bundle install
    ```
 3. Run the migrations:
    ```
    $ rails db:create
    $ rails db:migrate
    ```
 4. Up the rails API server:
    ```
    $ rails s -e production
    ```
## Pending
This my items I didn't not finish yet:
* Code Coverage Test
* Deploy and provide remote URL
* Serialize object using gem jsonapi-rails
