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

Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Solt',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Esztergom',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Komárom',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Tatabánya',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Tata',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Jász-Nagykun-Szolnok','Szolnok',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Tiszakécske',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kiskunmajsa',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Soltvadkert',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Csengõd',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Borsod-Abaúj-Zemplén','Ózd',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Csongrád','Szeged',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Szabolcs-Szatmár-Bereg','Nyíregyháza',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Borsod-Abaúj-Zemplén','Miskolc',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Borsod-Abaúj-Zemplén','Edelény',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Fejér','Székesfehérvár',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kecskemét',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Fejér','Dunaújváros',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Fejér','Cece',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Zala','Nagykanizsa',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kiskunhalas',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kiskunfélegyháza',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Baja',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kalocsa',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Vas','Szombathely',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Tabdi',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kecel',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Jánoshalma',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kunszentmiklós',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Budapest',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Cegléd',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Kiskunlacháza',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Ráckeve',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Nagykõrös',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Dunavarsány',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Vas','Szombathely',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Solt',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Esztergom',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Komárom',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Tatabánya',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Komárom-Esztergom','Tata',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Jász-Nagykun-Szolnok','Szolnok',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Tiszakécske',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kiskunmajsa',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Soltvadkert',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Csengõd',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Tabdi',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kecel',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Jánoshalma',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kunszentmiklós',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Budapest',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Cegléd',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Kiskunlacháza',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Ráckeve',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Nagykõrös',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Pest','Dunavarsány',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Csongrád-Csanád','Szeged',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Csongrád-Csanád','Csongrád',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun megye','Kecskemét',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Akasztó',null);
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Csongrád-Csanád','Szeged','Dorozsma');
Insert into HELYSZIN (ORSZAG,MEGYE,VAROS,TELEPULES) values ('Magyarország','Bács-Kiskun','Kecskemét',null);

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

insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('cmcneishd@google.ru', 'pede justo lacinia', 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.', 3.958, 46, 'Consequat.mp3');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('elettleyf@cocolog-nifty.com', 'sapien in sapien iaculis', 'In hac habitasse platea dictumst.', 3.844, 18, 'Ridiculus.jpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'vel accumsan', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 1.455, 2, 'IaculisJustoIn.jpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('aburburyh@marketwatch.com', 'posuere metus vitae', 'Phasellus in felis. Donec semper sapien a libero.', 0.258, 54, 'EgetTempusVel.ppt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('csnellman5@rambler.ru', 'orci pede venenatis non', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 2.366, 5, 'Convallis.jpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('wmillier0@imageshack.us', 'primis in', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 0.531, 44, 'AtDolorQuis.pdf');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('wmillier0@imageshack.us', 'mattis nibh ligula', 'Phasellus sit amet erat. Nulla tempus.', 2.888, 20, 'PraesentBlanditNam.doc');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('wmillier0@imageshack.us', 'nisi volutpat eleifend donec', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', 3.393, 45, 'OrciNullamMolestie.avi');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'faucibus orci luctus', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 0.937, 23, 'ConsectetuerEgetRutrum.mp3');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('csnellman5@rambler.ru', 'euismod scelerisque quam turpis', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 3.223, 41, 'EgetNunc.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'primis in faucibus', 'Morbi vel lectus in quam fringilla rhoncus.', 1.778, 22, 'MassaQuisAugue.avi');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'ac nulla sed', 'Duis aliquam convallis nunc.', 2.096, 26, 'Eu.pdf');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('wmillier0@imageshack.us', 'ut at dolor quis', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', 3.292, 7, 'IdNislVenenatis.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('gcanbyc@stumbleupon.com', 'donec vitae', 'Nulla mollis molestie lorem.', 0.062, 24, 'RisusDapibusAugue.txt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('csnellman5@rambler.ru', 'etiam justo etiam', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 3.837, 52, 'NecNisi.tiff');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('klinsteadi@homestead.com', 'eleifend luctus ultricies', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 4.286, 1, 'QuisAugueLuctus.png');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('aburburyh@marketwatch.com', 'mauris ullamcorper purus sit', 'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 4.034, 40, 'DignissimVestibulumVestibulum.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'pede morbi porttitor lorem', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 3.513, 30, 'RisusDapibus.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'in porttitor', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 0.485, 52, 'Condimentum.tiff');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jlanstone@auda.org.au', 'non quam nec', 'Suspendisse accumsan tortor quis turpis.', 0.97, 47, 'VolutpatQuamPede.tiff');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'rutrum neque aenean auctor', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', 2.361, 8, 'QuisquePorta.mpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('csnellman5@rambler.ru', 'pellentesque volutpat dui maecenas', 'Nulla tellus.', 4.955, 32, 'Ante.mpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('elettleyf@cocolog-nifty.com', 'aenean lectus pellentesque', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 1.141, 3, 'Id.mpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'amet justo', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', 2.481, 22, 'AmetSapienDignissim.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'suscipit ligula in lacus', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 2.831, 50, 'SapienVariusUt.gif');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'tortor sollicitudin', 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 0.34, 27, 'Rhoncus.mov');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'vel nulla eget', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 1.488, 19, 'VolutpatSapien.ppt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'turpis adipiscing lorem vitae', 'Curabitur at ipsum ac tellus semper interdum.', 0.182, 36, 'NullaNequeLibero.jpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('klinsteadi@homestead.com', 'lobortis convallis tortor', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 2.219, 45, 'Etiam.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('klinsteadi@homestead.com', 'lectus aliquam sit amet', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 3.075, 58, 'NecEuismodScelerisque.ppt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('cmcneishd@google.ru', 'non lectus aliquam sit', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.', 3.416, 17, 'Vestibulum.txt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'leo rhoncus sed vestibulum', 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 2.861, 38, 'Sit.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('gcanbyc@stumbleupon.com', 'consequat varius integer ac', 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 1.955, 57, 'Faucibus.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'nulla quisque arcu libero', 'Etiam faucibus cursus urna.', 3.957, 20, 'CuraeMauris.jpeg');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('gcanbyc@stumbleupon.com', 'etiam vel augue', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 4.104, 10, 'LeoOdioCondimentum.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('harrington1@technorati.com', 'libero nam dui', 'Curabitur at ipsum ac tellus semper interdum.', 1.873, 45, 'Aenean.txt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jlanstone@auda.org.au', 'porttitor id', 'Curabitur at ipsum ac tellus semper interdum.', 1.07, 45, 'IpsumPrimisIn.tiff');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('gcanbyc@stumbleupon.com', 'in hac habitasse platea', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 0.759, 56, 'RutrumAc.ppt');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('wmillier0@imageshack.us', 'nullam varius nulla', 'Fusce consequat. Nulla nisl. Nunc nisl.', 2.849, 4, 'IpsumPrimis.tiff');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('aburburyh@marketwatch.com', 'in magna bibendum imperdiet', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 3.675, 36, 'MagnaAcConsequat.mov');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('elettleyf@cocolog-nifty.com', 'scelerisque mauris sit', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 1.87, 11, 'Morbi.png');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('csnellman5@rambler.ru', 'dictumst morbi', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', 3.915, 21, 'NullaSedVel.xls');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('aburburyh@marketwatch.com', 'sed interdum venenatis turpis', 'In sagittis dui vel nisl.', 4.451, 37, 'QuisqueId.avi');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('cmcneishd@google.ru', 'convallis morbi', 'Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 3.951, 43, 'FaucibusOrciLuctus.mp3');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jmccaskill6@free.fr', 'at lorem integer', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', 0.503, 46, 'Purus.mov');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('cmcneishd@google.ru', 'eleifend luctus ultricies eu', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', 4.437, 58, 'ConsequatLectusIn.tiff');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('aburburyh@marketwatch.com', 'erat eros viverra', 'In congue. Etiam justo.', 3.595, 24, 'MolestieNibh.avi');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('jlanstone@auda.org.au', 'ut erat id', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', 2.551, 7, 'VitaeQuam.avi');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('ebails9@yale.edu', 'feugiat non', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 1.098, 44, 'Ut.mp3');
insert into kep (email, cim, leiras, ertekeles, hely_id, fajl_eleres) values ('klinsteadi@homestead.com', 'dictumst aliquam augue quam', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 2.079, 7, 'Non.tiff');


--Kategória insertek

insert into kategoria (megnevezes, leiras) values ('Liliaceae', 'non ligula pellentesque ultrices phasellus id sapien');
insert into kategoria (megnevezes, leiras) values ('Fabaceae', 'ante vivamus tortor duis mattis egestas metus');
insert into kategoria (megnevezes, leiras) values ('Onagraceae', 'pede venenatis non sodales sed');
insert into kategoria (megnevezes, leiras) values ('Campanulaceae', 'blandit nam nulla integer pede');
insert into kategoria (megnevezes, leiras) values ('Hymeneliaceae', 'vel nisl duis ac nibh fusce');
insert into kategoria (megnevezes, leiras) values ('Rosaceae', 'ante vivamus tortor duis mattis egestas');
insert into kategoria (megnevezes, leiras) values ('Salicaceae', 'mauris sit amet eros suspendisse accumsan');
insert into kategoria (megnevezes, leiras) values ('Asteraceae', 'eros vestibulum ac est lacinia nisi');
insert into kategoria (megnevezes, leiras) values ('Asteraceae', 'cursus id turpis integer aliquet');
insert into kategoria (megnevezes, leiras) values ('Juncaceae', 'nam dui proin leo odio porttitor');
insert into kategoria (megnevezes, leiras) values ('Asteraceae', 'adipiscing molestie hendrerit at vulputate');
insert into kategoria (megnevezes, leiras) values ('Asteraceae', 'cras mi pede malesuada in');
insert into kategoria (megnevezes, leiras) values ('Polemoniaceae', 'sit amet lobortis sapien sapien non');
insert into kategoria (megnevezes, leiras) values ('Rosaceae', 'volutpat convallis morbi odio odio elementum eu');
insert into kategoria (megnevezes, leiras) values ('Poaceae', 'nisl duis ac nibh fusce');


--Hozzászólás insertek

insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 44, 'In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into hozzaszolas (email, kep_id, szoveg) values ('cle3@oaic.gov.au', 8, 'Curabitur at ipsum ac tellus semper interdum.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 17, 'Donec ut mauris eget massa tempor convallis.');
insert into hozzaszolas (email, kep_id, szoveg) values ('wmillier0@imageshack.us', 40, 'Donec ut dolor.');
insert into hozzaszolas (email, kep_id, szoveg) values ('hdhennin2@earthlink.net', 39, 'Aliquam erat volutpat.');
insert into hozzaszolas (email, kep_id, szoveg) values ('spinnegar4@twitter.com', 32, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 9, 'Donec semper sapien a libero. Nam dui.');
insert into hozzaszolas (email, kep_id, szoveg) values ('spinnegar4@twitter.com', 11, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
insert into hozzaszolas (email, kep_id, szoveg) values ('csnellman5@rambler.ru', 3, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.');
insert into hozzaszolas (email, kep_id, szoveg) values ('csnellman5@rambler.ru', 14, 'Vestibulum ac est lacinia nisi venenatis tristique.');
insert into hozzaszolas (email, kep_id, szoveg) values ('hdhennin2@earthlink.net', 36, 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 32, 'Duis at velit eu est congue elementum.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 32, 'Donec ut mauris eget massa tempor convallis.');
insert into hozzaszolas (email, kep_id, szoveg) values ('cle3@oaic.gov.au', 27, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.');
insert into hozzaszolas (email, kep_id, szoveg) values ('spinnegar4@twitter.com', 32, 'Morbi quis tortor id nulla ultrices aliquet.');
insert into hozzaszolas (email, kep_id, szoveg) values ('cle3@oaic.gov.au', 4, 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.');
insert into hozzaszolas (email, kep_id, szoveg) values ('spinnegar4@twitter.com', 24, 'Vestibulum sed magna at nunc commodo placerat.');
insert into hozzaszolas (email, kep_id, szoveg) values ('wmillier0@imageshack.us', 1, 'Nulla ut erat id mauris vulputate elementum. Nullam varius.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 39, 'Donec posuere metus vitae ipsum.');
insert into hozzaszolas (email, kep_id, szoveg) values ('spinnegar4@twitter.com', 28, 'Ut at dolor quis odio consequat varius.');
insert into hozzaszolas (email, kep_id, szoveg) values ('spinnegar4@twitter.com', 25, 'Integer ac neque. Duis bibendum.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 10, 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into hozzaszolas (email, kep_id, szoveg) values ('cle3@oaic.gov.au', 4, 'Integer ac neque.');
insert into hozzaszolas (email, kep_id, szoveg) values ('harrington1@technorati.com', 16, 'Duis ac nibh.');
insert into hozzaszolas (email, kep_id, szoveg) values ('hdhennin2@earthlink.net', 12, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien');

--Album insertek

Insert into ALBUM (EMAIL,CIM) values ('csnellman5@rambler.ru','nisi volutpat');
Insert into ALBUM (EMAIL,CIM) values ('aburburyh@marketwatch.com','tortor');
Insert into ALBUM (EMAIL,CIM) values ('klinsteadi@homestead.com','congue elementum');
Insert into ALBUM (EMAIL,CIM) values ('ebails9@yale.edu','a pede');
Insert into ALBUM (EMAIL,CIM) values ('klinsteadi@homestead.com','pede ac');
Insert into ALBUM (EMAIL,CIM) values ('cmcneishd@google.ru','ipsum dolor');
Insert into ALBUM (EMAIL,CIM) values ('jlanstone@auda.org.au','et ultrices');
Insert into ALBUM (EMAIL,CIM) values ('cmcneishd@google.ru','potenti nullam');
Insert into ALBUM (EMAIL,CIM) values ('harrington1@technorati.com','donec');
Insert into ALBUM (EMAIL,CIM) values ('elettleyf@cocolog-nifty.com','ut blandit');

--Kategória-Kép insertek

insert into kategoria_kep (kategoria_id, kep_id) values (8, 20);
insert into kategoria_kep (kategoria_id, kep_id) values (8, 34);
insert into kategoria_kep (kategoria_id, kep_id) values (12, 23);
insert into kategoria_kep (kategoria_id, kep_id) values (6, 47);
insert into kategoria_kep (kategoria_id, kep_id) values (15, 10);
insert into kategoria_kep (kategoria_id, kep_id) values (2, 47);
insert into kategoria_kep (kategoria_id, kep_id) values (13, 48);
insert into kategoria_kep (kategoria_id, kep_id) values (9, 26);
insert into kategoria_kep (kategoria_id, kep_id) values (15, 7);
insert into kategoria_kep (kategoria_id, kep_id) values (4, 20);
insert into kategoria_kep (kategoria_id, kep_id) values (9, 3);
insert into kategoria_kep (kategoria_id, kep_id) values (11, 32);
insert into kategoria_kep (kategoria_id, kep_id) values (3, 14);
insert into kategoria_kep (kategoria_id, kep_id) values (12, 37);
insert into kategoria_kep (kategoria_id, kep_id) values (9, 25);

--Album-kép insertek

insert into album_kep (album_id, kep_id) values (8, 9);
insert into album_kep (album_id, kep_id) values (6, 13);
insert into album_kep (album_id, kep_id) values (10, 31);
insert into album_kep (album_id, kep_id) values (4, 4);
insert into album_kep (album_id, kep_id) values (6, 33);
insert into album_kep (album_id, kep_id) values (10, 2);
insert into album_kep (album_id, kep_id) values (1, 45);
insert into album_kep (album_id, kep_id) values (9, 12);
insert into album_kep (album_id, kep_id) values (6, 8);
insert into album_kep (album_id, kep_id) values (6, 12);
insert into album_kep (album_id, kep_id) values (3, 4);
insert into album_kep (album_id, kep_id) values (9, 18);
insert into album_kep (album_id, kep_id) values (4, 5);
insert into album_kep (album_id, kep_id) values (10, 29);
insert into album_kep (album_id, kep_id) values (1, 3);
