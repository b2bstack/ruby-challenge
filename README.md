# B2B STACK - Developer Ruby Backend

Fork this repository, complete challenge, submit pull request and provide product preview URL.

<br />

## Project Guidelines
Create an API that allows users to manage their TO-DO list
Provide API documentation

<br />

## Product Specifications
The API must have the following features:
* Create an item
* Remove an item
* Archive an item
* Mark an item as read
* Mark an item as executed
* List items according to their status
* Pagination

<br />

## Technical Guidelines
* ROR
* MySQL or PostgreSQL
* REST
* JSON

<br />

## About the documentation
At this stage of the selection process we want the decisions behind the code, so it is essential that the README has some information that understands your solution.

<br />


## Requirements
* Ruby 3.0.1
* Rails >= 7.0.2.3
* PostgreSQL
* RSpec


<br/>


## Optional
* SMTP server(configured with environment variables)


<br />

## Install Instructions(run it)

                git clone https://github.com/JesusGautamah/ruby-challenge.git
                cd ruby-challenge
                bundle install

<br />


## Database Configuration
 * PostgreSQL:
I'm using to diferrent hosts for the development and test environments.
Edit sample_exports.sh and run it to create the database and tables:

        source sample_exports.sh
        rake db:create
        rake db:migrate

        # Setup instead of rake db:create db:migrate

        source sample_exports.sh
        rake db:setup # This will create the database and tables

<br />


## SMTP Configuration
 * SMTP:
 I'm using external smtp server. Edit sample_exports.sh and run it to define the SMTP settings:

        source sample_exports.sh

<br />

<br />


## U only need to run "source sample_exports.sh" one time to setup the environment


<br />

<br />


## Initialize the database server if u r running it locally

        sudo service postgresql start


<br />


## Run the server

        bundle exec rails server

        # or

        rails s

<br />


## Test the server(Models and Requests for now only)

        bundle exec rspec


<br />


## User Authentication 
* Devise: Configured without devise_token_auth gem, but it is a good practice to use it.
* JWT: Configured with jwt gem.

        # Request post /api/users/sign_up params

        { "user": 
            { "email": ",
            "username": "",
            "password": "",
            }
        }

        # Response

        {
                "message": "You have successfully signed up, please activate your account by clicking the activation link that has been sent to your email address."
        }

        # Request post /api/users/login params

        { "user":
          { "email": "",
            "password": "",
          }
        }

        # Response

        { "message": "You have successfully logged in",
          "token": "YOUR JWT TOKEN",
        }

        # To use API with JWT
        # Add the following headers to your request:
        # Authorization: YOUR JWT TOKEN



## Some hints of what we expect to see are:
Basic instructions on how to run the project;
Details about your solution, we would like to know what was your rationale in the decisions;
In case something is not clear and you need to recognize some premise, which means it motivated you to make decisions.
