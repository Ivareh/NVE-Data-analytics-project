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

## Data from 17.02.2025

![NVE_data_analytics_report_-_Ivar_Haugland_page-0021](https://github.com/user-attachments/assets/64acd779-209b-468c-be20-8bfb3e3e26f7)


![NVE_data_analytics_report_-_Ivar_Haugland_page-0022](https://github.com/user-attachments/assets/5751c5d8-bf77-4255-95a8-bd7d9af1ac0e)



![NVE_data_analytics_report_-_Ivar_Haugland_page-0023](https://github.com/user-attachments/assets/deafd311-a732-4055-a506-2284b7311a50)



![NVE_data_analytics_report_-_Ivar_Haugland_page-0024](https://github.com/user-attachments/assets/fd802d0f-0a89-4cd1-b9d2-90b31fc29f75)


## Example of a DBT model created


![NVE_data_analytics_report_-_Ivar_Haugland_page-0019](https://github.com/user-attachments/assets/81942d45-18d1-45c3-9438-808fc7ffc30c)



  
