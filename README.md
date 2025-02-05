# Case Study Evaluation Instructions
- You can find a general description of the tasks under `Deel - Files.pdf`
- You can find Task 1 in `part_1_exploration_ingestion.ipynb` and the data profiling under `eda_reports/`
- You can find the answers to the 3 questions of Task 2 here:
  1. What is the acceptance rate over time?
    - dbt model: `dbt_warehouse/models/marts/payments/acceptance_rate_by_day.sql`
    - output: `output_task_2/acceptance_rate_by_day.csv`
  2. List the countries where the amount of declined transactions went over $25M
    - dbt model: `dbt_warehouse/models/marts/payments/amount_declined_over_25m_by_country.sql`
    - output: `output_task_2/amount_declined_over_25m_by_country.csv`
  3. Which transactions are missing chargeback data?
    - dbt model: `dbt_warehouse/models/marts/payments/transactions_missing_chargeback.sql`
    - output: `output_task_2/transactions_missing_chargeback.csv`


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