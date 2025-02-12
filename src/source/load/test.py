import pandas as pd
from pydantic_core import MultiHostUrl
from sqlalchemy import create_engine

POSTGRES_USER = "postgres"
POSTGRES_PASSWORD = "changethis"

POSTGRES_SRC_SERVER = "localhost"
POSTGRES_SRC_PORT = 5433
POSTGRES_SRC_DB = "source_nve_db"


def SRC_DB_URI():
    url = MultiHostUrl.build(
        scheme="postgresql",
        username=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
        host=POSTGRES_SRC_SERVER,
        port=POSTGRES_SRC_PORT,
        path=POSTGRES_SRC_DB,
    )
    return url


engine = create_engine(str(SRC_DB_URI()))

df = pd.DataFrame(["hey"])

with engine.begin() as conn:
    df.to_sql(name="area", con=conn, if_exists="append", index=False)

    new_df = pd.read_sql_table(table_name="area", con=conn)
