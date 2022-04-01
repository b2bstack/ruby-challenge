# Ruby Challenge To Do List Manager - Rails API


## Staging: <http://ruby-challenge-staging.herokuapp.com/>

## Production: <http://ruby-challenge-production.herokuapp.com/>

## DEV Environment: <http://localhost:3000/>


<br />

## Project Guidelines
Create an API that allows users to manage their TO-DO list

<br />

## Python Notebook is inside the project for test the API
## documentation.ipynb
## the same documentation is on the final of this archive.

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
* PostgreSQL
* REST
* JSON

<br />

## Some about the project
Rspec is on the project and the test suite is also on the project.
Model and requests are on the test suite.
Developed with TDD just in the beginning for the test, but it is a good practice to have a test suite for each feature.
At the time has three rspec tests failing because tests its out of date.
In the future, when the project is continuated, the test suite will be completely integrated with the code.

To create users class was used Devise Gem combined with JWT, easy setup and authentication.

ActionMailer Configured to send emails.

Archive Read and Executed was implemented in the Item Model using the enum type on mode attribute,
this help us to know if the item is archived, read or executed and use it to list items by some alternative order.

Todo Lists and Items has pagianation, configured with Pagy Gem.
Verify pagination info in the headers 

For list items by mode, inside Todo Lists and Items Controllers was used params >filter and filter_factor for alternative order by mode(enum status)

Alternative orders were implemented in the Item Model using the enum type on mode attribute,
have a matrix of possible orders and use it to list items by some alternative order.

The mode_order method is returning in_order_of method value, this is a rails 7 new feature,
and is used instead of the old order_by method and avoid some scope to be used in the models.
example:

        MODE_ORDER= [ [1, 2, 3, 0],
                      [2, 3, 0, 1],
                      [3, 0, 1, 2],
                      [0, 1, 2, 3],
                      [1, 3, 2, 0],
                      [2, 1, 0, 3],
                      [3, 2, 1, 0],
                      [0, 3, 2, 1],
                      [1, 0, 3, 2],
                      [2, 0, 1, 3],
                      [3, 1, 0, 2],
                      [0, 2, 1, 3],
                      [1, 3, 0, 2],
                      [2, 3, 1, 0],
                      [3, 0, 2, 1],
                      [0, 1, 3, 2],
                      [1, 2, 0, 3],
                      [2, 1, 3, 0],
                      [3, 2, 0, 1],
                      [0, 3, 1, 2],
                      [1, 0, 2, 3],
                      [2, 0, 3, 1],
                      [3, 1, 2, 0],
                      [0, 2, 3, 1] ]
        
        
        def self.mode_order(factor)
          self.in_order_of(:mode, MODE_ORDER[factor])
        end              

Begin and Rescue was used to catch errors in the code and test suite, and it is a good practice to have a rescue in the code.
It can be used with expect methods and it's goos to handle request errors and render json response errors.

Objects mode can be updated request show method via get with params, to know more about it, see the API documentation.

Used Active Model Serializer to serialize the objects, just for good practice.

Configured Rack Attack and Rack Cors to increase security and prevent attacks.

<br />


### Devise
Used for rapid setup of user authentication, was combined with JWT to generate a token for each user.
Each token is valid for 


## Create an Item


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
I'm using two diferrent hosts for the development and test environments.
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



## Things that i want to improve in the future

* ActiveRecord Concerns validations to help models to be more organized and good practice to use them.
* Sidekiq for background jobs, to process the emails and schedule tasks(cron jobs), things that i think are important.
* Flutter Front End to consume the API, to make it easier to use.
* Use a different authentication method, like OAuth, to make the API more secure.
* Docker for the server and the database, to make the project more scalable.
* Procfile.dev for the server and the database, not implemented because it is not necessary in this moment.


<div class="cell markdown">

### Ruby-Challenge API Documentation

##### Product Specifications

The API have the following features:

  - Create an User
  - Confirm User with email
  - Login User
  - Create an TODO List
  - Change mode of TODO list (pending, initiated, done)
  - Delete TODO List
  - Create an Item
  - Change mode of Item (pending, read, executed, archived)
  - Delete Item
  - List items ans lists according to their status
  - Pagination

##### Staging: <http://ruby-challenge-staging.herokuapp.com/>

##### Production: <http://ruby-challenge-production.herokuapp.com/>

##### DEV Environment: <http://localhost:3000/>

</div>

<div class="cell markdown">

Change MODE constant to the environment who will receive the request

</div>

<div class="cell code" data-execution_count="7" id="e-u1UH-fmdpm">

``` python
# import libyrary for python requests demonstration
# change constant mode to your enviroment mode

MODE = 'dev'
#MODE = 'prod'
#MODE = 'stag'


import requests
import json
import pandas as pd


# define the url

if MODE == 'dev':
    url = 'http://localhost:3000'
elif MODE == 'prod':
    url = 'https://ruby-challenge-production.herokuapp.com'
elif MODE == 'stag':
    url = 'https://ruby-challenge-staging.com'
```

</div>

<div class="cell markdown">

#### GET / - returns the root page of the API ('<http://localhost:3000>')

</div>

<div class="cell code" data-execution_count="8" data-colab="{&quot;height&quot;:35,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="FE0wFdgfmvhQ" data-outputId="18008b2d-ddcc-4771-a48f-9c9f6868f683">

``` python

# the same of ' r = requests.get('http://localhost:3000') '
r = requests.get(url) # get the response

# get the response body as json
json_response = json.loads(r.text)

# print the response body
print('JSON: ', json_response)

## PRINT RESPONSE INFO
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)
```

<div class="output stream stdout">

    JSON:  {'message': 'Welcome to the API'}

</div>

</div>

<div class="cell markdown">

#### GET /users/sign\_in - returns a message informing what information you need to sign in

</div>

<div class="cell code" data-execution_count="9" data-colab="{&quot;height&quot;:35,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="Q2iA_qvsnSz1" data-outputId="0bcf54d2-9cc8-464e-f808-dcfeda5266a3">

``` python
r = requests.get((url + '/api/users/login'))

# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

# get the response body as json
json_response = json.loads(r.text)

# show json response
print('JSON: ', json_response )
```

<div class="output stream stdout">

    JSON:  {'message': 'Enter email and password'}

</div>

</div>

<div class="cell markdown">

#### GET /users/sign\_up - returns a message informing what you need to sign up

</div>

<div class="cell code" data-execution_count="10" data-colab="{&quot;height&quot;:35,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="uom1pShxnqsU" data-outputId="1be82c2f-60b7-488e-8c08-555343306dc7">

``` python
r = requests.get((url + '/api/users/sign_up'))

# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

json_response = json.loads(r.text)

print('JSON: ', json_response)
```

<div class="output stream stdout">

    JSON:  {'message': 'Enter email, username and password'}

</div>

</div>

<div class="cell markdown" id="OnsXydWvwACa">

#### POST /users - creates a new user

</div>

<div class="cell markdown">

After the user signs up, he/she will receive an email with a link to
confirm his/her email address

So the user must confirm his/her email address before he/she can login

</div>

<div class="cell code" data-execution_count="11" data-colab="{&quot;height&quot;:35,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="8Xvacy7Cn_nX" data-outputId="221a925f-55f7-4c89-aa66-8fc79aee90df">

``` python
sign_up_params = {'user[email]': 'mail@mail.com', 'user[username]': 'username', 'user[password]': 'password'}

r = requests.post((url + '/api/users'), params=sign_up_params)



# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)


# get the response body as json
json_response = json.loads(r.text)

# show json response
print('JSON: ', json_response)


##  error because this account already exists
##  use this account to login
##  email: mail@mail.com
##  password: password
```

<div class="output stream stdout">

    JSON:  {'message': 'You have successfully signed up, please activate your account by clicking the activation link that has been sent to your email address.'}

</div>

</div>

<div class="cell markdown">

#### POST /users/login - logs in a user

</div>

<div class="cell markdown">

**Utilize login params - email, password to get authentication token**

**Utilize the authentication token to make requests to the API**

**The authentication token will expire after a certain period of time**

**If the authentication token expires, you will need to sign in again**

**To get working the authentication token, you will need to set it in
the header of your request**

**headers = {'Authorization': TOKEN }**

</div>

<div class="cell code" data-execution_count="12" data-colab="{&quot;height&quot;:35,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="TOPQAsfcoh_x" data-outputId="cc9239d7-eea1-4f0e-8e96-7577460bef21">

``` python
login_params = {'user[email]': 'mail@mail.com', 'user[password]': 'password'}
r = requests.post((url + '/api/users/login'), params=login_params)


# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

# get the response body as json
json_response = json.loads(r.text)

# show json response
print('JSON_RESPONSE: ', json_response, '\n')

# get the token
token = json_response['token']

# print the token
print('TOKEN: ', token)
```

<div class="output stream stdout">

    JSON_RESPONSE:  {'message': 'You have successfully logged in', 'token': 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNjU0MDMyNTQ0fQ.WcHzXhnRcDhzOd8YE-6LWenmleV_G5mi8JLW76Aeo1o'} 
    
    TOKEN:  eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNjU0MDMyNTQ0fQ.WcHzXhnRcDhzOd8YE-6LWenmleV_G5mi8JLW76Aeo1o

</div>

</div>

<div class="cell markdown">

##### **EXAMPLE OF A REQUEST WITH THE AUTHENTICATION TOKEN**

##### **GET TODO LIST - returns a list of all the TODO lists**

##### **DOCUMENTATION OF GET TODO LIST IS ON HIS OWN SECTION**

</div>

<div class="cell code" data-execution_count="13" data-colab="{&quot;height&quot;:35,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="4SvlKvDlp3Dv" data-outputId="1e899ada-9b15-4829-d15b-21fa84fe7b22">

``` python

# hold the token header in a variable
auth_head_tag = {'Authorization':token}

# makes the request with the token
r = requests.get('http://localhost:3000/api/todo_lists', headers=auth_head_tag)

# get the response body as json
# json_response = json.loads(r.text)

# show json response
# print('JSON: ', json_response)

# get page status code to check if the request was successful
# when the request is successful, the status code is 200
print('STATUS_CODE: ', r.status_code)

```

<div class="output stream stdout">

    STATUS_CODE:  200

</div>

</div>

<div class="cell markdown">

#### POST /api/todo\_lists - creates a new todo list

**ACCEPT PARAMS:**

    * title
    * description
    * action

**SETTED AUTOMATICALLY:** \* user\_id \* mode \* created\_at \*
updated\_at \* items\_count

DEFAULT VALUES: \* mode = pending \* items\_count = 0 \* created\_at =
updated\_at = current time \* user\_id = the user who created the list

**EXAMPLE PARAMS:**

``` 
    { "item": 
        { "title": "",
          "description": "",
          "action": "",
        }
    }
```

**URL PARAMS EXAMPLE:**
?item\[title\]=VALUE\&item\[description\]=VALUE\&item\[action\]=VALUE

**RETURN TODO LIST OBJECT IF CREATED**

</div>

<div class="cell code" data-execution_count="14">

``` python
title = 'title-testing' # define the title
title_modificator = 'title-modification' # define the title modificatorq


# hold todo list params in a variable and define the title
todo_lists_params = {'todo_list[title]': title, 'todo_list[description]': 'description', 'todo_list[action]': 'run on server'}


# hold the token header in a variable
auth_head_tag = {'Authorization':token}

# makes the request with the token and the todo list params
r = requests.post((url +'/api/todo_lists'), headers=auth_head_tag, params=todo_lists_params )


# or u can pass values through url
#r = requests.post((url +'/api/todo_lists?item[title]=VALUE&item[description]=VALUE&item[action]=VALUE'), headers=auth_head_tag)


# get the response body as json
json_response = json.loads(r.text)


# show json response
print('JSON: ', json_response)
```

<div class="output stream stdout">

    JSON:  {'data': {'id': '1', 'type': 'todo-lists', 'attributes': {'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:16.291Z', 'updated-at': '2022-04-01T21:29:16.291Z', 'items-count': 0}}}

</div>

</div>

<div class="cell markdown">

**EXTRA PYTHON SECTION TO CREATE TODO LIST OBJECTS, IT IS NOT NECESSARY
TO THE CHALLENGE**

**CAN USE IT TO TEST RACK CORS AND RACK ATTACK**

</div>

<div class="cell code" data-execution_count="20">

``` python
# Title Modificator
mod = "RECEITA "

# Title adtional tag in case title already exists
add_tag = "X"


# This function use a loop to create todo list objects continuously in a range
def todo_lists_post_request(auth_head_tag, mod, add_tag, counter):
    # Number of errors
    errors = 0
    
    # Count the number of todos created
    objects_created_count = 0
    
    # Count the number of todos created and use it to change the title
    title_numerator = 1

    # Loop to create todo list objects
    for i in counter:

        # define the title with modificator
        title = (mod + str(title_numerator))

        # todo list params
        todo_lists_params = {'todo_list[title]': title  , 'todo_list[description]': 'description', 'todo_list[action]': 'run on server'}

        # makes the request with the token and the todo list params
        r = requests.post((url + '/api/todo_lists'), headers=auth_head_tag, params=todo_lists_params)

        # check status code and if it is not 200, count the error and add tag to the title in case it already exists
        if r.status_code == 422:
            mod += add_tag
            errors += 1
        else:
            # Count the number of todos created
            objects_created_count += 1

        # Count the number of todos created and use it to change the title
        title_numerator += 1

    # print the number of todos created
    print('OBJECTS CREATED: ', objects_created_count)
    # print the number of errors
    print('ERRORS: ', errors)
        
# Run the function
todo_lists_post_request(auth_head_tag, mod, add_tag, range(20,50))
```

<div class="output stream stdout">

    OBJECTS CREATED:  28
    ERRORS:  2

</div>

</div>

<div class="cell markdown">

#### GET /api/todo\_lists - returns all todo lists with serializer and pagination

All Todo List object is inside the data array

Simple wrap the Todo List object with the serializer

Pagy add pagination to the response headers

Print headers to see what pagy gem is doing

</div>

<div class="cell code" data-execution_count="22">

``` python
# hold the token header in a variable
auth_head_tag = {'Authorization':token}

# makes the request with the token
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag)

# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code) 
# print( 'BODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code) 

# get the response body as json
json_response = json.loads(r.text)

# show json response
total_pages = r.headers['Total-Pages']

current_page = r.headers['Current-Page']

print('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')
            

json_objects = json_response['data']

# print ('HEADERS: ', r.headers, '\n')

for js_object in json_objects:
    print('JSON_OBJECT: ', js_object, '\n')

    
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  9 

JSON_OBJECT:  {'id': '1', 'type': 'todo-lists', 'attributes': {'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:16.291Z', 'updated-at': '2022-04-01T21:29:16.291Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '2', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 1', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.332Z', 'updated-at': '2022-04-01T21:29:30.332Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '3', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 2', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.387Z', 'updated-at': '2022-04-01T21:29:30.387Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '4', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 3', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.464Z', 'updated-at': '2022-04-01T21:29:30.464Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '5', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 4', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.630Z', 'updated-at': '2022-04-01T21:29:30.630Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '6', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 5', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.716Z', 'updated-at': '2022-04-01T21:29:30.716Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '7', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 6', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.787Z', 'updated-at': '2022-04-01T21:29:30.787Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '8', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 7', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.864Z', 'updated-at': '2022-04-01T21:29:30.864Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '9', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 8', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.922Z', 'updated-at': '2022-04-01T21:29:30.922Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '10', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 9', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.985Z', 'updated-at': '2022-04-01T21:29:30.985Z', 'items-count': 0}} 

```

</div>

</div>

<div class="cell markdown">

#### GET /api/todo\_lists?page=PAGENUMBER - returns a todo lists list with pagination

</div>

<div class="cell markdown">

Utilize the page number to get the next page of todo lists

</div>

<div class="cell code" data-execution_count="23">

``` python
page_params = {'page': '1'}
r = requests.get((url +  '/api/todo_lists'), headers=auth_head_tag, params=page_params)
json_response = json.loads(r.text)


total_pages = r.headers['Total-Pages']

total_pages = r.headers['Current-Page']

print('CURRENT PAGE: ', total_pages, '\n\nTOTAL PAGES: ', total_pages, '\n')
            
json_objects = json_response['data']

# print ('HEADERS: ', r.headers, '\n')

# print('JSON_RESPONSE: ', json_response, '\n')


for js_object in json_objects:
    print('JSON_OBJECT: ', js_object, '\n')
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

JSON_OBJECT:  {'id': '1', 'type': 'todo-lists', 'attributes': {'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:16.291Z', 'updated-at': '2022-04-01T21:29:16.291Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '2', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 1', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.332Z', 'updated-at': '2022-04-01T21:29:30.332Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '3', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 2', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.387Z', 'updated-at': '2022-04-01T21:29:30.387Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '4', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 3', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.464Z', 'updated-at': '2022-04-01T21:29:30.464Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '5', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 4', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.630Z', 'updated-at': '2022-04-01T21:29:30.630Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '6', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 5', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.716Z', 'updated-at': '2022-04-01T21:29:30.716Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '7', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 6', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.787Z', 'updated-at': '2022-04-01T21:29:30.787Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '8', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 7', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.864Z', 'updated-at': '2022-04-01T21:29:30.864Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '9', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 8', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.922Z', 'updated-at': '2022-04-01T21:29:30.922Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '10', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 9', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.985Z', 'updated-at': '2022-04-01T21:29:30.985Z', 'items-count': 0}} 

```

</div>

</div>

<div class="cell markdown">

##### GET /api/items?page=PAGENUMBER\&todo\_list\_id=ID - returns a list of items with pagination

</div>

<div class="cell code" data-execution_count="24">

``` python
page_with_todo_list_params = {'page': '1', 'todo_list_id': '1'}
r = requests.get('http://localhost:3000/api/items', headers=auth_head_tag, params=page_with_todo_list_params)
json_response = json.loads(r.text)


print('JSON_RESPONSE: ', json_response, '\n')

json_todo_list_object = json_response['todo_list']

json_items_objects = json_response['items']

total_pages = r.headers['Total-Pages']
            
print('TOTAL PAGES: ', total_pages)

print("TODO LIST: ", json_todo_list_object, '\n')

            

for item in json_items_objects:
    print('ITEM: ', item, '\n')
            


print('JSON_RESPONSE: ', json_response, '\n')

```

<div class="output stream stdout">

``` 
JSON_RESPONSE:  {'todo_list': {'id': 1, 'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:16.291Z', 'updated_at': '2022-04-01T21:29:16.291Z', 'items_count': 0}, 'items': []} 

TOTAL PAGES:  1
TODO LIST:  {'id': 1, 'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:16.291Z', 'updated_at': '2022-04-01T21:29:16.291Z', 'items_count': 0} 

JSON_RESPONSE:  {'todo_list': {'id': 1, 'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:16.291Z', 'updated_at': '2022-04-01T21:29:16.291Z', 'items_count': 0}, 'items': []} 

```

</div>

</div>

<div class="cell markdown">

#### POST /api/items - creates a new item in a todo list

**ACCEPT PARAMS:**

    * todo_list_id
    * action
    * name

**SETTED AUTOMATICALLY:**

    * mode
    * created_at
    * updated_at

**DEFAULT VALUES:**

    * mode = pending
    * created_at = updated_at = current time

**EXAMPLE PARAMS:**

``` 
    { "item": 
        { "todo_list_id": "",
          "action": "",
          "name": "",
        }
    }
```

**URL PARAMS EXAMPLE:**
?item\[todo\_list\_id\]=VALUE\&item\[action\]=VALUE\&item\[name\]=VALUE

</div>

<div class="cell code" data-execution_count="37">

``` python
item_params = {'item[todo_list_id]': '5', 'item[action]': 'run on server','item[name]': 'item'}
r = requests.post((url + '/api/items'), headers=auth_head_tag, params=item_params)
json_response = json.loads(r.text)
print('JSON_RESPONSE: ', json_response, '\n')
```

<div class="output stream stdout">

``` 
JSON_RESPONSE:  {'item': {'id': 13, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:05.516Z', 'updated_at': '2022-04-01T21:35:05.516Z', 'todo_list': 'RECEITA 4'}} 

```

</div>

</div>

<div class="cell markdown">

### GET /api/view\_item - returns a specific item with given id

Access object in view\_item show page

It change object mode to read

You can set params with "true" value to change it to other modes (**read
is setted by default if u access this endpoint**)

**Available params:** \* executed \* archived

When mode is archived, the item is not shown in the common lists (**only
can be accessed if a list of archived items is requested**)

</div>

<div class="cell code" data-execution_count="38">

``` python
params = {'id': '1'}
r = requests.get((url + '/api/view_item/'), headers=auth_head_tag, params=params)
r.text
```

<div class="output execute_result" data-execution_count="38">

    '{"data":{"id":"1","type":"items","attributes":{"name":"item","action":"run on server","mode":"read","created-at":"2022-04-01T21:34:52.560Z","updated-at":"2022-04-01T21:35:32.237Z","todo-list":"RECEITA 4"}}}'

</div>

</div>

<div class="cell markdown">

#### GET /api/items/:id&:executed - updates an item with given id and executed status

</div>

<div class="cell code" data-execution_count="39">

``` python
params = {'id': '2', 'executed': 'true'}
r = requests.get('http://localhost:3000/api/view_item/', headers=auth_head_tag, params=params)
r.text
```

<div class="output execute_result" data-execution_count="39">

    '{"data":{"id":"2","type":"items","attributes":{"name":"item","action":"run on server","mode":"executed","created-at":"2022-04-01T21:34:53.664Z","updated-at":"2022-04-01T21:35:37.163Z","todo-list":"RECEITA 4"}}}'

</div>

</div>

<div class="cell markdown">

#### GET /api/items/:id&:archived - updates an item with given id and archived status

</div>

<div class="cell code" data-execution_count="40">

``` python
params = {'id': '3', 'archived': 'true'}
r = requests.get('http://localhost:3000/api/view_item/', headers=auth_head_tag, params=params)
r.text
```

<div class="output execute_result" data-execution_count="40">

    '{"data":{"id":"3","type":"items","attributes":{"name":"item","action":"run on server","mode":"archived","created-at":"2022-04-01T21:34:54.610Z","updated-at":"2022-04-01T21:35:39.279Z","todo-list":"RECEITA 4"}}}'

</div>

</div>

<div class="cell markdown">

#### GET /api/items - returns all items with pagination and filter - example: object sorted by enum mode (asc)

</div>

<div class="cell markdown">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="41">

``` python
page_with_todo_list_params = {'page': '1', 'todo_list_id': '5', 'filter': 'mode_asc'}
r = requests.get('http://localhost:3000/api/items', headers=auth_head_tag, params=page_with_todo_list_params)
json_response = json.loads(r.text)


json_todo_list_object = json_response['todo_list']

json_items_objects = json_response['items']


total_pages = r.headers['Total-Pages']

current_page = r.headers['Current-Page']

print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')
            

print("TODO LIST: ", json_todo_list_object, '\n')


for item in json_items_objects:
    print('ITEM: ', item, '\n')
            
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

TODO LIST:  {'id': 5, 'title': 'RECEITA 4', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:30.630Z', 'updated_at': '2022-04-01T21:29:30.630Z', 'items_count': 13} 

ITEM:  {'id': 13, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:05.516Z', 'updated_at': '2022-04-01T21:35:05.516Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 11, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:03.038Z', 'updated_at': '2022-04-01T21:35:03.038Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 12, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:04.299Z', 'updated_at': '2022-04-01T21:35:04.299Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 4, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:55.657Z', 'updated_at': '2022-04-01T21:34:55.657Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 5, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:56.549Z', 'updated_at': '2022-04-01T21:34:56.549Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 6, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:57.406Z', 'updated_at': '2022-04-01T21:34:57.406Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 7, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.069Z', 'updated_at': '2022-04-01T21:34:58.069Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 8, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.783Z', 'updated_at': '2022-04-01T21:34:58.783Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 9, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:59.582Z', 'updated_at': '2022-04-01T21:34:59.582Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 10, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:00.304Z', 'updated_at': '2022-04-01T21:35:00.304Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 1, 'name': 'item', 'action': 'run on server', 'mode': 'read', 'created_at': '2022-04-01T21:34:52.560Z', 'updated_at': '2022-04-01T21:35:32.237Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 2, 'name': 'item', 'action': 'run on server', 'mode': 'executed', 'created_at': '2022-04-01T21:34:53.664Z', 'updated_at': '2022-04-01T21:35:37.163Z', 'todo_list': 'RECEITA 4'} 

```

</div>

</div>

<div class="cell markdown">

#### GET /api/items?page=PAGENUMBER\&mode=MODE - returns a list of items with pagination and filter - example: object sorted by enum mode (desc)

</div>

<div class="cell markdown">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="42">

``` python
page_with_todo_list_params = {'page': '1', 'todo_list_id': '5', 'filter': 'mode_desc'}
r = requests.get('http://localhost:3000/api/items', headers=auth_head_tag, params=page_with_todo_list_params)
json_response = json.loads(r.text)


# print('JSON_RESPONSE: ', json_response, '\n')

# data = json_response['data']


# for d in data :
#     print('DATA: ', d, '\n')

json_todo_list_object = json_response['todo_list']

json_items_objects = json_response['items']


total_pages = r.headers['Total-Pages']
            
print('TOTAL PAGES: ', total_pages)

print("TODO LIST: ", json_todo_list_object, '\n')

            

for item in json_items_objects:
    print('ITEM: ', item, '\n')
            
# json_objects = json_response['data']

# # print ('HEADERS: ', r.headers, '\n')

# print('JSON_RESPONSE: ', json_response, '\n')


# for js_object in json_objects:
#     print('JSON_OBJECT: ', js_object, '\n')
```

<div class="output stream stdout">

``` 
TOTAL PAGES:  1
TODO LIST:  {'id': 5, 'title': 'RECEITA 4', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:30.630Z', 'updated_at': '2022-04-01T21:29:30.630Z', 'items_count': 13} 

ITEM:  {'id': 2, 'name': 'item', 'action': 'run on server', 'mode': 'executed', 'created_at': '2022-04-01T21:34:53.664Z', 'updated_at': '2022-04-01T21:35:37.163Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 1, 'name': 'item', 'action': 'run on server', 'mode': 'read', 'created_at': '2022-04-01T21:34:52.560Z', 'updated_at': '2022-04-01T21:35:32.237Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 5, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:56.549Z', 'updated_at': '2022-04-01T21:34:56.549Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 6, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:57.406Z', 'updated_at': '2022-04-01T21:34:57.406Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 7, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.069Z', 'updated_at': '2022-04-01T21:34:58.069Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 8, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.783Z', 'updated_at': '2022-04-01T21:34:58.783Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 9, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:59.582Z', 'updated_at': '2022-04-01T21:34:59.582Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 10, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:00.304Z', 'updated_at': '2022-04-01T21:35:00.304Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 11, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:03.038Z', 'updated_at': '2022-04-01T21:35:03.038Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 12, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:04.299Z', 'updated_at': '2022-04-01T21:35:04.299Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 13, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:05.516Z', 'updated_at': '2022-04-01T21:35:05.516Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 4, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:55.657Z', 'updated_at': '2022-04-01T21:34:55.657Z', 'todo_list': 'RECEITA 4'} 

```

</div>

</div>

<div class="cell markdown">

##### GET /api/items?page=PAGENUMBER\&mode=MODE\&todo\_list\_id=ID - returns a list of items with pagination and filter - example: object sorted by enum mode (asc)

</div>

<div class="cell markdown">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="43">

``` python
page_with_todo_list_params = {'page': '1', 'todo_list_id': '5', 'filter': 'mode_asc'}
r = requests.get('http://localhost:3000/api/items', headers=auth_head_tag, params=page_with_todo_list_params)
json_response = json.loads(r.text)


# print('JSON_RESPONSE: ', json_response, '\n')

# data = json_response['data']


# for d in data :
#     print('DATA: ', d, '\n')

json_todo_list_object = json_response['todo_list']

json_items_objects = json_response['items']


total_pages = r.headers['Total-Pages']
            
print('TOTAL PAGES: ', total_pages)

print("TODO LIST: ", json_todo_list_object, '\n')

            

for item in json_items_objects:
    print('ITEM: ', item, '\n')
            
# json_objects = json_response['data']

# # print ('HEADERS: ', r.headers, '\n')

# print('JSON_RESPONSE: ', json_response, '\n')


# for js_object in json_objects:
#     print('JSON_OBJECT: ', js_object, '\n')
```

<div class="output stream stdout">

``` 
TOTAL PAGES:  1
TODO LIST:  {'id': 5, 'title': 'RECEITA 4', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:30.630Z', 'updated_at': '2022-04-01T21:29:30.630Z', 'items_count': 13} 

ITEM:  {'id': 13, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:05.516Z', 'updated_at': '2022-04-01T21:35:05.516Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 11, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:03.038Z', 'updated_at': '2022-04-01T21:35:03.038Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 12, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:04.299Z', 'updated_at': '2022-04-01T21:35:04.299Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 4, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:55.657Z', 'updated_at': '2022-04-01T21:34:55.657Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 5, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:56.549Z', 'updated_at': '2022-04-01T21:34:56.549Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 6, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:57.406Z', 'updated_at': '2022-04-01T21:34:57.406Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 7, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.069Z', 'updated_at': '2022-04-01T21:34:58.069Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 8, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.783Z', 'updated_at': '2022-04-01T21:34:58.783Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 9, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:59.582Z', 'updated_at': '2022-04-01T21:34:59.582Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 10, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:00.304Z', 'updated_at': '2022-04-01T21:35:00.304Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 1, 'name': 'item', 'action': 'run on server', 'mode': 'read', 'created_at': '2022-04-01T21:34:52.560Z', 'updated_at': '2022-04-01T21:35:32.237Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 2, 'name': 'item', 'action': 'run on server', 'mode': 'executed', 'created_at': '2022-04-01T21:34:53.664Z', 'updated_at': '2022-04-01T21:35:37.163Z', 'todo_list': 'RECEITA 4'} 

```

</div>

</div>

<div class="cell markdown">

##### GET /api/items?page=PAGENUMBER\&filter\_factor\&todo\_list\_id=ID - returns a list of items with pagination and filter - example: object sorted by selected factor

</div>

<div class="cell markdown">

**HOW TO FILTER WITH FACTOR?**

Items and todo lists can be filtered by mode order in asc, desc like
already done in the previous examples But it can be filtered in
different orders by factor

**COMMOM ORDERS:**

    common_order = [:pending, :read, :executed, :archived]
    its_like = [0, 1, 2, 3]
    
    asc = comom_order
    desc = [3 ,2 ,1 ,0]

**ITEMS FACTORED ORDERS(MATRIX):**

    0 =  [1, 2, 3, 0] 
    1 =  [2, 3, 0, 1]
    2 =  [3, 0, 1, 2]
    3 =  [0, 1, 2, 3]
    4 =  [1, 3, 2, 0]
    5 =  [2, 1, 0, 3]
    6 =  [3, 2, 1, 0]
    7 =  [0, 3, 2, 1]
    8 =  [1, 0, 3, 2]
    9 =  [2, 0, 1, 3]
    10 = [3, 1, 0, 2]
    11 = [0, 2, 1, 3]
    12 = [1, 3, 0, 2]
    13 = [2, 3, 1, 0]
    14 = [3, 0, 2, 1]
    15 = [0, 1, 3, 2]
    16 = [1, 2, 0, 3]
    17 = [2, 1, 3, 0]
    18 = [3, 2, 0, 1]
    19 = [0, 3, 1, 2]
    20 = [1, 0, 2, 3]
    21 = [2, 0, 3, 1]
    22 = [3, 1, 2, 0]
    23 = [0, 2, 3, 1]

**Utilize matrix order number in params**

**EXAMPLE PARAMS(REMEMBER, ONLY TODO LIST ID IS REQUIRED TO ACCESS THE
LIST EVER):**

    { page: 1,
      filter_factor: 0,
      todo_list_id: 1
    }

</div>

<div class="cell code" data-execution_count="44">

``` python
page_with_todo_list_params = {'page': '1', 'todo_list_id': '5', 'filter_factor': '8'}
r = requests.get('http://localhost:3000/api/items', headers=auth_head_tag, params=page_with_todo_list_params)
json_response = json.loads(r.text)

json_todo_list_object = json_response['todo_list']

json_items_objects = json_response['items']


total_pages = r.headers['Total-Pages']
            
print('TOTAL PAGES: ', total_pages, '\n')

print("TODO LIST: ", json_todo_list_object, '\n')

            

for item in json_items_objects:
    print('ITEM: ', item, '\n')
```

<div class="output stream stdout">

``` 
TOTAL PAGES:  1 

TODO LIST:  {'id': 5, 'title': 'RECEITA 4', 'description': 'description', 'mode': 'pending', 'created_at': '2022-04-01T21:29:30.630Z', 'updated_at': '2022-04-01T21:29:30.630Z', 'items_count': 13} 

ITEM:  {'id': 1, 'name': 'item', 'action': 'run on server', 'mode': 'read', 'created_at': '2022-04-01T21:34:52.560Z', 'updated_at': '2022-04-01T21:35:32.237Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 4, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:55.657Z', 'updated_at': '2022-04-01T21:34:55.657Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 5, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:56.549Z', 'updated_at': '2022-04-01T21:34:56.549Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 6, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:57.406Z', 'updated_at': '2022-04-01T21:34:57.406Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 7, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.069Z', 'updated_at': '2022-04-01T21:34:58.069Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 8, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:58.783Z', 'updated_at': '2022-04-01T21:34:58.783Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 9, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:34:59.582Z', 'updated_at': '2022-04-01T21:34:59.582Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 10, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:00.304Z', 'updated_at': '2022-04-01T21:35:00.304Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 11, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:03.038Z', 'updated_at': '2022-04-01T21:35:03.038Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 12, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:04.299Z', 'updated_at': '2022-04-01T21:35:04.299Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 13, 'name': 'item', 'action': 'run on server', 'mode': 'pending', 'created_at': '2022-04-01T21:35:05.516Z', 'updated_at': '2022-04-01T21:35:05.516Z', 'todo_list': 'RECEITA 4'} 

ITEM:  {'id': 2, 'name': 'item', 'action': 'run on server', 'mode': 'executed', 'created_at': '2022-04-01T21:34:53.664Z', 'updated_at': '2022-04-01T21:35:37.163Z', 'todo_list': 'RECEITA 4'} 

```

</div>

</div>

<div class="cell markdown">

**TODOS COMMOM ORDERS:**

    common_order = [:pending, :initiatied, :done]
    its_like = [0, 1, 2]
    
    asc = comom_order
    desc = [2 ,1 ,0]

**TODO LISTS FACTORED ORDERS(MATRIX):**

    0 = [2, 0, 1]
    1 = [2, 0, 1]
    2 = [2, 0, 1]
    3 = [2, 0, 1]
    4 = [2, 0, 1]
    5 = [2, 0, 1]

</div>

<div class="cell code" data-execution_count="45">

``` python
params = { 'page': 1, 'filter_factor': 8 }


r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag, params=params)
json_response = json.loads(r.text)

json_object = json_response['data']


for js_object in json_object:
    print('JSON_OBJECT: ', js_object, '\n')

```

<div class="output stream stdout">

``` 
JSON_OBJECT:  {'id': '1', 'type': 'todo-lists', 'attributes': {'title': 'title-testing', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:16.291Z', 'updated-at': '2022-04-01T21:29:16.291Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '2', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 1', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.332Z', 'updated-at': '2022-04-01T21:29:30.332Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '3', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 2', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.387Z', 'updated-at': '2022-04-01T21:29:30.387Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '4', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 3', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.464Z', 'updated-at': '2022-04-01T21:29:30.464Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '6', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 5', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.716Z', 'updated-at': '2022-04-01T21:29:30.716Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '7', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 6', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.787Z', 'updated-at': '2022-04-01T21:29:30.787Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '8', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 7', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.864Z', 'updated-at': '2022-04-01T21:29:30.864Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '9', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 8', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.922Z', 'updated-at': '2022-04-01T21:29:30.922Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '10', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 9', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:30.985Z', 'updated-at': '2022-04-01T21:29:30.985Z', 'items-count': 0}} 

JSON_OBJECT:  {'id': '11', 'type': 'todo-lists', 'attributes': {'title': 'RECEITA 10', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-01T21:29:31.048Z', 'updated-at': '2022-04-01T21:29:31.048Z', 'items-count': 0}} 

```

</div>

</div>

<div class="cell markdown">

##### GET /api/delete\_todo\_list - deletes a todo list with given id

</div>

<div class="cell code" data-execution_count="46">

``` python
params = {'id': '5'}
r = requests.get('http://localhost:3000/api/delete_todo_list', headers=auth_head_tag, params=params)
json_response = json.loads(r.text)
print('JSON_RESPONSE: ', json_response, '\n')
```

<div class="output stream stdout">

``` 
JSON_RESPONSE:  {'message': 'Todo list deleted successfully'} 

```

</div>

</div>

<div class="cell markdown">

##### GET /api/remove\_item - deletes an item with given id

</div>

<div class="cell code" data-execution_count="47">

``` python
params = {'id': '1'}
r = requests.get('http://localhost:3000/api/remove_item', headers=auth_head_tag)
json_response = json.loads(r.text)
print('JSON_RESPONSE: ', json_response, '\n')

```

<div class="output stream stdout">

``` 
JSON_RESPONSE:  {'error': 'Item not found'} 

```

</div>

</div>



**Developed by: JesusGautamah**

Other repositories:

In Development Outerspace Coding Website with rails 7, tailwindcss, sidekiq & cron jobs
* [Github](https://github.com/JesusGautamah/outerspace_coding)

CrawlerOnRails with Docker and Sidekiq
* [Github](https://github.com/JesusGautamah/Crawler_On_Rails)

Simple Flutter IMC Calculator
* [Github](https://github.com/JesusGautamah/imc_calculator)

(Contributed with backend) Simple Flutter CryptoWallet
* [Github](https://github.com/angelorange/bank_space)

EasyProxy Shell, controll proxy with tor and privoxy
* [Github](https://github.com/JesusGautamah/EasyProxy)


Old Rails and docker development check point
* [Github](https://github.com/JesusGautamah/rails-docker)





