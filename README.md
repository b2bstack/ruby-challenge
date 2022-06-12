# B2B STACK
Developer Ruby Backend

#Doc Postman API view:
please chech this file [Api.postman_collection.json] in [Docs] folder
or
https://www.postman.com/warped-firefly-28117/workspace/b2b-stack/overview

#User Api
http://localhost:3000/users/sign_in

for generate new user run this:
User.create(email: 'your_mail@server.com', password: '123456')

Must send header params:
X-User-Email:suporte@marcomapa.com
X-User-Token:Y4M4b_XHVsMAFR7gQqwy

# SPECIFICATION PROJECT:
1-) ruby-challenge - Web service to manage TO-DO lists
[port:3000]
Gems:
pg
Devise
Devise Simple Token
Rack Cors
Rack Attack
kaminari

#ALTER PASSOWRD TO POSTGRES USER:
EDITOR=nano rails credentials:edit


####################################

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

## Some hints of what we expect to see are:
Basic instructions on how to run the project;
Details about your solution, we would like to know what was your rationale in the decisions;
In case something is not clear and you need to recognize some premise, which means it motivated you to make decisions.
