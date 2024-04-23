package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.dto.PictureDataWithPlace;
import hu.uszeged.fenykepalbum.model.AlbumPictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlbumPictureRepository extends JpaRepository<AlbumPictureModel, Integer> {

    @Query(value = """
        SELECT
        kep.email,
        kep.kep_id AS pictureID,
        kep.cim AS title,
        kep.leiras AS description,
        kep.ertekeles AS rating,
        kep.feltoltes_ideje AS uploadDate,
        helyszin.orszag AS country,
        helyszin.megye AS county,
        helyszin.varos AS city,
        helyszin.telepules AS settlement,
        kep.fajl_eleres AS filePath
        FROM (ALBUM_KEP INNER JOIN KEP ON (album_kep.kep_id = kep.kep_id))
        INNER JOIN HELYSZIN ON (helyszin.hely_id = kep.hely_id)\s
        WHERE album_kep.album_id = :albumid
""",
            nativeQuery = true)
    List<PictureDataWithPlace> findPictureByAlbumID(@Param("albumid") int albumid);
    @Modifying
    @Query(value = """
    DELETE FROM ALBUM_KEP WHERE KEP_ID = :pictureid AND ALBUM_ID = :albumid
    """, nativeQuery = true)
    void deleteByPictureAndAlbumID(@Param("albumid") int albumid, @Param("pictureid") int pictureid);
}
