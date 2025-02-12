import pandas as pd
import requests
from sqlalchemy import Engine


def load_raw_api_data(api_url: str) -> pd.DataFrame:
    """Request GET data from url and store in dataframe"""
    r = requests.get(api_url)
    df = pd.DataFrame(r.json())

    return df


def insert_into_db(
    engine: Engine, *, table_name: str, df: pd.DataFrame
) -> pd.DataFrame:
    """
    Insert data into database and return a DF with all rows from the table,
    including any new columns created by the database
    """
    with engine.begin() as conn:
        df.to_sql(name=table_name, con=conn, if_exists="append", index=False)

        new_df = pd.read_sql_table(table_name=table_name, con=conn)

        return new_df
