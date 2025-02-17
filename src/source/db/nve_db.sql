-- Contains source data models (similar as in from extracted API data)

CREATE TABLE dates (
    id BIGSERIAL PRIMARY KEY,
    iso_dato DATE NOT NULL UNIQUE,
    iso_aar INTEGER NOT NULL,
    maaling_uke INTEGER NOT NULL, -- Week of measuring
    iso_maaned INTEGER NOT NULL,
    iso_dag INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS area (
    id SERIAL PRIMARY KEY,
    navn TEXT,
    navn_langt TEXT,
    beskrivelse TEXT,
    omr_type TEXT,
    omrnr INTEGER NOT NULL,
    current_area TEXT NOT NULL,
    UNIQUE(omr_type, omrnr)
);

CREATE TABLE IF NOT EXISTS magasinstatistikk_model (
    id BIGSERIAL PRIMARY KEY,
    dato_id BIGINT,
    area_id BIGINT NOT NULL,
    fyllingsgrad NUMERIC(10, 6) NOT NULL,
    kapasitet_twh NUMERIC(10, 6) NOT NULL,
    fylling_twh NUMERIC(10, 6) NOT NULL,
    neste_publiseringsdato TIMESTAMP,
    fyllingsgrad_forrige_uke NUMERIC(10, 6) NOT NULL,
    endring_fyllingsgrad NUMERIC(10, 6) NOT NULL,
    FOREIGN KEY (area_id) REFERENCES area (id),
    FOREIGN KEY (dato_id) REFERENCES dates (id)
);

CREATE TABLE magasinstatistikk_min_max_median_model (
    id BIGSERIAL PRIMARY KEY,
    area_id INTEGER NOT NULL,
    maaling_uke INTEGER NOT NULL,
    min_fyllingsgrad NUMERIC(10, 6) NOT NULL,
    min_fylling_twh NUMERIC(10, 6) NOT NULL,
    max_fyllingsgrad NUMERIC(10, 6) NOT NULL,
    max_fylling_twh NUMERIC(10, 6) NOT NULL,
    median_fyllingsgrad NUMERIC(10, 6) NOT NULL,
    median_fylling_twh NUMERIC(10, 6) NOT NULL,
    FOREIGN KEY (area_id) REFERENCES area (id)
);


CREATE INDEX idx_magasinstat_dato ON magasinstatistikk_model (dato_id);
CREATE INDEX idx_magasinstat_area ON magasinstatistikk_model (area_id);
CREATE INDEX idx_magasinstat_min_max_median_area_id ON magasinstatistikk_model (area_id);
