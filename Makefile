postgres:
	docker run --name postgres16.3 -p 5433:5432 -e POSTGRES_PASSWORD=secret -d postgres:16.3

createdb:
	docker exec -it postgres16.3 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres16.3 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5433/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc