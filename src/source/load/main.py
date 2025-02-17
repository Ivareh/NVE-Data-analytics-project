import pandas as pd

from load.database import engine
from load.load_config import load_settings
from load.logs.logger import main_logger, setup_logging
from load.utils.prepare_models import (
    prepare_areas,
    prepare_dates,
    prepare_magasin,
    prepare_magasin_min_max,
)
from load.utils.utils import insert_into_db, load_raw_api_data

BIAPI_STR_PREFIX = load_settings.BIAPI_STR_PREFIX


def main():
    setup_logging()
    main_logger.info(
        "Starting extract and load script with NVE magasin statistics for source database..."
    )

    area_df = load_raw_api_data(api_url=BIAPI_STR_PREFIX + "/HentOmråder")

    area_df = prepare_areas(area_df)
    main_logger.debug(
        "Loaded and prepared area df from '$BIAPI_STR_PREFIX/HentOffentligData'"
    )

    magasin_df = load_raw_api_data(api_url=BIAPI_STR_PREFIX + "/HentOffentligData")

    magasin_date_columns = [
        ("dato_Id", "%Y-%m-%d"),
        ("neste_Publiseringsdato", "%Y-%m-%dT%H:%M:%S"),
    ]

    # Sets correct datatypes in date columns
    for col, date_format in magasin_date_columns:
        magasin_df[col] = pd.to_datetime(
            magasin_df[col],
            format=date_format,
            errors="coerce",  # Handle invalid dates as NaT (like 0001-01-01T00:00:00)
        )

    main_logger.debug(
        "Loaded magasin statistics from '$BIAPI_STR_PREFIX/HentOffentligData'"
    )

    iso_aar = magasin_df["iso_aar"].unique()

    dato_df = prepare_dates(iso_aar)
    main_logger.debug("Loaded and prepared 'dates'")

    magasin_df = magasin_df.drop(columns=["iso_aar", "iso_uke"])
    magasin_df = magasin_df.rename(
        columns={
            "dato_Id": "dato_id",
            "omrType": "omr_type",
            "kapasitet_TWh": "kapasitet_twh",
            "fylling_TWh": "fylling_twh",
            "fyllingsgrad": "fyllingsgrad",
            "neste_Publiseringsdato": "neste_publiseringsdato",
        }
    )
    main_logger.debug(
        "Dropped columns ['iso_aar', 'maaling_uke'] and renamed in magasin_df"
    )

    dato_db_df = insert_into_db(engine, table_name="dates", df=dato_df)
    main_logger.debug("Loaded dato data into db")

    area_db_df = insert_into_db(engine, table_name="area", df=area_df)
    main_logger.debug("Loaded area data into db")

    magasin_df = prepare_magasin(magasin_df, dato_db_df, area_db_df)

    # Insert magasin_df into db
    insert_into_db(engine, table_name="magasinstatistikk_model", df=magasin_df)
    main_logger.debug("Prepared and loaded magasin statistics data into db")

    magasin_min_max_df = load_raw_api_data(
        api_url=BIAPI_STR_PREFIX + "/HentOffentligDataMinMaxMedian"
    )

    magasin_min_max_df = prepare_magasin_min_max(magasin_min_max_df, area_db_df)

    insert_into_db(
        engine,
        table_name="magasinstatistikk_min_max_median_model",
        df=magasin_min_max_df,
    )
    main_logger.debug("Prepared and loaded magasin min max median data into db")

    main_logger.info("Finished loading NVE magasin API data into source db")


if __name__ == "__main__":
    main()
