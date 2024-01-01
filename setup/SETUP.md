# 1. Setup PostgreSQL
Follow instruction to setup `AdventureWorks` for Postgres from [lorint](https://github.com/lorint/AdventureWorks-for-Postgres?source=post_page-----28e335be5f7e--------------------------------)

*Expected output*:

![](../public/imgs/AdventureWork_PostgreSQL.png?raw=true)

# 2. Setup conda environment
- Create conda environment.
```bash
conda create -n DBT python=3.9 -y
```

- Activate conda environment.
```bash
conda activate DBT
```

- Install dependancies.
```bash
pip install -r requirements.txt
```

# 3. Initialize DBT workspace
*Syntax*: `dbt init <dbt_project_name>`

```bash
dbt init dbt_postgresql
```

Then select type database is `postgres`.

You need specific config like:
```bash
host (hostname for the instance): localhost
port [5432]: 5432
user (dev username): postgres
pass (dev password): 
dbname (default database that dbt will build objects in): Adventureworks
schema (default schema that dbt will build objects in): warehouse
threads (1 or more) [1]: 4
```

*Expected output*: New 2 folders:
- `logs`: By default, dbt will write logs to a directory named `logs/`.
- `dbt_postgresql`: dbt project folder.

*Note:* schema name `warehouse` if not exist then will be created.

You can change the config again in ~/.dbt/profiles.yml. The expected content in profiles.yml:
```bash
dbt_postgresql:
  outputs:
    dev:
      dbname: Adventureworks
      host: localhost
      pass: Kosnhan123
      port: 5432
      schema: warehouse
      threads: 4
      type: postgres
      user: postgres
  target: dev
```

