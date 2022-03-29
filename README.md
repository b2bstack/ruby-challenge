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

## Some hints of what we expect to see are:
Basic instructions on how to run the project;
Details about your solution, we would like to know what was your rationale in the decisions;
In case something is not clear and you need to recognize some premise, which means it motivated you to make decisions.
