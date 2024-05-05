CREATE TABLE helyszin(
    hely_id INTEGER PRIMARY KEY,
    orszag VARCHAR2(50) NOT NULL,
    megye VARCHAR2(150) NOT NULL,
    varos VARCHAR2(150) NOT NULL,
    telepules VARCHAR2(150)
);

CREATE SEQUENCE hely_sequence;

CREATE TABLE felhasznalok(
    email VARCHAR2(50) PRIMARY KEY,
    teljes_nev VARCHAR2(100) NOT NULL,
    jelszo VARCHAR2(150) NOT NULL,
    felhasznalonev VARCHAR2(30) UNIQUE NOT NULL,
    hely_id NUMBER NOT NULL,
    is_admin NUMBER DEFAULT 0,
    FOREIGN KEY(hely_id) REFERENCES helyszin(hely_id)
);

CREATE TABLE kep(
    email VARCHAR2(50) NOT NULL,
    kep_id INTEGER PRIMARY KEY,
    cim VARCHAR2(100) NOT NULL,
    leiras VARCHAR(300),
    ertekeles NUMBER DEFAULT 2.500,
    feltoltes_ideje DATE DEFAULT CURRENT_DATE,
    hely_id INTEGER NOT NULL,
    fajl_eleres VARCHAR2(200) NOT NULL,
    FOREIGN KEY(email) REFERENCES felhasznalok(email)
    ON DELETE SET NULL,
    FOREIGN KEY(hely_id) REFERENCES helyszin(hely_id)
);

CREATE SEQUENCE kep_sequence;

CREATE TABLE album(
    album_id INTEGER PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    letrehozas_datum DATE DEFAULT CURRENT_DATE,
    cim VARCHAR2(100) NOT NULL,
    FOREIGN KEY(email) REFERENCES felhasznalok(email)
    ON DELETE SET NULL
);

CREATE SEQUENCE album_sequence;


CREATE TABLE kategoria(
    kategoria_id INTEGER PRIMARY KEY,
    megnevezes VARCHAR2(20) NOT NULL,
    leiras VARCHAR2(100) NOT NULL
); 

CREATE SEQUENCE kategoria_sequence;


CREATE TABLE hozzaszolas(
    hozzaszolas_id INTEGER PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    kep_id INTEGER NOT NULL,
    szoveg VARCHAR(500) NOT NULL,
    idopont TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(email) REFERENCES felhasznalok(email)
    ON DELETE CASCADE,
    FOREIGN KEY(kep_id) REFERENCES kep(kep_id)
    ON DELETE CASCADE
);

CREATE SEQUENCE hozzaszolas_sequence;


CREATE TABLE album_kep(
    album_id INTEGER NOT NULL,
    kep_id INTEGER NOT NULL,
    PRIMARY KEY(album_id, kep_id),
    FOREIGN KEY(album_id) REFERENCES album(album_id)
    ON DELETE CASCADE,
    FOREIGN KEY(kep_id) REFERENCES kep(kep_id)
    ON DELETE CASCADE
);

CREATE TABLE kategoria_kep(
    kategoria_id INTEGER NOT NULL,
    kep_id INTEGER NOT NULL,
    PRIMARY KEY(kategoria_id, kep_id),
    FOREIGN KEY(kategoria_id) REFERENCES kategoria(kategoria_id)
    ON DELETE CASCADE,
    FOREIGN KEY(kep_id) REFERENCES kep(kep_id)
    ON DELETE CASCADE
);
