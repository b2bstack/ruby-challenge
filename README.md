# Desafio Rails

The API must have the following features:

- Create an item
- Remove an item (remove, not destroy (soft delete))
- Archive an item (update, is_archived = true)
- Mark an item as read (update, is_readed = true)
- Mark an item as executed (update, is_executed = true)
- List items according to their status (filter with params)
- Pagination

## Setup

- Configurar o banco de dados de acordo com a sessão [Database](#database).
- Rodar os comandos:

```sh
# Executa as migrations de acordo com os schemas criados.
rails db:migrate

# Popula o banco de dados com os dados de teste.
rails db:seed

# Serve a aplicação em modo de desenvolvimento (-e development).
rails s
```

## Database

> Rodar o credencials:edit para cada ambiente, e inserir o conteúdo conforme
elucidado.

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
