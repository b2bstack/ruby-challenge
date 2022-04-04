# Ruby Challenge To Do List Manager - Rails API

<br />

## Python Notebook is inside the project for test the API
## documentation.ipynb
## the same documentation is on the final of this archive.

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
Each token is valid for a period of time, and is used to authenticate the user.


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

<div class="cell markdown" id="Bs0RIOiYDPSQ">

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

<div class="cell markdown" id="aR0ApJ5qDPSX">

Change MODE constant to the environment who will receive the request

</div>

<div class="cell code" data-execution_count="1" id="e-u1UH-fmdpm">

``` python
## CHANGE CONSTANT TO YOUR ENV MODE
MODE = 'dev'
# MODE = 'prod'
# MODE = 'stag'

## REQUIREMENTS
import requests
import json
import pandas as pd
import time


## CHECK ENV MODE AND DEFINE URL FOR REQUESTS
if MODE == 'dev':
    url = 'http://localhost:3000'
elif MODE == 'prod':
    url = 'https://ruby-challenge-production.herokuapp.com'
elif MODE == 'stag':
    url = 'https://ruby-challenge-staging.herokuapp.com'



## SOME METHODS TO HELP DEMONSTRATE

def post_items(token, todo_list_id, action, name):
    """
    Post items
    """
    auth_head_tag = {'Authorization':token}

    item_params = {'item[todo_list_id]': todo_list_id, 'item[action]': action,'item[name]': name}

    r = requests.post((url + '/api/items'), headers=auth_head_tag, params=item_params)

    return r.text


def mark_item_as_read(token, item_id):
    """
    Mark item as read
    """
    headers = {
        'Authorization': token
    }
    params = {
        'id': item_id
    }
    r = requests.get((url + '/api/view_item'), headers=headers, params=params)
    return r.text

def mark_item_as_executed(token, item_id):
    """
    Mark item as executed
    """
    headers = {
        'Authorization': token
    }
    params = {
        'id': item_id,
        'executed': 'true'
    }
    r = requests.get((url + '/api/view_item'), headers=headers, params=params)
    return r.text



def mark_item_as_archived(token, item_id):
    """
    Mark item as archived
    """
    headers = {
        'Authorization': token
    }
    params = {
        'id': item_id,
        'archived': 'true'
    }
    r = requests.get((url + '/api/view_item'), headers=headers, params=params)
    return r.text


def mark_todo_as_done(token, todo_list_id):
    """
    Mark todo as executed
    """
    headers = {
        'Authorization': token
    }
    params = {
        'id': todo_list_id,
        'done': 'true'
    }
    r = requests.get((url + '/api/view_todo_list/'), headers=headers, params=params)
    return r.text

```

</div>

<div class="cell markdown" id="vo9gnxp5DPSa">

#### GET / - returns the root page of the API ('<http://localhost:3000>')

</div>

<div class="cell code" data-execution_count="2" data-colab="{&quot;height&quot;:81,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="FE0wFdgfmvhQ" data-outputId="562043b6-fa70-4700-9c2e-158d5e6bb62d">

``` python
## SEND REQUEST TO ENV URL
r = requests.get(url)

## HOLD JSON RESPONSE IN A VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON: ', json_response)

## PRINT RESPONSE INFO
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

## PRINT JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="2">

``` 
              message
0  Welcome to the API
```

</div>

</div>

<div class="cell markdown" id="jEfLMMssDPSc">

#### GET /users/sign\_in - returns a message informing what information you need to sign in

</div>

<div class="cell code" data-execution_count="3" data-colab="{&quot;height&quot;:81,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="Q2iA_qvsnSz1" data-outputId="7fda302d-0164-4cbf-b281-ee0b8355b691">

``` python
## SEND REQUEST TO API USERS LOGIN
r = requests.get((url + '/api/users/login'))

## PRINT RESPONSE INFORMATIONS
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON: ', json_response )

## PRINT RESPONSE IN DATA FRAME
pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="3">

``` 
                    message
0  Enter email and password
```

</div>

</div>

<div class="cell markdown" id="xY0_BcSXDPSe">

#### GET /users/sign\_up - returns a message informing what you need to sign up

</div>

<div class="cell code" data-execution_count="4" data-colab="{&quot;height&quot;:81,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="uom1pShxnqsU" data-outputId="65061f47-d5e0-42e5-891c-fb717ea57072">

``` python
#  GET REQUEST API USERS SIGN UP
r = requests.get((url + '/api/users/sign_up'))

## PRINT RESPONSE INFORMATIONS
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

## HOLD JSON RESPONSE IN A VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
#print('JSON: ', json_response)

## PRINT JSON RESPONSE IN DATA FRAME 
pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="4">

``` 
                              message
0  Enter email, username and password
```

</div>

</div>

<div class="cell markdown" id="OnsXydWvwACa">

#### POST /users - creates a new user

</div>

<div class="cell markdown" id="TRXx75akDPSf">

After the user signs up, he/she will receive an email with a link to
confirm his/her email address

So the user must confirm his/her email address before he/she can login

</div>

<div class="cell code" data-execution_count="5" data-colab="{&quot;height&quot;:98,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="8Xvacy7Cn_nX" data-outputId="f3ebadc8-7f1d-431a-ca88-fa18b6c9026b">

``` python
#HOLD SIGN UP PARAMS
sign_up_params = {'user[email]': 'mail@mail.com', 'user[username]': 'username', 'user[password]': 'password'}

## MAKE POST REQUEST IN API USERS
r = requests.post((url + '/api/users'), params=sign_up_params)


## PRINT ALL RESPONSE INFORMATION
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)


## HOLD JSON RESPONSE IN A VARIABLE
json_response = json.loads(r.text)

## SHOW JSON RESPONSE
# print('JSON: ', json_response)


##  error may raise because of the email already exists
##  use this account to login
##  email: mail@mail.com
##  password: password


pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="5">

``` 
                                             message
0  You have successfully signed up, please activa...
```

</div>

</div>

<div class="cell markdown" id="Y9Nz-Z9aDPSg">

#### POST /users/login - logs in a user

</div>

<div class="cell markdown" id="3sqpfhbYDPSh">

**Utilize login params - email, password to get authentication token**

**Utilize the authentication token to make requests to the API**

**The authentication token will expire after a certain period of time**

**If the authentication token expires, you will need to sign in again**

**To get working the authentication token, you will need to set it in
the header of your request**

**headers = {'Authorization': TOKEN }**

</div>

<div class="cell code" data-execution_count="6" data-colab="{&quot;height&quot;:81,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="TOPQAsfcoh_x" data-outputId="55d7abe8-8d66-4ada-a87a-033f8c53b65a">

``` python
## HOLD LOGIN PARAMS IN A VARIABLE
login_params = {'user[email]': 'mail@mail.com', 'user[password]': 'password'}

## SEND POST REQUEST TO API USERS LOGIN
r = requests.post((url + '/api/users/login'), params=login_params)

## PRINT ALL RESPONSE INFORMATION
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

#HOLD JWT TOKEN IN VARIABLE
token = json_response['token']

## PRINT AUTHORIZATION TOKEN
# print('TOKEN: ', token)

## PRINT JSON RESPONSER AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="6">

``` 
                           message  \
0  You have successfully logged in   

                                               token  
0  eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNjU0M...  
```

</div>

</div>

<div class="cell markdown" id="nKhVW4qBDPSi">

##### **EXAMPLE OF A REQUEST WITH THE AUTHENTICATION TOKEN**

##### **GET TODO LIST - returns a list of all the TODO lists**

##### **DOCUMENTATION OF GET TODO LIST IS ON HIS OWN SECTION**

</div>

<div class="cell code" data-execution_count="7" data-colab="{&quot;height&quot;:635,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="4SvlKvDlp3Dv" data-outputId="1d55e2f1-f60c-454b-b0f6-04bd01066e3a">

``` python
## HOLD AUTHORIZATION TOKEN HEADER
auth_head_tag = {'Authorization':token}

## SEND GET REQUEST WITH AUTHORIZATION TOKEN
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON: ', json_response)

## HOLD STATUS CODE IN VARIABLE
status = r.status_code
## WHEN THE REQUEST IS SUCCESSFUL, THE STATUS CODE IS 200

## PRINT STATUS CODE
print('STATUS_CODE: ', status)

## PRITN JSON RESPONSE AS DATA FRAME
# pd.json_normalize(json_response)
```

<div class="output stream stdout">

    STATUS_CODE:  200

</div>

</div>

<div class="cell markdown" id="gBKAxo7dDPSj">

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

<div class="cell code" data-execution_count="8" data-colab="{&quot;height&quot;:457,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="yI1awyNBDPSj" data-outputId="d4bf6729-38d8-4ecd-8dbd-4c95711de1e8">

``` python
## CREATED BOOLEAN TO CHECK WHEN OBJECT IS CREATED
created = False

## TITLE NUMBER< WILL BE USED TO CHANGE THE TITLE BEFORE SAVE
title_number = 1

## HOLD AUTHORIZATION TOKEN
auth_head_tag = {'Authorization':token}

## LOOP WHILE CREATE FAILS
while created == False:

  ## HOLD TITLE + TITLE NUMBER
  title = 'title-testing ' + str(title_number)

  ## HOLD TODO LIST PARAMS
  todo_lists_params = {'todo_list[title]': title, 'todo_list[description]': 'description', 'todo_list[action]': 'run on server'}
  
  ## SEND POST REQUEST TO API TODO LISTS
  r = requests.post((url +'/api/todo_lists'), headers=auth_head_tag, params=todo_lists_params )
  
  ## HOLD JSON RESPONSE IN VARIABLE
  json_response = json.loads(r.text)

  ## INCREASE TITLE NUMBER
  title_number += 1

  ## PRINT THE TITLE
  print(title)

  ## CHECK IF HAS ERRORS IN JSON RESPONSE
  if 'errors' in json_response:

      ## PRINT THE ERRORS
      print('ERROR: ', json_response['errors'], '\n')

      ## SLEEP 2 SECONDS TO AVOID REQUESTO TO GET BLOCKED BY THE SERVER
      time.sleep(2)

  ## IF OK
  else:

      ## PRINT JSON RESPONSE DATA
      print('SUCCESS: ', json_response['data'])

      ## CHANGE CREATED VARIABLE TO TRUE
      created = True

## PRINT JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output stream stdout">

    title-testing 1
    SUCCESS:  {'id': '1', 'type': 'todo-lists', 'attributes': {'title': 'title-testing 1', 'description': 'description', 'mode': 'pending', 'created-at': '2022-04-04T10:50:17.377Z', 'updated-at': '2022-04-04T10:50:17.377Z', 'items-count': 0}}

</div>

<div class="output execute_result" data-execution_count="8">

``` 
  data.id   data.type data.attributes.title data.attributes.description  \
0       1  todo-lists       title-testing 1                 description   

  data.attributes.mode data.attributes.created-at data.attributes.updated-at  \
0              pending   2022-04-04T10:50:17.377Z   2022-04-04T10:50:17.377Z   

   data.attributes.items-count  
0                            0  
```

</div>

</div>

<div class="cell markdown">

#### GET /api/view\_todo\_list/:id - returns a todo list

</div>

<div class="cell code" data-execution_count="9">

``` python
## HOLD AUTHORIZATION TOKEN HEADER
auth_head_tag = {'Authorization':token}
params = {'id': '1'}
## SEND GET REQUEST WITH AUTHORIZATION TOKEN
r = requests.get((url + '/api/view_todo_list'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON: ', json_response)

## HOLD STATUS CODE IN VARIABLE
status = r.status_code
## WHEN THE REQUEST IS SUCCESSFUL, THE STATUS CODE IS 200

## PRINT STATUS CODE
print('STATUS_CODE: ', status)

## PRITN JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output stream stdout">

    STATUS_CODE:  200

</div>

<div class="output execute_result" data-execution_count="9">

``` 
  data.id   data.type data.attributes.title data.attributes.description  \
0       1  todo-lists       title-testing 1                 description   

  data.attributes.mode data.attributes.created-at data.attributes.updated-at  \
0              pending   2022-04-04T10:50:17.377Z   2022-04-04T10:50:17.377Z   

   data.attributes.items-count  
0                            0  
```

</div>

</div>

<div class="cell markdown" id="kYHd-pGMDPSk">

**EXTRA PYTHON SECTION TO CREATE TODO LIST OBJECTS, IT IS NOT NECESSARY
TO THE CHALLENGE**

**CAN USE IT TO TEST RACK CORS AND RACK ATTACK**

</div>

<div class="cell code" data-execution_count="10" data-colab="{&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="pssFMGTbDPSk" data-outputId="9832fa92-0175-45fa-d004-b89dbe20d338">

``` python
## USE MOD VARIABLE AS BASE OF YOUR TITLE
mod = "RECEITA "

## THIS TAG WILL BE ADDED TO THE TITLE EVERY TIME AN ERROR IS FOUND
add_tag = "X"


## THIS FUNCTION USES LOOP TO CREATE TODO REQUESTS IN A GIVEN RANGE
def todo_lists_post_request(auth_head_tag, mod, add_tag, counter):

    ## INIT AN VARIABLE TO HOLD NUMBER OF ERRORS
    errors = 0
    
    ## COUNT OBJECTS CREATED
    objects_created_count = 0
    
    ## COUNTER TO NUMERATE TITLE
    title_numerator = 1

    ## LOOP TO CREATE TODO LISTS
    for i in counter:

        ## HOLD TITLE MOD BASE + TITLE NUMERATOR
        title = (mod + str(title_numerator))

        ## TODO LISTS PARAMS
        todo_lists_params = {'todo_list[title]': title  , 'todo_list[description]': 'description', 'todo_list[action]': 'run on server'}

        ## SEND POST REQUEST TO TODO LISTS
        r = requests.post((url + '/api/todo_lists'), headers=auth_head_tag, params=todo_lists_params)
        ## TIME SLEEP TO AVOID REQUESTS TO BE BLOCKED BY THE SERVER
        time.sleep(2)


        ## CHECK RESPONSE STATUS CODE
        if r.status_code == 422:

            ## IF ERROR IS RAISED ADD TAG TO TITLE BASE MODIFICATOR
            mod += add_tag

            ## INCREASE ERRORS COUNTER
            errors += 1

            ## PRINT ERRORS
            print(errors)

        ## IF THE OBJECT IS CREATED AND STATUS CODE 200
        else:

            ## INCREASE OBJECTS CREATED COUNTER
            objects_created_count += 1

        ## INCREASE TITLE COUNTER
        title_numerator += 1

    ## PRINT OBJECTS CREATED COUNTER
    print('OBJECTS CREATED: ', objects_created_count)

    ## PRINT ERRORS COUNTER
    print('ERRORS: ', errors)
        
## RUN FUNCTION WITH GIVEN ARGS
todo_lists_post_request(auth_head_tag, mod, add_tag, range(20,50))
```

<div class="output stream stdout">

    OBJECTS CREATED:  30
    ERRORS:  0

</div>

</div>

<div class="cell markdown">

**EXTRA PYTHON SESSION CREATE SOME DEMONSTRATION ITEMS**

</div>

<div class="cell code" data-execution_count="11">

``` python
## IN THE FIRST PYTHON CELL HAVE A METHOD TO HELP US TO CREATE AND MARK ITEMS
## LET'S CREATE ITEMS FOR THE FIRST, SECOND AND THIRD TODO LIST AND MARK THEM AS EXECUTED OR ARCHIVED
## DEMONSTRATION PURPOSE

lists_ids = ['1', '2', '3']

commands = ['rails new', 'bundle', 'rake db:create db:migrate']

names = ['first', 'second', 'third']

for i in lists_ids:
    for n in range(3):
        json_response = json.loads(post_items(token, i, commands[n], names[n]))
        
        print('CREATED:' , json_response['item']['name'], 'TODO_LIST:' , json_response['item']['todo_list'], 'ID: ', json_response['item']['id'])
        if n == 2:
            marked_response = json.loads(mark_item_as_executed(token, json_response['item']['id']))
            print('MARKED:' , marked_response['data']['attributes']['name'], '\nTODO_LIST:' , marked_response['data']['attributes']['todo-list'], '\nMODE: ', marked_response['data']['attributes']['mode'], '\n')
            
        elif n == 1:
            marked_response = json.loads(mark_item_as_archived(token, json_response['item']['id']))
            print('MARKED:' , marked_response['data']['attributes']['name'], '\nTODO_LIST:' , marked_response['data']['attributes']['todo-list'], '\nMODE: ', marked_response['data']['attributes']['mode'], '\n')

mark_todo_as_done(token, 8)
```

<div class="output stream stdout">

``` 
CREATED: first TODO_LIST: title-testing 1 ID:  1
CREATED: second TODO_LIST: title-testing 1 ID:  2
MARKED: second 
TODO_LIST: title-testing 1 
MODE:  archived 

CREATED: third TODO_LIST: title-testing 1 ID:  3
MARKED: third 
TODO_LIST: title-testing 1 
MODE:  executed 

CREATED: first TODO_LIST: RECEITA 1 ID:  4
CREATED: second TODO_LIST: RECEITA 1 ID:  5
MARKED: second 
TODO_LIST: RECEITA 1 
MODE:  archived 

CREATED: third TODO_LIST: RECEITA 1 ID:  6
MARKED: third 
TODO_LIST: RECEITA 1 
MODE:  executed 

CREATED: first TODO_LIST: RECEITA 2 ID:  7
CREATED: second TODO_LIST: RECEITA 2 ID:  8
MARKED: second 
TODO_LIST: RECEITA 2 
MODE:  archived 

CREATED: third TODO_LIST: RECEITA 2 ID:  9
MARKED: third 
TODO_LIST: RECEITA 2 
MODE:  executed 

```

</div>

<div class="output execute_result" data-execution_count="11">

    '{"data":{"id":"8","type":"todo-lists","attributes":{"title":"RECEITA 7","description":"description","mode":"done","created-at":"2022-04-04T10:50:30.849Z","updated-at":"2022-04-04T10:51:23.338Z","items-count":0}}}'

</div>

</div>

<div class="cell markdown" id="PoRkWgEeDPSl">

#### GET /api/todo\_lists - returns all todo lists with serializer and pagination

All Todo List object is inside the data array

Simple wrap the Todo List object with the serializer

Pagy add pagination to the response headers

Print headers to see what pagy gem is doing

</div>

<div class="cell code" data-execution_count="12" data-colab="{&quot;height&quot;:687,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="pewb45UxDPSl" data-outputId="709d4213-980a-4d52-c7c5-34c31c0a723a">

``` python
## AUTH TOKEN HEADER
auth_head_tag = {'Authorization':token}

## SEND REQUEST WITH AUTH TOKEN
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag)


## PRINT INFO 
# print('HEADERS: ', r.headers, '\n\nBODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code) 
# print( 'BODY: ', r.text, '\n\nSTATUS_CODE: ', r.status_code) 

## HOLD JSON RESPONSE IN VARIALBE
json_response = json.loads(r.text)


## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']

## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']


## PRINT CURRENT AND TOTAL PAGES NUMBER
print('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')
            

## HOLD JSON OBJECTS IN VARIABLE
json_objects = json_response['data']

## PRINT HEADERS
# print ('HEADERS: ', r.headers, '\n')

## PRINT OBJECTS
# for js_object in json_objects:
#     print('JSON_OBJECT: ', js_object, '\n')

## PRINT OBJECTS AS DATA FRAME
pd.json_normalize(json_objects)
    
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  4 

```

</div>

<div class="output execute_result" data-execution_count="12">

``` 
   id        type attributes.title attributes.description attributes.mode  \
0   1  todo-lists  title-testing 1            description       initiated   
1   2  todo-lists        RECEITA 1            description       initiated   
2   3  todo-lists        RECEITA 2            description       initiated   
3   4  todo-lists        RECEITA 3            description         pending   
4   5  todo-lists        RECEITA 4            description         pending   
5   6  todo-lists        RECEITA 5            description         pending   
6   7  todo-lists        RECEITA 6            description         pending   
7   8  todo-lists        RECEITA 7            description            done   
8   9  todo-lists        RECEITA 8            description         pending   
9  10  todo-lists        RECEITA 9            description         pending   

      attributes.created-at     attributes.updated-at  attributes.items-count  
0  2022-04-04T10:50:17.377Z  2022-04-04T10:51:21.234Z                       3  
1  2022-04-04T10:50:18.294Z  2022-04-04T10:51:21.994Z                       3  
2  2022-04-04T10:50:20.374Z  2022-04-04T10:51:22.524Z                       3  
3  2022-04-04T10:50:22.451Z  2022-04-04T10:50:22.451Z                       0  
4  2022-04-04T10:50:24.559Z  2022-04-04T10:50:24.559Z                       0  
5  2022-04-04T10:50:26.651Z  2022-04-04T10:50:26.651Z                       0  
6  2022-04-04T10:50:28.778Z  2022-04-04T10:50:28.778Z                       0  
7  2022-04-04T10:50:30.849Z  2022-04-04T10:51:23.338Z                       0  
8  2022-04-04T10:50:32.909Z  2022-04-04T10:50:32.909Z                       0  
9  2022-04-04T10:50:34.982Z  2022-04-04T10:50:34.982Z                       0  
```

</div>

</div>

<div class="cell markdown" id="wuQNz3-TDPSm">

#### GET /api/todo\_lists?page=PAGENUMBER - returns a todo lists list with pagination

</div>

<div class="cell markdown" id="DNmR1XB9DPSm">

Utilize the page number to get the next page of todo lists

</div>

<div class="cell code" data-execution_count="13" data-colab="{&quot;height&quot;:687,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="VOcGvYJXDPSm" data-outputId="0687903a-fdd2-4770-cc14-8621195389fb">

``` python
## HOLD PAGE NUMBER PARAMETER IN VARIABLE
page_params = {'page': '1'}

## SEND GET REQUEST WITH PAGE NUMBER PARAMETER
r = requests.get((url +  '/api/todo_lists'), headers=auth_head_tag, params=page_params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
## PRINT CURRENT AND TOTAL PAGES NUMBER
print('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')
## HOLD JSON OBJECTS IN VARIABLE            
json_objects = json_response['data']


## PRINT HEADERS
# print ('HEADERS: ', r.headers, '\n')

## PRINT OBJECTS
# for js_object in json_objects:
#     print('JSON_OBJECT: ', js_object, '\n')

## PRINT OBJECTS AS DATA FRAME
pd.json_normalize(json_response['data'])
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  4 

```

</div>

<div class="output execute_result" data-execution_count="13">

``` 
   id        type attributes.title attributes.description attributes.mode  \
0   1  todo-lists  title-testing 1            description       initiated   
1   2  todo-lists        RECEITA 1            description       initiated   
2   3  todo-lists        RECEITA 2            description       initiated   
3   4  todo-lists        RECEITA 3            description         pending   
4   5  todo-lists        RECEITA 4            description         pending   
5   6  todo-lists        RECEITA 5            description         pending   
6   7  todo-lists        RECEITA 6            description         pending   
7   8  todo-lists        RECEITA 7            description            done   
8   9  todo-lists        RECEITA 8            description         pending   
9  10  todo-lists        RECEITA 9            description         pending   

      attributes.created-at     attributes.updated-at  attributes.items-count  
0  2022-04-04T10:50:17.377Z  2022-04-04T10:51:21.234Z                       3  
1  2022-04-04T10:50:18.294Z  2022-04-04T10:51:21.994Z                       3  
2  2022-04-04T10:50:20.374Z  2022-04-04T10:51:22.524Z                       3  
3  2022-04-04T10:50:22.451Z  2022-04-04T10:50:22.451Z                       0  
4  2022-04-04T10:50:24.559Z  2022-04-04T10:50:24.559Z                       0  
5  2022-04-04T10:50:26.651Z  2022-04-04T10:50:26.651Z                       0  
6  2022-04-04T10:50:28.778Z  2022-04-04T10:50:28.778Z                       0  
7  2022-04-04T10:50:30.849Z  2022-04-04T10:51:23.338Z                       0  
8  2022-04-04T10:50:32.909Z  2022-04-04T10:50:32.909Z                       0  
9  2022-04-04T10:50:34.982Z  2022-04-04T10:50:34.982Z                       0  
```

</div>

</div>

<div class="cell markdown" id="kpqFy43bDPSm">

##### GET /api/items?page=PAGENUMBER\&todo\_list\_id=ID - returns a list of items with pagination

</div>

<div class="cell code" data-execution_count="14" data-colab="{&quot;height&quot;:600,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="IXAR-iYlDPSm" data-outputId="5e7ba680-c56e-46c3-8a1c-43c3b33216bd">

``` python
## HOLD PAGE NUMBEBER AND TODO LIST ID PARAMETERS IN VARIABLES
page_with_todo_list_params = {'page': '1', 'todo_list_id': '2'}

## SEND GET REQUEST WITH PAGE NUMBER AND TODO LIST ID PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)


## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']

## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']

## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']

## PRINT CURRENT AND TOTAL PAGES NUMBER
print('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')


## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME
pd.json_normalize(json_todo_list_object)

```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="14">

``` 
   id      title  description       mode                created_at  \
0   2  RECEITA 1  description  initiated  2022-04-04T10:50:18.294Z   

                 updated_at  items_count  
0  2022-04-04T10:51:21.994Z            3  
```

</div>

</div>

<div class="cell code" data-execution_count="15" data-colab="{&quot;height&quot;:81,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="cjxNahb9JvTr" data-outputId="be80d83f-7b07-4d1c-b534-3a4c7bb32318">

``` python
## PRINT ITEMS OBJECTS AS DATA FRAME
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="15">

``` 
   id   name                     action      mode                created_at  \
0   4  first                  rails new   pending  2022-04-04T10:51:21.943Z   
1   6  third  rake db:create db:migrate  executed  2022-04-04T10:51:22.265Z   

                 updated_at  todo_list  
0  2022-04-04T10:51:21.943Z  RECEITA 1  
1  2022-04-04T10:51:22.391Z  RECEITA 1  
```

</div>

</div>

<div class="cell markdown" id="L7mxPsj7DPSn">

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

<div class="cell code" data-execution_count="16" data-colab="{&quot;height&quot;:135,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="n_DSXpS_DPSn" data-outputId="0a95b4e4-193d-4099-adc7-f28a083b9786">

``` python
## HOLD ITEM PARAMETERS IN VARIABLE
item_params = {'item[todo_list_id]': '2', 'item[action]': 'run on server','item[name]': 'item'}

## SEND POST REQUEST WITH ITEM PARAMETERS
r = requests.post((url + '/api/items'), headers=auth_head_tag, params=item_params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## PRINT ITEM AS DATA FRAME
pd.json_normalize(json_response['item'])
```

<div class="output execute_result" data-execution_count="16">

``` 
   id  name         action     mode                created_at  \
0  10  item  run on server  pending  2022-04-04T10:51:24.916Z   

                 updated_at  todo_list  
0  2022-04-04T10:51:24.916Z  RECEITA 1  
```

</div>

</div>

<div class="cell markdown" id="tSbSNjSfDPSn">

### GET /api/view\_item - returns a specific item with given id

Access object in view\_item show page

It change object mode to read

You can set params with "true" value to change it to other modes (**read
is setted by default if u access this endpoint**)

**Available params:** \* executed \* archived

When mode is archived, the item is not shown in the common lists (**only
can be accessed if a list of archived items is requested**)

</div>

<div class="cell code" data-execution_count="17" data-colab="{&quot;height&quot;:81,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="754dlZaTDPSo" data-outputId="c6697a22-a2bc-4aea-a557-a50afbc4a24f">

``` python
## HOLD ITEM ID PARAMETER IN VARIABLE
item_id_param = {'id': '1'}

## SEND GET REQUEST WITH ITEM ID PARAMETER
r = requests.get((url + '/api/view_item/'), headers=auth_head_tag, params=item_id_param)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## CHECK IF ITEM EXISTS
if 'data' in json_response:
    json_objects = json_response['data']
else:
    json_objects = json_response

## PRINT ITEM AS DATA FRAME
pd.json_normalize(json_objects)
```

<div class="output execute_result" data-execution_count="17">

``` 
  id   type attributes.name attributes.action attributes.mode  \
0  1  items           first         rails new            read   

      attributes.created-at     attributes.updated-at attributes.todo-list  
0  2022-04-04T10:51:21.174Z  2022-04-04T10:51:25.183Z      title-testing 1  
```

</div>

</div>

<div class="cell markdown" id="R9bROpYCDPSo">

#### GET /api/items/:id&:executed - updates an item with given id and executed status

</div>

<div class="cell code" data-execution_count="18" id="Rn5fxeQPDPSo">

``` python
## HOLD ITEM ID AND EXECUTED BOOLEAN PARAMETERS IN VARIABLE
params = {'id': '1', 'executed': 'true'}

## SEND GET REQUEST WITH ITEM ID AND EXECUTED BOOLEAN PARAMETERS
r = requests.get((url + '/api/view_item/'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## CHECK IF ITEM EXISTS
if 'data' in json_response:
    json_objects = json_response['data']
else:
    json_objects = json_response

## PRINT ITEM AS DATA FRAME
pd.json_normalize(json_objects)
```

<div class="output execute_result" data-execution_count="18">

``` 
  id   type attributes.name attributes.action attributes.mode  \
0  1  items           first         rails new        executed   

      attributes.created-at     attributes.updated-at attributes.todo-list  
0  2022-04-04T10:51:21.174Z  2022-04-04T10:51:25.550Z      title-testing 1  
```

</div>

</div>

<div class="cell markdown" id="7j3Ei5dIDPSo">

#### GET /api/items/:id&:archived - updates an item with given id and archived status

</div>

<div class="cell code" data-execution_count="19" id="eprQk1JbDPSo">

``` python
## HOLD ITEM ID AND ACHIVED BOOLEAN PARAMETERS IN VARIABLE
params = {'id': '1', 'archived': 'true'}

## SEND GET REQUEST WITH ITEM ID AND ACHIVED BOOLEAN PARAMETERS
r = requests.get((url + '/api/view_item/'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## CHECK IF ITEM EXISTS
if 'data' in json_response:
    json_objects = json_response['data']
else:
    json_objects = json_response

## PRINT ITEM AS DATA FRAME
pd.json_normalize(json_objects)
```

<div class="output execute_result" data-execution_count="19">

``` 
  id   type attributes.name attributes.action attributes.mode  \
0  1  items           first         rails new        archived   

      attributes.created-at     attributes.updated-at attributes.todo-list  
0  2022-04-04T10:51:21.174Z  2022-04-04T10:51:25.987Z      title-testing 1  
```

</div>

</div>

<div class="cell markdown" id="kw5LW8CqDPSp">

#### GET /api/items - returns all items with pagination and filter - example: object sorted by enum mode (asc)

</div>

<div class="cell markdown" id="eUxHYKqFDPSp">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="20" data-colab="{&quot;height&quot;:150,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="UGACaocODPSp" data-outputId="e219a96b-2f32-4e6d-bad5-52a91d8361cd">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'todo_list_id': '2', 'filter': 'mode_asc'}

## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']

## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']

## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']

## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')
            

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            

## PRINT TODO LIST OBJECT AS DATA FRAME
pd.json_normalize(json_todo_list_object)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="20">

``` 
   id      title  description       mode                created_at  \
0   2  RECEITA 1  description  initiated  2022-04-04T10:50:18.294Z   

                 updated_at  items_count  
0  2022-04-04T10:51:21.994Z            4  
```

</div>

</div>

<div class="cell code" data-execution_count="21" data-colab="{&quot;height&quot;:582,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="GD-JCzsYZIHB" data-outputId="d586cbc8-c164-440f-e569-a811f50ec039">

``` python
## PRINT ITEMS OBJECTS AS DATA FRAME
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="21">

``` 
   id   name                     action      mode                created_at  \
0   4  first                  rails new   pending  2022-04-04T10:51:21.943Z   
1  10   item              run on server   pending  2022-04-04T10:51:24.916Z   
2   6  third  rake db:create db:migrate  executed  2022-04-04T10:51:22.265Z   

                 updated_at  todo_list  
0  2022-04-04T10:51:21.943Z  RECEITA 1  
1  2022-04-04T10:51:24.916Z  RECEITA 1  
2  2022-04-04T10:51:22.391Z  RECEITA 1  
```

</div>

</div>

<div class="cell markdown" id="oAJ3SJPqDPSq">

#### GET /api/items?page=PAGENUMBER\&filter=MODE - returns a list of items with pagination and filter - example: object sorted by enum mode (desc)

</div>

<div class="cell markdown" id="LWHK27M5DPSq">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="22" data-colab="{&quot;height&quot;:98,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="8k9-dXOCDPSq" data-outputId="2973f0ea-22e3-4be5-e98f-8ee3299f167c">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND MODE PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'todo_list_id': '4', 'filter': 'mode_desc'}

## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']

## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']

## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']

## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

            
## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            

## PRINT TODO LIST OBJECT AS DATA FRAME
pd.json_normalize(json_todo_list_object)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="22">

``` 
   id      title  description     mode                created_at  \
0   4  RECEITA 3  description  pending  2022-04-04T10:50:22.451Z   

                 updated_at  items_count  
0  2022-04-04T10:50:22.451Z            0  
```

</div>

</div>

<div class="cell code" data-execution_count="23">

``` python
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="23">

    Empty DataFrame
    Columns: []
    Index: []

</div>

</div>

<div class="cell markdown" id="QvtwbkQIDPSq">

##### GET /api/items?page=PAGENUMBER\&filter=mode\_pending\_only\&todo\_list\_id=ID - returns a list of items with pagination and filter - example: only objects in pending mode

</div>

<div class="cell markdown" id="QV_RASTTDPSq">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="24" data-colab="{&quot;height&quot;:812,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="XiL8hfkjDPSr" data-outputId="2c646b95-6132-4d9d-c02c-2ed621d387e9">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'todo_list_id': '2', 'filter': 'mode_pending_only'}


## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']
## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
            
## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_list_object)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="24">

``` 
   id      title  description       mode                created_at  \
0   2  RECEITA 1  description  initiated  2022-04-04T10:50:18.294Z   

                 updated_at  items_count  
0  2022-04-04T10:51:21.994Z            4  
```

</div>

</div>

<div class="cell code" data-execution_count="25" data-colab="{&quot;height&quot;:645,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="WgUU1zwpxRc-" data-outputId="5d1e7914-24c4-4b6d-e92f-3f22ec6a995e">

``` python
## PRINT ITEMS OBJECTS AS DATA FRAME
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="25">

``` 
   id   name         action     mode                created_at  \
0   4  first      rails new  pending  2022-04-04T10:51:21.943Z   
1  10   item  run on server  pending  2022-04-04T10:51:24.916Z   

                 updated_at  todo_list  
0  2022-04-04T10:51:21.943Z  RECEITA 1  
1  2022-04-04T10:51:24.916Z  RECEITA 1  
```

</div>

</div>

<div class="cell markdown">

##### GET /api/items?page=PAGENUMBER\&filter=mode\_read\_only\&todo\_list\_id=ID - returns a list of items with pagination and filter - example: only objects in read mode

</div>

<div class="cell markdown">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="26">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'todo_list_id': '2', 'filter': 'mode_read_only'}


## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']
## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
            
## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_list_object)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="26">

``` 
   id      title  description       mode                created_at  \
0   2  RECEITA 1  description  initiated  2022-04-04T10:50:18.294Z   

                 updated_at  items_count  
0  2022-04-04T10:51:21.994Z            4  
```

</div>

</div>

<div class="cell code" data-execution_count="27">

``` python
## PRINT ITEMS OBJECTS AS DATA FRAME
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="27">

    Empty DataFrame
    Columns: []
    Index: []

</div>

</div>

<div class="cell markdown">

##### GET /api/items?page=PAGENUMBER\&filter=mode\_executed\_only\&todo\_list\_id=ID - returns a list of items with pagination and filter - example: only objects in executed mode

</div>

<div class="cell markdown">

Utilize the page number to get the next page of items

mode is defined in todo list and item models, it can be:

\[:pending, :read, :executed, :archived\] for items

\[:pending, :initiated, :done\] for todo lists

</div>

<div class="cell code" data-execution_count="28">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'todo_list_id': '2', 'filter': 'mode_executed_only'}


## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']
## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
            
## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_list_object)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="28">

``` 
   id      title  description       mode                created_at  \
0   2  RECEITA 1  description  initiated  2022-04-04T10:50:18.294Z   

                 updated_at  items_count  
0  2022-04-04T10:51:21.994Z            4  
```

</div>

</div>

<div class="cell code" data-execution_count="29">

``` python
## PRINT ITEMS OBJECTS AS DATA FRAME
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="29">

``` 
   id   name                     action      mode                created_at  \
0   6  third  rake db:create db:migrate  executed  2022-04-04T10:51:22.265Z   

                 updated_at  todo_list  
0  2022-04-04T10:51:22.391Z  RECEITA 1  
```

</div>

</div>

<div class="cell markdown">

#### GET /apiview\_todo\_list/:id&:initiated - updates an todo list with given id and initiated status mode

</div>

<div class="cell code" data-execution_count="30">

``` python
## HOLD AUTHORIZATION TOKEN HEADER
auth_head_tag = {'Authorization':token}
params = {'id': '5', 'initiated': 'true'}
## SEND GET REQUEST WITH AUTHORIZATION TOKEN
r = requests.get((url + '/api/view_todo_list'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON: ', json_response)

## HOLD STATUS CODE IN VARIABLE
status = r.status_code
## WHEN THE REQUEST IS SUCCESSFUL, THE STATUS CODE IS 200

## PRINT STATUS CODE
print('STATUS_CODE: ', status)

## PRITN JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output stream stdout">

    STATUS_CODE:  500

</div>

<div class="output execute_result" data-execution_count="30">

``` 
   status                  error  \
0     500  Internal Server Error   

                                          exception  \
0  #<ArgumentError: 'intiated' is not a valid mode>   

                            traces.Application Trace  \
0  [{'exception_object_id': 28360, 'id': 22, 'tra...   

                              traces.Framework Trace  \
0  [{'exception_object_id': 28360, 'id': 0, 'trac...   

                                   traces.Full Trace  
0  [{'exception_object_id': 28360, 'id': 0, 'trac...  
```

</div>

</div>

<div class="cell markdown">

#### GET /apiview\_todo\_list/:id&:done - updates an todo list with given id and done status mode

</div>

<div class="cell code" data-execution_count="31">

``` python
## HOLD AUTHORIZATION TOKEN HEADER
auth_head_tag = {'Authorization':token}
params = {'id': '6', 'done': 'true'}
## SEND GET REQUEST WITH AUTHORIZATION TOKEN
r = requests.get((url + '/api/view_todo_list'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON: ', json_response)

## HOLD STATUS CODE IN VARIABLE
status = r.status_code
## WHEN THE REQUEST IS SUCCESSFUL, THE STATUS CODE IS 200

## PRINT STATUS CODE
print('STATUS_CODE: ', status)

## PRITN JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output stream stdout">

    STATUS_CODE:  200

</div>

<div class="output execute_result" data-execution_count="31">

``` 
  data.id   data.type data.attributes.title data.attributes.description  \
0       6  todo-lists             RECEITA 5                 description   

  data.attributes.mode data.attributes.created-at data.attributes.updated-at  \
0                 done   2022-04-04T10:50:26.651Z   2022-04-04T10:51:30.126Z   

   data.attributes.items-count  
0                            0  
```

</div>

</div>

<div class="cell markdown">

##### GET /api/todo\_lists?page=PAGENUMBER\&filter=mode\_pending\_only - returns a list of items with pagination and filter - example: only objects in pending mode

</div>

<div class="cell code" data-execution_count="32">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'filter': 'mode_pending_only'}


## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_lists_objects = json_response['data']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
            
## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_lists_objects)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  3 

```

</div>

<div class="output execute_result" data-execution_count="32">

``` 
   id        type attributes.title attributes.description attributes.mode  \
0   4  todo-lists        RECEITA 3            description         pending   
1   5  todo-lists        RECEITA 4            description         pending   
2   7  todo-lists        RECEITA 6            description         pending   
3   9  todo-lists        RECEITA 8            description         pending   
4  10  todo-lists        RECEITA 9            description         pending   
5  11  todo-lists       RECEITA 10            description         pending   
6  12  todo-lists       RECEITA 11            description         pending   
7  13  todo-lists       RECEITA 12            description         pending   
8  14  todo-lists       RECEITA 13            description         pending   
9  15  todo-lists       RECEITA 14            description         pending   

      attributes.created-at     attributes.updated-at  attributes.items-count  
0  2022-04-04T10:50:22.451Z  2022-04-04T10:50:22.451Z                       0  
1  2022-04-04T10:50:24.559Z  2022-04-04T10:50:24.559Z                       0  
2  2022-04-04T10:50:28.778Z  2022-04-04T10:50:28.778Z                       0  
3  2022-04-04T10:50:32.909Z  2022-04-04T10:50:32.909Z                       0  
4  2022-04-04T10:50:34.982Z  2022-04-04T10:50:34.982Z                       0  
5  2022-04-04T10:50:37.053Z  2022-04-04T10:50:37.053Z                       0  
6  2022-04-04T10:50:39.136Z  2022-04-04T10:50:39.136Z                       0  
7  2022-04-04T10:50:41.202Z  2022-04-04T10:50:41.202Z                       0  
8  2022-04-04T10:50:43.327Z  2022-04-04T10:50:43.327Z                       0  
9  2022-04-04T10:50:45.469Z  2022-04-04T10:50:45.469Z                       0  
```

</div>

</div>

<div class="cell markdown">

##### GET /api/todo\_lists?page=PAGENUMBER\&filter=mode\_initiated\_only - returns a list of items with pagination and filter - example: only objects in initiated mode

</div>

<div class="cell code" data-execution_count="33">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'filter': 'mode_initiated_only'}


## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_lists_objects = json_response['data']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
            
## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_lists_objects)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="33">

``` 
  id        type attributes.title attributes.description attributes.mode  \
0  1  todo-lists  title-testing 1            description       initiated   
1  2  todo-lists        RECEITA 1            description       initiated   
2  3  todo-lists        RECEITA 2            description       initiated   

      attributes.created-at     attributes.updated-at  attributes.items-count  
0  2022-04-04T10:50:17.377Z  2022-04-04T10:51:21.234Z                       3  
1  2022-04-04T10:50:18.294Z  2022-04-04T10:51:21.994Z                       4  
2  2022-04-04T10:50:20.374Z  2022-04-04T10:51:22.524Z                       3  
```

</div>

</div>

<div class="cell markdown">

##### GET /api/todo\_lists?page=PAGENUMBER\&filter=mode\_done\_only - returns a list of items with pagination and filter - example: only objects in done mode

</div>

<div class="cell code" data-execution_count="34">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'filter': 'mode_done_only'}


## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER PARAMETERS
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_lists_objects = json_response['data']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']
            
## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')
            
## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_lists_objects)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="34">

``` 
  id        type attributes.title attributes.description attributes.mode  \
0  6  todo-lists        RECEITA 5            description            done   
1  8  todo-lists        RECEITA 7            description            done   

      attributes.created-at     attributes.updated-at  attributes.items-count  
0  2022-04-04T10:50:26.651Z  2022-04-04T10:51:30.126Z                       0  
1  2022-04-04T10:50:30.849Z  2022-04-04T10:51:23.338Z                       0  
```

</div>

</div>

<div class="cell markdown" id="fJn8O4C8DPSr">

##### GET /api/items?page=PAGENUMBER\&filter\_factor\&todo\_list\_id=ID - returns a list of items with pagination and filter - example: object sorted by selected factor

</div>

<div class="cell markdown" id="85OH6HeADPSr">

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

<div class="cell code" data-execution_count="42" data-colab="{&quot;height&quot;:830,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="Olx8AfJsDPSr" data-outputId="ea185cce-3ad9-4926-cb82-fe26d69918fd">

``` python
## HOLD PAGE NUMBER, TODO LIST ID AND FILTER FACTOR ORDER NUMBER PARAMETERS IN VARIABLE
page_with_todo_list_params = {'page': '1', 'todo_list_id': '1', 'filter_factor': '2'}

## SEND GET REQUEST WITH PAGE NUMBER, TODO LIST ID AND FILTER FACTOR ORDER NUMBER PARAMETERS
r = requests.get((url + '/api/items'), headers=auth_head_tag, params=page_with_todo_list_params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## HOLD TODO LIST OBJECT IN VARIABLE
json_todo_list_object = json_response['todo_list']
## HOLD ITEMS OBJECTS IN VARIABLE
json_items_objects = json_response['items']

## HOLD TOTAL COUNT OF PAGES
total_pages = r.headers['Total-Pages']
## HOLD CURRENT PAGE NUMBER
current_page = r.headers['Current-Page']


## PRINT CURRENT AND TOTAL PAGES NUMBER
print ('CURRENT PAGE: ', current_page, '\n\nTOTAL PAGES: ', total_pages, '\n')

## PRINT TODO LIST OBJECT
# print("TODO LIST: ", json_todo_list_object, '\n')

            
## PRINT ITEMS OBJECTS
# for item in json_items_objects:
#     print('ITEM: ', item, '\n')

## PRINT TODO LIST OBJECT AS DATA FRAME'
pd.json_normalize(json_todo_list_object)
```

<div class="output stream stdout">

``` 
CURRENT PAGE:  1 

TOTAL PAGES:  1 

```

</div>

<div class="output execute_result" data-execution_count="42">

``` 
   id            title  description       mode                created_at  \
0   1  title-testing 1  description  initiated  2022-04-04T10:50:17.377Z   

                 updated_at  items_count  
0  2022-04-04T10:51:21.234Z            3  
```

</div>

</div>

<div class="cell code" data-execution_count="43" data-colab="{&quot;height&quot;:645,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="8TwPrQw7xkyR" data-outputId="d5f57235-1053-4c52-8d10-3330227e31b1">

``` python
## PRINT ITEMS OBJECTS AS DATA FRAME
pd.json_normalize(json_items_objects)
```

<div class="output execute_result" data-execution_count="43">

``` 
   id    name     action      mode                created_at  \
0   1   first  rails new  archived  2022-04-04T10:51:21.174Z   
1   2  second     bundle  archived  2022-04-04T10:51:21.571Z   

                 updated_at        todo_list  
0  2022-04-04T10:51:25.987Z  title-testing 1  
1  2022-04-04T10:51:21.685Z  title-testing 1  
```

</div>

</div>

<div class="cell markdown" id="bJdzPGCZDPSs">

**TODOS COMMOM ORDERS:**

    common_order = [:pending, :initiatied, :done]
    its_like = [0, 1, 2]
    
    asc = comom_order
    desc = [2 ,1 ,0]

**TODO LISTS FACTORED ORDERS(MATRIX):**

    0 = [0, 1, 2]
    1 = [1, 2, 0]
    2 = [2, 0, 1]
    3 = [0, 2, 1]
    4 = [1, 0, 2]
    5 = [2, 1, 0]

</div>

<div class="cell code" data-execution_count="37" data-colab="{&quot;height&quot;:618,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="nqVldwjwDPSs" data-outputId="012c3b6d-46e5-491d-a849-e9ad0bdba5ad">

``` python
## HOLD PAGE NUMBER AND FILTER FACTOR ORDER NUMBER PARAMETERS IN VARIABLE
params = { 'page': 1, 'filter_factor': 1 }

## SEND GET REQUEST WITH PAGE NUMBER AND FILTER FACTOR ORDER NUMBER PARAMETERS
r = requests.get((url + '/api/todo_lists'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE DATA IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE DATA AS DATA FRAME
pd.json_normalize(json_response['data'])
```

<div class="output execute_result" data-execution_count="37">

``` 
   id        type attributes.title attributes.description attributes.mode  \
0   3  todo-lists        RECEITA 2            description       initiated   
1   1  todo-lists  title-testing 1            description       initiated   
2   2  todo-lists        RECEITA 1            description       initiated   
3   6  todo-lists        RECEITA 5            description            done   
4   8  todo-lists        RECEITA 7            description            done   
5   7  todo-lists        RECEITA 6            description         pending   
6  10  todo-lists        RECEITA 9            description         pending   
7   9  todo-lists        RECEITA 8            description         pending   
8   5  todo-lists        RECEITA 4            description         pending   
9   4  todo-lists        RECEITA 3            description         pending   

      attributes.created-at     attributes.updated-at  attributes.items-count  
0  2022-04-04T10:50:20.374Z  2022-04-04T10:51:22.524Z                       3  
1  2022-04-04T10:50:17.377Z  2022-04-04T10:51:21.234Z                       3  
2  2022-04-04T10:50:18.294Z  2022-04-04T10:51:21.994Z                       4  
3  2022-04-04T10:50:26.651Z  2022-04-04T10:51:30.126Z                       0  
4  2022-04-04T10:50:30.849Z  2022-04-04T10:51:23.338Z                       0  
5  2022-04-04T10:50:28.778Z  2022-04-04T10:50:28.778Z                       0  
6  2022-04-04T10:50:34.982Z  2022-04-04T10:50:34.982Z                       0  
7  2022-04-04T10:50:32.909Z  2022-04-04T10:50:32.909Z                       0  
8  2022-04-04T10:50:24.559Z  2022-04-04T10:50:24.559Z                       0  
9  2022-04-04T10:50:22.451Z  2022-04-04T10:50:22.451Z                       0  
```

</div>

</div>

<div class="cell markdown" id="042-ss_ADPSs">

##### GET /api/delete\_todo\_list - deletes a todo list with given id

</div>

<div class="cell code" data-execution_count="38" data-colab="{&quot;height&quot;:115,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="lTu_CvTvDPSs" data-outputId="f9826044-ac2e-4937-c695-4b2c93157b63">

``` python
## HOLD TODO LIST ID PARAMETER IN VARIABLE
params = {'id': '4'}

## SEND GET REQUEST WITH TODO LIST ID PARAMETER
r = requests.get((url + '/api/delete_todo_list'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## PRINT JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="38">

``` 
                          message
0  Todo list deleted successfully
```

</div>

</div>

<div class="cell markdown" id="aZcwhZdxDPSs">

##### GET /api/remove\_item - deletes an item with given id

</div>

<div class="cell code" data-execution_count="39" data-colab="{&quot;height&quot;:115,&quot;base_uri&quot;:&quot;https://localhost:8080/&quot;}" id="HKaQr8sYDPSt" data-outputId="56960009-232a-474d-a2fe-e17675e1238a">

``` python
## HOLD ITEM ID PARAMETER IN VARIABLE
params = {'id': '8'}

## SEND GET REQUEST WITH ITEM ID PARAMETER
r = requests.get((url + '/api/remove_item'), headers=auth_head_tag, params=params)

## HOLD JSON RESPONSE IN VARIABLE
json_response = json.loads(r.text)

## PRINT JSON RESPONSE
# print('JSON_RESPONSE: ', json_response, '\n')

## PRINT JSON RESPONSE AS DATA FRAME
pd.json_normalize(json_response)
```

<div class="output execute_result" data-execution_count="39">

``` 
        message
0  Item deleted
```

</div>

</div>





**Developed by: JesusGautamah**

Other repositories:

In Development Outerspace Coding Website with rails 7, tailwindcss, sidekiq & cron jobs
* [Github](https://github.com/JesusGautamah/outerspace_coding)

CrawlerOnRails with Docker and Sidekiq
* [Github](https://github.com/JesusGautamah/CrawlerOnRails)

Simple Flutter IMC Calculator
* [Github](https://github.com/JesusGautamah/imc_calculator)

(Contributed with backend) Simple Flutter CryptoWallet
* [Github](https://github.com/angelorange/bank_space)

EasyProxy Shell
* [Github](https://github.com/JesusGautamah/EasyProxy)


Old Rails and docker development check point
* [Github](https://github.com/JesusGautamah/rails-docker)





