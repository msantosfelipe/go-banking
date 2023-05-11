# go-banking

## Development
- Running postgres container `docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14.2`

- Install https://github.com/golang-migrate/migrate and run `migrate create -ext sql -dir db/migration -seq init_schema`

