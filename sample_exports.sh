# user: <%= ENV["POSTGRES_DB] %>
# user: <%= ENV["POSTGRES_USER"] %>
# password: <%= ENV["POSTGRES_PASSWORD"] %>
# host: <%= ENV["POSTGRES_HOST"] %>
# port: <%= ENV["POSTGRES_PORT"] %>

export POSTGRES_DB=
export POSTGRES_USER=
export POSTGRES_PASSWORD=
export POSTGRES_HOST=
export POSTGRES_PORT=

# database: <%= ENV["POSTGRES_TEST_DB"] %>
# user: <%= ENV["POSTGRES_TEST_USER"] %>
# password: <%= ENV["POSTGRES_TEST_PASSWORD"] %>
# host: <%= ENV["POSTGRES_TEST_HOST"] %>
# port: <%= ENV["POSTGRES_TEST_PORT"] %>

export POSTGRES_TEST_DB=
export POSTGRES_TEST_USER=
export POSTGRES_TEST_PASSWORD=
export POSTGRES_TEST_HOST=
export POSTGRES_TEST_PORT=

# address: ENV['SMTP_ADDRESS'],
# port: ENV['SMTP_PORT'],
# user_name: ENV['SMTP_USERNAME'],
# password: ENV['SMTP_PASSWORD'],


export SMTP_ADDRESS=
export SMTP_PORT=
export SMTP_USERNAME=
export SMTP_PASSWORD=


# SET IT STAGING OR PRODUCTION (deploy variable)

# export SERVER_MODE=staging