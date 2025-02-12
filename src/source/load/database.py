from sqlalchemy import create_engine

from load.load_config import load_settings

engine = create_engine(str(load_settings.SRC_DB_URI))
