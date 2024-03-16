CREATE TABLE helyszin(
    hely_id INTEGER PRIMARY KEY,
    orszag VARCHAR2(50) NOT NULL,
    megye VARCHAR2(150) NOT NULL,
    varos VARCHAR2(150) NOT NULL,
    telepules VARCHAR2(150)
);

CREATE SEQUENCE hely_sequence;

CREATE OR REPLACE TRIGGER helyszin_on_insert
  BEFORE INSERT ON helyszin
  FOR EACH ROW
BEGIN
  SELECT hely_sequence.nextval
  INTO :new.hely_id
  FROM dual;
END;

CREATE TABLE felhasznalok(
    email VARCHAR2(50) PRIMARY KEY,
    teljes_nev VARCHAR2(100) NOT NULL,
    jelszo VARCHAR2(150) NOT NULL,
    felhasznalonev VARCHAR2(30) UNIQUE NOT NULL,
    hely_id NUMBER NOT NULL,
    FOREIGN KEY(hely_id) REFERENCES helyszin(hely_id)
);

CREATE TABLE kep(
    email VARCHAR2(50) NOT NULL,
    kep_id INTEGER PRIMARY KEY,
    cim VARCHAR2(100) NOT NULL,
    leiras LONG,
    ertekeles NUMBER DEFAULT 2.500,
    feltoltes_ideje DATE DEFAULT CURRENT_DATE,
    hely_id INTEGER NOT NULL,
    fajl_eleres VARCHAR2(200) NOT NULL,
    FOREIGN KEY(email) REFERENCES felhasznalok(email)
    ON DELETE SET NULL,
    FOREIGN KEY(hely_id) REFERENCES helyszin(hely_id)
);

CREATE SEQUENCE kep_sequence;

CREATE OR REPLACE TRIGGER kep_on_insert
  BEFORE INSERT ON kep
  FOR EACH ROW
BEGIN
  SELECT kep_sequence.nextval
  INTO :new.kep_id
  FROM dual;
END;

CREATE TABLE album(
    album_id INTEGER PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    letrehozas_datum DATE DEFAULT CURRENT_DATE,
    cim VARCHAR2(100) NOT NULL,
    FOREIGN KEY(email) REFERENCES felhasznalok(email)
    ON DELETE SET NULL
);

CREATE SEQUENCE album_sequence;

CREATE OR REPLACE TRIGGER album_on_insert
  BEFORE INSERT ON album
  FOR EACH ROW
BEGIN
  SELECT album_sequence.nextval
  INTO :new.album_id
  FROM dual;
END;

CREATE TABLE kategoria(
    kategoria_id INTEGER PRIMARY KEY,
    megnevezes VARCHAR2(20) NOT NULL,
    leiras VARCHAR2(100) NOT NULL
); 

CREATE SEQUENCE kategoria_sequence;

CREATE OR REPLACE TRIGGER kategoria_on_insert
  BEFORE INSERT ON kategoria
  FOR EACH ROW
BEGIN
  SELECT kategoria_sequence.nextval
  INTO :new.kategoria_id
  FROM dual;
END;

CREATE TABLE hozzaszolas(
    hozzaszolas_id INTEGER PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    kep_id INTEGER NOT NULL,
    szoveg LONG NOT NULL,
    idopont TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(email) REFERENCES felhasznalok(email)
    ON DELETE CASCADE,
    FOREIGN KEY(kep_id) REFERENCES kep(kep_id)
    ON DELETE CASCADE
);

CREATE SEQUENCE hozzaszolas_sequence;

CREATE OR REPLACE TRIGGER hozzaszolas_on_insert
  BEFORE INSERT ON hozzaszolas
  FOR EACH ROW
BEGIN
  SELECT hozzaszolas_sequence.nextval
  INTO :new.hozzaszolas_id
  FROM dual;
END;

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


INSERT INTO helyszin(orszag, megye, varos) VALUES('Magyarország', 'Csongrád-Csanád', 'Szeged');
INSERT INTO felhasznalok(email, teljes_nev, jelszo, felhasznalonev, hely_id) VALUES('@', 'Nagy', '111', 'nagy', 1);
INSERT INTO kep(email, cim, leiras, hely_id, fajl_eleres) VALUES('@', 'a', 'aaaaaaa', 1, 'cica.jpg');
INSERT INTO hozzaszolas(email, kep_id, szoveg) VALUES('@', 1, 'ez egy komment');
UPDATE helyszin SET varos = 'Szeged' WHERE hely_id = 1;

SELECT helyszin.varos FROM felhasznalok INNER JOIN helyszin ON felhasznalok.hely_id = helyszin.hely_id;

SELECT * FROM felhasznalok;

DROP TABLE helyszin;
DROP TABLE felhasznalok;
DROP TABLE kep;
DROP SEQUENCE hely_sequence;
DROP SEQUENCE kep_sequence;
DROP TRIGGER helyszin_on_insert;

DEFINE fel = 'C##A0B5QP';
DEFINE crud = 'ALL';

GRANT &crud ON felhasznalok TO &fel;
GRANT &crud ON hozzaszolas TO &fel;
GRANT &crud ON kep TO &fel;
GRANT &crud ON helyszin TO &fel;
GRANT &crud ON album TO &fel;
GRANT &crud ON kategoria TO &fel;
GRANT &crud ON album_kep TO &fel;
GRANT &crud ON kategoria_kep TO &fel;