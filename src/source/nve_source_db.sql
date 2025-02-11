-- Contains source data models (similar as in from extracted API data)

CREATE TABLE IF NOT EXISTS magasinstatistikk_model (
    id BIGSERIAL PRIMARY KEY,
    omr_type TEXT,
    omrnr INTEGER NOT NULL,
    dato_id BIGINT,
    fyllingsgrad DECIMAL NOT NULL,
    kapasitet_twh DECIMAL NOT NULL,
    fylling_twh DECIMAL NOT NULL,
    neste_publiseringstidspunkt TIMESTAMP NOT NULL,
    fyllingsgrad_forrige_uke DECIMAL NOT NULL,
    endring_fyllingsgrad DECIMAL NOT NULL,
    FOREIGN KEY (omr_type, omrnr) REFERENCES area (omr_type, omrnr),
    FOREIGN KEY (dato_id) REFERENCES dato_dimensjon (id)
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


CREATE TABLE magasinstatistikk_offentlig_min_max_median_model (
    id BIGSERIAL PRIMARY KEY,
    omr_type TEXT,
    omrnr INTEGER NOT NULL,
    iso_uke INTEGER NOT NULL,
    min_fyllingsgrad DECIMAL NOT NULL,
    min_fylling_twh DECIMAL NOT NULL,
    median_fyllingsgrad DECIMAL NOT NULL,
    max_fyllingsgrad DECIMAL NOT NULL,
    max_fylling_twh DECIMAL NOT NULL,
    FOREIGN KEY (omr_type, omrnr) REFERENCES area (omr_type, omrnr)
);


CREATE TABLE dato_dimensjon (
    id BIGSERIAL PRIMARY KEY,
    iso_dato DATE NOT NULL UNIQUE,
    iso_aar INTEGER NOT NULL,
    iso_uke INTEGER NOT NULL,
    iso_maaned INTEGER NOT NULL,
    iso_dag INTEGER NOT NULL
);


CREATE INDEX idx_magasinstat_dato ON magasinstatistikk_model (dato_id);
CREATE INDEX idx_magasinstat_omr ON magasinstatistikk_model (omr_type, omrnr);
