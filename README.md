# Setup
1. Rename `.env.template` to `.env`
1. Start a postgres container by running the following command, according to your .env file:
```
docker run --name postgres_container -d \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -e POSTGRES_DB=prod_dwh \
  -p 5432:5432 \
  postgres:17.2-alpine3.21
```
2. Create the raw schema in the database:
```
docker exec -it postgres_container psql -U postgres -d prod_dwh -c "CREATE SCHEMA IF NOT EXISTS raw;"
```
3. Set up a virtual environment and install dependencies:
```
python -m venv venv  
source venv/bin/activate  # Use `venv\Scripts\activate` on Windows  
pip install -r requirements.txt  
```
4. Run `cd dbt_warehouse`
5. Run `part_1_exploration_ingestion.ipynb`
6. Run `dbt test` and `dbt run` (or `dbt build`)