# Rails Challenge

The API must have the following features:

- Create an item
- Remove an item (remove, not destroy (soft delete))
- Archive an item (update, is_archived = true)
- Mark an item as read (update, is_readed = true)
- Mark an item as executed (update, is_executed = true)
- List items according to their status (filter with params)
- Pagination

## Setup

- Configure database based on [Database](#database) session.
- Execute the following commands:

```sh
# Execute the migrations based on the created schema.
rails db:migrate

# Populate database with initial data.
rails db:seed

# Run the application.
rails s
```

## Database

> Run credentials:edit for each environment, and apply the following content.

```sh
EDITOR="code --wait" rails credentials:edit -e development
```

```yaml
db:
  url: 'postgresql://postgres:postgres@localhost/desafio_dev'
```

---

```sh
EDITOR="code --wait" rails credentials:edit -e production
```

```yaml
db:
  url: 'postgresql://postgres:postgres@localhost/desafio_prod'
```

---

```sh
EDITOR="code --wait" rails credentials:edit -e test
```

```yaml
db:
  url: 'postgresql://postgres:postgres@localhost/desafio_test'
```

## Postman
- For the API route tests, was added a folder called `postman` in rails root path, with `.json` to be imported.
  - TodoItem attributes:
    - `is_archived`: Boolean - which returns if TODO item is archived.
    - `is_readed`: Boolean - which returns if TODO item is readed.
    - `is_executed`: Boolean - which returns if TODO item is executed.
    - `title`: String - which returns the title of TODO item.
    - `description`: Text - which returns the description of TODO item.
    - `weight`: Integer - which returns the weight of TODO item.
