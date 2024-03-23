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
/
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
/
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
/

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
/

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
/

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

--Hely insertek

Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('46','Magyarország','Bács-Kiskun','Solt',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('47','Magyarország','Komárom-Esztergom','Esztergom',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('48','Magyarország','Komárom-Esztergom','Komárom',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('49','Magyarország','Komárom-Esztergom','Tatabánya',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('50','Magyarország','Komárom-Esztergom','Tata',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('51','Magyarország','Jász-Nagykun-Szolnok','Szolnok',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('52','Magyarország','Bács-Kiskun','Tiszakécske',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('53','Magyarország','Bács-Kiskun','Kiskunmajsa',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('54','Magyarország','Bács-Kiskun','Soltvadkert',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('55','Magyarország','Bács-Kiskun','Csengõd',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('31','Magyarország','Borsod-Abaúj-Zemplén','Ózd',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('32','Magyarország','Csongrád','Szeged',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('33','Magyarország','Szabolcs-Szatmár-Bereg','Nyíregyháza',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('34','Magyarország','Borsod-Abaúj-Zemplén','Miskolc',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('35','Magyarország','Borsod-Abaúj-Zemplén','Edelény',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('36','Magyarország','Fejér','Székesfehérvár',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('37','Magyarország','Bács-Kiskun','Kecskemét',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('38','Magyarország','Fejér','Dunaújváros',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('39','Magyarország','Fejér','Cece',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('40','Magyarország','Zala','Nagykanizsa',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('41','Magyarország','Bács-Kiskun','Kiskunhalas',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('42','Magyarország','Bács-Kiskun','Kiskunfélegyháza',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('43','Magyarország','Bács-Kiskun','Baja',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('44','Magyarország','Bács-Kiskun','Kalocsa',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('45','Magyarország','Vas','Szombathely',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('56','Magyarország','Bács-Kiskun','Tabdi',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('57','Magyarország','Bács-Kiskun','Kecel',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('58','Magyarország','Bács-Kiskun','Jánoshalma',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('59','Magyarország','Bács-Kiskun','Kunszentmiklós',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('60','Magyarország','Pest','Budapest',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('61','Magyarország','Pest','Cegléd',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('62','Magyarország','Pest','Kiskunlacháza',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('63','Magyarország','Pest','Ráckeve',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('64','Magyarország','Pest','Nagykõrös',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('65','Magyarország','Pest','Dunavarsány',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('67','Magyarország','Vas','Szombathely',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('68','Magyarország','Bács-Kiskun','Solt',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('69','Magyarország','Komárom-Esztergom','Esztergom',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('70','Magyarország','Komárom-Esztergom','Komárom',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('71','Magyarország','Komárom-Esztergom','Tatabánya',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('72','Magyarország','Komárom-Esztergom','Tata',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('73','Magyarország','Jász-Nagykun-Szolnok','Szolnok',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('74','Magyarország','Bács-Kiskun','Tiszakécske',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('75','Magyarország','Bács-Kiskun','Kiskunmajsa',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('76','Magyarország','Bács-Kiskun','Soltvadkert',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('77','Magyarország','Bács-Kiskun','Csengõd',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('78','Magyarország','Bács-Kiskun','Tabdi',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('79','Magyarország','Bács-Kiskun','Kecel',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('80','Magyarország','Bács-Kiskun','Jánoshalma',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('81','Magyarország','Bács-Kiskun','Kunszentmiklós',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('82','Magyarország','Pest','Budapest',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('83','Magyarország','Pest','Cegléd',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('84','Magyarország','Pest','Kiskunlacháza',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('85','Magyarország','Pest','Ráckeve',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('86','Magyarország','Pest','Nagykõrös',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('87','Magyarország','Pest','Dunavarsány',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('1','Magyarország','Csongrád-Csanád','Szeged',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('3','Magyarország','Csongrád-Csanád','Csongrád',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('6','Magyarország','Bács-Kiskun megye','Kecskemét',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('7','Magyarország','Bács-Kiskun','Akasztó',null);
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('8','Magyarország','Csongrád-Csanád','Szeged','Dorozsma');
Insert into HELYSZIN (HELY_ID,ORSZAG,MEGYE,VAROS,TELEPULES) values ('5','Magyarország','Bács-Kiskun','Kecskemét',null);

--Felhasználó insertek

Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('wmillier0@imageshack.us','Wolfy Millier','$2a$04$cC7ICItYYte994/Niy3.NejtCOGm/j90W0CTjNRWetLkeNJ4fnTr.','wmillier0','41');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('harrington1@technorati.com','Huberto Arrington','$2a$04$tYpy0xKcENdR0QvKRn4rx.37WdPsG.9H/NL.3GzY22psykl7SLN2.','harrington1','40');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('hdhennin2@earthlink.net','Husain Dhennin','$2a$04$uwEPXEzvxvrzTZ8rT4V41.3X9X3R2q4qhLfHJNyJ9v4Su8J558ONa','hdhennin2','31');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('cle3@oaic.gov.au','Cull Le Sieur','$2a$04$fFPRMSOD9H0edZWf9H5Nfu9TsDwnKEoT0/qjoBo82E.iZEmRiRav.','cle3','38');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('spinnegar4@twitter.com','Sonnie Pinnegar','$2a$04$dTcKgXnOT479f1qm3KmlEOgIyGno/ve8KC9ILLRSw17VonYPCk4dy','spinnegar4','44');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('csnellman5@rambler.ru','Cleo Snellman','$2a$04$HEDDbepiHu6keWbDXsTOa.q8Xau4sNIoKdcreJ9uNIUN/pPtX9eiu','csnellman5','41');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('jmccaskill6@free.fr','Jacklyn McCaskill','$2a$04$fOjY1BGPATbTR4fWubx49ee1Uv0Q0LvIqFi2/fRCPmgwaUV7/40SW','jmccaskill6','42');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('kbrunton7@vk.com','Kassia Brunton','$2a$04$Q41vdzoy7xR0Dv1gKZFOk.Xxi62ep7okHsfUv6MXXlXzizquwRTLC','kbrunton7','37');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('ewilliam8@topsy.com','Erin William','$2a$04$.mmzk9P13/CSWi/1gcTJqOXSpUH6eV3owzZlpb5yELbxYDhe3gEQS','ewilliam8','40');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('ebails9@yale.edu','Elijah Bails','$2a$04$aVKwPtA7Ox4MIo2hxjp//.Rc6IqV1bZjohK7ra0IejiksJ1XkpNi6','ebails9','38');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('singera@tmall.com','Scot Inger','$2a$04$BzZCkAko0wSR8NQXQFDeTOKtCoDx5i2Kl3Ctpkvck/u.vcNO8to0S','singera','31');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('cchessunb@privacy.gov.au','Clary Chessun','$2a$04$A6nQ8eD8Vn2J8mBJ0iTaeO9FsBe6SlUqZV8FaCgZzhAT.bsuJRDIG','cchessunb','40');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('gcanbyc@stumbleupon.com','Grove Canby','$2a$04$uy4jPvkf9J53bT/Q8NDmcOIV4qcG0xvcGdg8iZP8bcSzAPlKTk.X.','gcanbyc','37');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('cmcneishd@google.ru','Consuela McNeish','$2a$04$WFrtFAGl.FboHFJOFYK.muImDNsQ9iNe2.bnTxBVbfjqsrNAHZhjK','cmcneishd','42');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('jlanstone@auda.org.au','Joelly Lanston','$2a$04$DB9W7.hh/hV8ySndu6v/u.LvdDj35UH.d7Z/2nPa/XvmV49xmdhAG','jlanstone','36');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('elettleyf@cocolog-nifty.com','Ernie Lettley','$2a$04$hOTLM9py0q9bpOMpXZ2uRefKHQ4nhAksKMx0hhFYuTHh7Q.1kA9UC','elettleyf','32');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('seaddyg@merriam-webster.com','Sandro Eaddy','$2a$04$YMTNPVYdlwKgYeyHOptUuuwxpIlnnDtEtAK9qKQT/LyfsE26KrBsi','seaddyg','33');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('aburburyh@marketwatch.com','Anneliese Burbury','$2a$04$0gPz2FLPySBoMeXmHuerF.V5AfgSRkqQ48FadxKEn9pW0g8hi5nUq','aburburyh','36');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('klinsteadi@homestead.com','Kingsley Linstead','$2a$04$foBaERL3ZCl.r2337io6AuGb5HmiZOHw6Y8XQy0jHcuWtq3WlaiUG','klinsteadi','33');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('lhealksj@friendfeed.com','Linell Healks','$2a$04$ohCPWEVh2Mv3fCtHfNFNa.sjvhg0JRQyImXx9WI5zGsYdqF3P865K','lhealksj','40');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('reliask@icq.com','Raychel Elias','$2a$04$40RqoUN7z2NOMd3lYrV.iOxvGOktXMVWFycwCnzMfr7GrvRQ0XpBm','reliask','35');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('bslotl@dagondesign.com','Babbette Slot','$2a$04$efxYAiaJ2/UIDmLinzrwXe86PkGcuJ/.14BEoi45L6O7KR6Ew8qHq','bslotl','44');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('abeterissm@behance.net','Anderson Beteriss','$2a$04$U7rxBsU2mY9hPAjEKKe2PeEAWDiifnCCFiccFVOoMERJSPM.q9X/q','abeterissm','36');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('estetlyen@techcrunch.com','Eadith Stetlye','$2a$04$wlER5u04xd9LmwsZU.ZrQeJqi3kqTwbgeFeyFVEgw57FUddz4/Fp2','estetlyen','33');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('ltoulmino@4shared.com','Leoine Toulmin','$2a$04$wGI8wlQ5/aEqlbQKkM2T7.a3CUVJMlo0KVwUO3sy7sXtbYSNsy47m','ltoulmino','32');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('eclacep@engadget.com','Emmalee Clace','$2a$04$Beu8E0.J5s.IlenWdYpL3Ov8uxRm7EXXgueYviDFd.j9f0gt7jnUm','eclacep','32');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('jlayfieldq@ifeng.com','Johnathon Layfield','$2a$04$bsD5vhC4vzUyuAgwJj/42uRi9ZnTdizghJo9JW2MfCxUlHNvHA39C','jlayfieldq','33');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('hkimbleyr@indiegogo.com','Hope Kimbley','$2a$04$6u2nQh3r/Vy1cCl0ybzXAOlWzvDmJilcf/qeEec/FjVJnvyL..j7m','hkimbleyr','32');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('lmillsaps@latimes.com','Leonerd Millsap','$2a$04$TgqkOXL/MuhyGYL3QbY3ee7y.hw83vuAjyC.3JYB2yFouuuhJk.F2','lmillsaps','42');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('dedelheidt@zimbio.com','Darleen Edelheid','$2a$04$YOofTI2HImg8FIC0tS5VOu6wujgozpFobP/fSqsIbCm42I1aMZPoS','dedelheidt','38');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('@','Nagy','111','nagy','1');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('lacika@gmail.com','Laci','asd','Lacika','1');
Insert into FELHASZNALOK (EMAIL,TELJES_NEV,JELSZO,FELHASZNALONEV,HELY_ID) values ('asd@c.c','ASD','321','aSd','1');

--Kép insertek

Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hdhennin2@earthlink.net','174','turpis','Suspendisse ornare consequat lectus.','3,9',to_date('2023-07-18','YYYY-MM-DD'),'76','DuisAliquam.jpg');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hdhennin2@earthlink.net','175','pede','Nulla justo.','2,2',to_date('2023-05-21','YYYY-MM-DD'),'76','Sed.pdf');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hdhennin2@earthlink.net','176','cras','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.','2,9',to_date('2023-11-30','YYYY-MM-DD'),'76','EgetTempusVel.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('ebails9@yale.edu','177','pede','In hac habitasse platea dictumst.','2,8',to_date('2023-10-30','YYYY-MM-DD'),'6','SapienDignissim.png');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('reliask@icq.com','178','mauris','Suspendisse ornare consequat lectus.','2,9',to_date('2024-02-02','YYYY-MM-DD'),'34','InCongue.tiff');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('reliask@icq.com','179','praesent','Aliquam erat volutpat.','0,5',to_date('2023-07-25','YYYY-MM-DD'),'34','InEleifendQuam.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('reliask@icq.com','180','in','Integer a nibh.','2',to_date('2023-04-24','YYYY-MM-DD'),'34','Enim.mov');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('reliask@icq.com','181','elit','Integer tincidunt ante vel ipsum.','2,8',to_date('2024-02-10','YYYY-MM-DD'),'34','Dolor.tiff');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('reliask@icq.com','182','tristique','Integer ac leo.','0,2',to_date('2024-01-31','YYYY-MM-DD'),'34','InTempusSit.tiff');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('wmillier0@imageshack.us','183','justo','Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.','0,1',to_date('2023-12-29','YYYY-MM-DD'),'31','In.pdf');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('wmillier0@imageshack.us','184','vestibulum','Duis mattis egestas metus.','1,3',to_date('2024-02-27','YYYY-MM-DD'),'34','Nunc.png');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hkimbleyr@indiegogo.com','185','sit','Praesent blandit lacinia erat.','1,6',to_date('2023-05-28','YYYY-MM-DD'),'1','EtiamVelAugue.tiff');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hkimbleyr@indiegogo.com','186','ut','Donec ut dolor.','3,4',to_date('2023-07-06','YYYY-MM-DD'),'1','Dui.pdf');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','187','quam','Mauris ullamcorper purus sit amet nulla.','0,4',to_date('2023-08-04','YYYY-MM-DD'),'32','Molestie.gif');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','188','integer','Cras non velit nec nisi vulputate nonummy.','0,1',to_date('2024-01-01','YYYY-MM-DD'),'32','ConvallisNuncProin.ppt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','189','cras','Duis bibendum.','3,8',to_date('2024-01-11','YYYY-MM-DD'),'32','VivamusVel.doc');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','190','sollicitudin','Vivamus tortor.','4,9',to_date('2023-04-30','YYYY-MM-DD'),'32','Malesuada.mov');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','191','aenean','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.','0,1',to_date('2024-02-04','YYYY-MM-DD'),'32','ParturientMontes.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','192','amet','Nullam sit amet turpis elementum ligula vehicula consequat.','1,5',to_date('2023-11-28','YYYY-MM-DD'),'32','AmetSapienDignissim.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','193','sit','Proin leo odio, porttitor id, consequat in, consequat ut, nulla.','2,9',to_date('2024-03-20','YYYY-MM-DD'),'32','OrciLuctus.pdf');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','194','vestibulum','Curabitur convallis.','3',to_date('2023-07-22','YYYY-MM-DD'),'32','Dictumst.jpeg');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','195','quam','Vivamus in felis eu sapien cursus vestibulum.','2,8',to_date('2023-06-04','YYYY-MM-DD'),'32','TristiqueTortor.xls');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','196','sapien','Proin interdum mauris non ligula pellentesque ultrices.','2,6',to_date('2023-06-08','YYYY-MM-DD'),'32','PosuereCubilia.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hdhennin2@earthlink.net','197','lacinia','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.','3,8',to_date('2023-04-22','YYYY-MM-DD'),'74','DictumstMorbi.jpeg');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hdhennin2@earthlink.net','198','pellentesque','Praesent blandit.','1,5',to_date('2024-02-29','YYYY-MM-DD'),'74','AliquamNonMauris.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hkimbleyr@indiegogo.com','199','odio','Suspendisse ornare consequat lectus.','1,2',to_date('2024-03-14','YYYY-MM-DD'),'37','Felis.pdf');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hkimbleyr@indiegogo.com','200','cubilia','Morbi quis tortor id nulla ultrices aliquet.','3,3',to_date('2023-08-10','YYYY-MM-DD'),'37','InterdumEu.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('hkimbleyr@indiegogo.com','201','dictumst','Aenean sit amet justo.','1,8',to_date('2023-04-28','YYYY-MM-DD'),'37','AuctorGravidaSem.jpeg');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('bslotl@dagondesign.com','202','vulputate','Sed ante.','1,2',to_date('2024-01-12','YYYY-MM-DD'),'39','UtMauris.txt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('bslotl@dagondesign.com','203','nunc','Donec vitae nisi.','2,4',to_date('2023-06-24','YYYY-MM-DD'),'39','UltricesErat.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','204','est','Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.','3,9',to_date('2023-07-01','YYYY-MM-DD'),'49','DolorVelEst.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','205','justo','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.','1,7',to_date('2024-03-05','YYYY-MM-DD'),'49','QuisJustoMaecenas.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','206','magnis','Nulla facilisi.','4,6',to_date('2023-06-18','YYYY-MM-DD'),'49','IaculisCongueVivamus.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','207','quisque','Morbi non quam nec dui luctus rutrum.','4,5',to_date('2023-06-03','YYYY-MM-DD'),'49','Quisque.ppt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','208','mauris','Curabitur in libero ut massa volutpat convallis.','1,9',to_date('2023-08-27','YYYY-MM-DD'),'49','Nonummy.txt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','209','pede','Integer non velit.','3,2',to_date('2023-06-17','YYYY-MM-DD'),'49','Leo.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('gcanbyc@stumbleupon.com','210','mauris','Nunc nisl.','4,3',to_date('2023-04-15','YYYY-MM-DD'),'49','InterdumMaurisNon.xls');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('ltoulmino@4shared.com','211','in','Vivamus vel nulla eget eros elementum pellentesque.','3,4',to_date('2023-08-10','YYYY-MM-DD'),'82','Quisque.xls');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('ltoulmino@4shared.com','212','velit','Etiam vel augue.','3,5',to_date('2023-09-04','YYYY-MM-DD'),'82','NuncPurusPhasellus.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('ltoulmino@4shared.com','213','sollicitudin','In blandit ultrices enim.','1,5',to_date('2024-02-06','YYYY-MM-DD'),'82','ElementumLigulaVehicula.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('elettleyf@cocolog-nifty.com','214','lobortis','Proin eu mi.','1,3',to_date('2024-03-03','YYYY-MM-DD'),'1','UtDolorMorbi.avi');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('klinsteadi@homestead.com','215','donec','Nulla suscipit ligula in lacus.','0,7',to_date('2024-01-08','YYYY-MM-DD'),'62','Libero.txt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('klinsteadi@homestead.com','216','vel','Fusce consequat.','4,4',to_date('2023-12-10','YYYY-MM-DD'),'62','Nunc.jpeg');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('klinsteadi@homestead.com','217','non','In eleifend quam a odio.','1',to_date('2023-12-08','YYYY-MM-DD'),'62','PosuereMetusVitae.mp3');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('klinsteadi@homestead.com','218','vestibulum','Sed vel enim sit amet nunc viverra dapibus.','4,8',to_date('2024-02-16','YYYY-MM-DD'),'62','Venenatis.mov');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('cmcneishd@google.ru','219','donec','Suspendisse accumsan tortor quis turpis.','0,2',to_date('2023-12-06','YYYY-MM-DD'),'67','Enim.ppt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('cmcneishd@google.ru','220','et','Suspendisse potenti.','4,5',to_date('2023-05-07','YYYY-MM-DD'),'67','NullaTellus.ppt');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('singera@tmall.com','221','parturient','Suspendisse potenti.','3,4',to_date('2024-01-23','YYYY-MM-DD'),'1','Vestibulum.png');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('singera@tmall.com','222','elementum','Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.','2,7',to_date('2023-08-23','YYYY-MM-DD'),'1','Suspendisse.jpeg');
Insert into KEP (EMAIL,KEP_ID,CIM,LEIRAS,ERTEKELES,FELTOLTES_IDEJE,HELY_ID,FAJL_ELERES) values ('singera@tmall.com','223','vestibulum','Aliquam erat volutpat.','2,3',to_date('2023-07-20','YYYY-MM-DD'),'1','LectusVestibulum.mp3');

--Kategória insertek

Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('1','Természetfotó','Képek a természeti környezetrõl');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('2','Városi tájkép','A városi környezetek fotói');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('3','Tengerparti tájkép','Fotók a tengerparti vagy folyóparti környezetrõl');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('4','Hegyi tájkép','Képek a hegyvidéki területekrõl');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('5','Mezõs tájkép','Fotók a mezõkrõl');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('6','Erdei tájkép','Képek az erdõkrõl');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('7','Égboltfotó','Fotók az égi jelenségekrõl');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('8','Évszakfotó','Képek az évszakok jellegzetességeirõl.');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('9','Portré','Emberi arcokat és kifejezéseket rögzít');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('10','Utcai fotó','Városi élet és emberek dinamikus pillanatainak megörökítése az utcán.');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('11','gasztronómia','Kreatív módon bemutatja az ételek és italok ízét és szépségét.');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('12','Makrófotó','Kis tárgyak vagy részletek nagyított');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('13','Mûvészi fotó','Kreatív játék a fényekkel');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('14','Sportfotó','Sportesemények vagy sportolók akcióban rögzítve');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('15','Mûvészeti fotó','Kifejezõ és érzelmileg töltött képek');
Insert into KATEGORIA (KATEGORIA_ID,MEGNEVEZES,LEIRAS) values ('16','Életmód','Az emberek mindennapi életének és tevékenységeinek megörökítése');

--Hozzászólás insertek

insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (1, 'cchessunb@privacy.gov.au', 201, 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '2023-04-28 09:26:48');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (2, 'hdhennin2@earthlink.net', 201, 'Quisque id justo sit amet sapien dignissim vestibulum.', '2023-04-28 15:32:03');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (3, 'cchessunb@privacy.gov.au', 190, 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '2023-05-02 13:20:16');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (4, 'hdhennin2@earthlink.net', 190, 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '2023-08-15 07:45:38');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (5, 'cchessunb@privacy.gov.au', 204, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '2023-07-03 21:34:03');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (6, 'dedelheidt@zimbio.com', 204, 'Morbi non lectus.', '2023-07-04 10:13:47');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (7, 'abeterissm@behance.net', 204, 'Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '2023-09-26 16:42:14');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (8, 'klinsteadi@homestead.com', 204, 'In quis justo.', '2023-09-26 18:34:21');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (9, 'harrington1@technorati.com', 204, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '2024-01-03 11:17:48');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (10, 'kbrunton7@vk.com', 176, 'Praesent lectus.', '2023-12-15 14:26:42');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (11, 'ewilliam8@topsy.com', 176, 'Ut tellus. Nulla ut erat id mauris vulputate elementum.', '2024-02-13 10:08:35');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (12, 'dedelheidt@zimbio.com', 176, 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '2024-02-26 17:12:01');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (13, 'ewilliam8@topsy.com', 213, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '2024-02-08 11:25:31');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (14, 'harrington1@technorati.com', 213, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '2024-02-16 20:34:10');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (15, 'ewilliam8@topsy.com', 213, 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '2024-02-21 09:12:35');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (16, 'dedelheidt@zimbio.com', 213, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', '2024-03-02 22:43:17');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (17, 'kbrunton7@vk.com', 213, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '2024-03-15 08:21:06');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (18, 'kbrunton7@vk.com', 205, 'Nullam porttitor lacus at turpis.', '2024-03-05 13:47:05');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (19, 'lmillsaps@latimes.com', 205, 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', '2024-03-08 10:24:53');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (20, 'klinsteadi@homestead.com', 205, 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '2024-03-05 15:57:26');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (21, 'lmillsaps@latimes.com', 193, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2024-03-20 06:47:28');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (22, 'abeterissm@behance.net', 193, 'Nulla nisl. Nunc nisl.', '2024-03-20 13:16:14');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (23, 'reliask@icq.com', 193, 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2024-03-21 15:36:24');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (24, 'gcanbyc@stumbleupon.com', 193, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2024-03-21 19:27:11');
insert into hozzaszolas (hozzaszolas_id, email, kep_id, szoveg, idopont) values (25, 'kbrunton7@vk.com', 193, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', '2024-03-22 12:03:51');

--Album insertek

Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('1','csnellman5@rambler.ru',to_date('24-MÁRC. -22','RR-MON-DD'),'nisi volutpat');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('2','aburburyh@marketwatch.com',to_date('24-MÁRC. -22','RR-MON-DD'),'tortor');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('3','klinsteadi@homestead.com',to_date('24-MÁRC. -22','RR-MON-DD'),'congue elementum');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('4','ebails9@yale.edu',to_date('24-MÁRC. -22','RR-MON-DD'),'a pede');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('5','klinsteadi@homestead.com',to_date('24-MÁRC. -22','RR-MON-DD'),'pede ac');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('6','cmcneishd@google.ru',to_date('24-MÁRC. -22','RR-MON-DD'),'ipsum dolor');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('7','jlanstone@auda.org.au',to_date('24-MÁRC. -22','RR-MON-DD'),'et ultrices');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('8','cmcneishd@google.ru',to_date('24-MÁRC. -22','RR-MON-DD'),'potenti nullam');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('9','harrington1@technorati.com',to_date('24-MÁRC. -22','RR-MON-DD'),'donec');
Insert into ALBUM (ALBUM_ID,EMAIL,LETREHOZAS_DATUM,CIM) values ('10','elettleyf@cocolog-nifty.com',to_date('24-MÁRC. -22','RR-MON-DD'),'ut blandit');

--Kategória-Kép insertek

Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('1','177');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('1','209');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('1','210');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('3','200');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('3','220');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('4','175');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('4','181');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('4','210');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('4','214');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('5','177');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('6','212');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('7','207');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('9','177');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('9','215');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('9','217');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('10','178');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('10','188');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('10','200');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('11','189');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('12','205');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('12','213');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('13','190');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('13','192');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('13','213');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('14','216');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('15','175');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('15','183');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('15','198');
Insert into KATEGORIA_KEP (KATEGORIA_ID,KEP_ID) values ('16','175');

--Album-kép insertek

Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('1','174');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('1','175');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('1','176');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('2','180');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('2','181');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('2','182');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('2','183');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('3','191');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('3','192');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('4','202');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('4','203');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('4','204');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('4','205');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('4','206');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('5','214');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('5','215');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('5','216');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('6','211');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('6','213');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('7','177');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('7','183');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('7','189');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('7','192');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('8','199');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('8','202');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('9','175');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('9','218');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('9','222');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('10','178');
Insert into ALBUM_KEP (ALBUM_ID,KEP_ID) values ('10','193');