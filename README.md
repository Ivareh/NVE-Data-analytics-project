# Extract, load, transform and visualize Reservoir Statistcs data

Application which uses data from the norwegian Reservoir Statistics api endpoints.

The data goes through the processes:

  - Extracted from the [Reservoir Statistics API](https://biapi.nve.no/magasinstatistikk/swagger/index.html)
  - Transformed to fit the PostgreSQL schemas in database with Pandas
  - Loaded into the database
  - Further transformed with SQL queries and DBT
  - Visualization with Power BI or Looker studio


## Tech Stack

  - Python (Pandas, SQLAlchemy, Pydantic, requests, logging)
  - [PostgreSQL](https://www.postgresql.org/)
  - [DBT](https://www.getdbt.com/)
  - [Docker](https://www.docker.com/)
  - Power BI / Google Looker studio
