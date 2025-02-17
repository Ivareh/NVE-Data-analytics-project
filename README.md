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


![image](https://github.com/user-attachments/assets/6ad6cb98-95c2-487e-907e-f4f77bfa1892)


![image](https://github.com/user-attachments/assets/4ca263ad-ed3e-49f4-831a-16a84cfcb942)



![image](https://github.com/user-attachments/assets/e76b4354-3e9d-4e95-9b58-2457ede49703)



![image](https://github.com/user-attachments/assets/343b61b0-b326-4ab7-b7a5-fd9501291dc1)



## Example of a DBT model created


![image](https://github.com/user-attachments/assets/3195559a-7165-45c9-8fda-73d9398856fe)


  
