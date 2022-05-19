# Ruby Challenge
## About
Task management application developed in Ruby that aims to meet the proposed challenge.

## Project dependencies
* ruby 3.1.2
* rails 7.0.3
* PostgreSQL

## Project instalation

### Clone the project
* `git clone https://github.com/Hendrew/ruby-challenge.git`

### Enter in folder
* `cd ruby-challenge`
### Intall the gems
* `bundle install`

### Running tests
* `bundle exec rspec`

### Running app
* `rails s`

If everything is ok, you can check the app running on http://localhost:3000

## Little API documentation
### Task list
`
GET /api/v1/tasks/?status=read
`

You can pass the *`status`* as a parameter to filter the result: read, excuted and archived

### Create task
`
POST /api/v1/tasks
`

### Delete task
`
POST /api/v1/tasks/{id}
`

## Project online

[Access the project online](https://rubychellangeb2b.herokuapp.com)

## Final considerations

In this project, in addition to the standard Rails framework gems, the following were also highlighted:

* `pagy` for pagination purposes
* `jsonapi-serializer` for serialization purposes
* `rspec` for test purposes
* `rswag` for documentation purposes
