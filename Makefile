CONTAINER_NAME=postgres12
DB_USER=root
DB_PASS=secret

.PHONY: create-db-container up-db create-db drop-db migrate-up migrate-down create-project test

create-db-container: 
	docker run --name $(CONTAINER_NAME) -p 5432:5432 -e POSTGRES_USER=$(DB_USER) -e POSTGRES_PASSWORD=$(DB_PASS) -d postgres:14.2

up-db:
	docker start $(CONTAINER_NAME)

create-db:
	docker exec -it $(CONTAINER_NAME) createdb --username=$(DB_USER) --owner=$(DB_USER) simple_bank

drop-db:
	docker exec -it $(CONTAINER_NAME) dropdb simple_bank

migrate-up:
	migrate -path db/migration -database "postgresql://$(DB_USER):$(DB_PASS)@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrate-down:
	migrate -path db/migration -database "postgresql://$(DB_USER):$(DB_PASS)@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

#
create-project: create-db-container sleep 3 create-db migrate-up

test:
	go test -v -cover ./...