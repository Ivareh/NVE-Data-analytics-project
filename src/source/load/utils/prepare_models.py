from collections.abc import Iterable

import pandas as pd


def prepare_areas(area_df: pd.DataFrame) -> pd.DataFrame:
    """Prepares area for inserting into db"""

    def normalize_and_assign_areas(area_df: pd.DataFrame, area: str) -> pd.DataFrame:
        return pd.json_normalize(area_df[area].iloc[0]).assign(current_area=area)

    areas = ["land", "elspot", "vassdrag"]
    result_df = pd.concat(
        (normalize_and_assign_areas(area_df, area) for area in areas),
        ignore_index=True,
    ).rename(columns={"omrType": "omr_type"})

    return result_df


def prepare_dates(years: Iterable[int]) -> pd.DataFrame:
    """
    Create a DataFrame modeled "dates" with all date data for given years,
    ready for db insertion
    """

    # Generate all dates for the given years
    date_range = pd.date_range(start=f"{min(years)}-01-01", end=f"{max(years)}-12-31")

    df = pd.DataFrame(
        {
            "iso_dato": date_range,
            "iso_aar": date_range.year,
            "maaling_uke": date_range.isocalendar().week + 3,  # Start week at sundays
            "iso_maaned": date_range.month,
            "iso_dag": date_range.day,
        },
    ).reset_index(drop=True)

    return df


def prepare_magasin(
    magasin_df: pd.DataFrame, dato_db_df: pd.DataFrame, area_db_df: pd.DataFrame
) -> pd.DataFrame:
    """Prepares magasin statistics for inserting into db"""
    magasin_df = (
        magasin_df.merge(
            right=dato_db_df[["id", "iso_dato"]],
            how="left",
            left_on="dato_id",
            right_on="iso_dato",
            validate="m:1",
        )
        .drop(columns=["dato_id"])
        .rename(columns={"id": "dato_id"})
        .merge(
            right=area_db_df[["id", "omr_type", "omrnr"]],
            how="left",
            left_on=["omrnr", "omr_type"],
            right_on=["omrnr", "omr_type"],
            validate="m:1",
        )
        .rename(columns={"id": "area_id"})
        .drop(columns=["iso_dato", "omrnr", "omr_type"])
    )

    return magasin_df


def prepare_magasin_min_max(
    magasin_min_max_df: pd.DataFrame, area_db_df: pd.DataFrame
) -> pd.DataFrame:
    """Prepares magasin statistics with min max median for inserting into db"""
    magasin_min_max_df["iso_uke"] += 3
    magasin_min_max_df = (
        magasin_min_max_df.rename(
            columns={
                "iso_uke": "maaling_uke",
                "omrType": "omr_type",
                "minFyllingsgrad": "min_fyllingsgrad",
                "minFyllingTWH": "min_fylling_twh",
                "medianFyllingsGrad": "median_fyllingsgrad",
                "medianFylling_TWH": "median_fylling_twh",
                "maxFyllingsgrad": "max_fyllingsgrad",
                "maxFyllingTWH": "max_fylling_twh",
            }
        )
        .merge(
            right=area_db_df[["id", "omr_type", "omrnr"]],
            how="left",
            left_on=["omrnr", "omr_type"],
            right_on=["omrnr", "omr_type"],
            validate="m:1",
        )
        .rename(columns={"id": "area_id"})
        .drop(columns=["omrnr", "omr_type"])
    )

    return magasin_min_max_df
