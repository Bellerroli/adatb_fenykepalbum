package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.dto.CategoryNumberOnPicture;
import hu.uszeged.fenykepalbum.dto.PictureDataWithPlace;
import hu.uszeged.fenykepalbum.dto.PictureOneCategory;
import hu.uszeged.fenykepalbum.dto.UsedCategoryNumber;
import hu.uszeged.fenykepalbum.model.PictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PictureRepository extends JpaRepository<PictureModel, Integer> {

    @Query(value = """
    SELECT * FROM KEP WHERE email = :email
""",
    nativeQuery = true)
    List<PictureModel> findPictureByEmail(@Param("email") String email);
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
            kep.fajl_eleres AS filePath,
            kep.szoveges_ertekeles as ratingText
            FROM KEP INNER JOIN HELYSZIN ON(kep.hely_id = helyszin.hely_id)
            WHERE kep_id = :id
    """,
    nativeQuery = true)
    PictureDataWithPlace findByIdWithPlace(@Param("id") int pictureid);

    @Query(value = """
        SELECT
            kep.*
        FROM KEP INNER JOIN KATEGORIA_KEP ON (kep.kep_id = kategoria_kep.kep_id)
        WHERE kategoria_kep.kategoria_id = :catid
""",
            nativeQuery = true)
    List<PictureModel> findByCategory(@Param("catid") int categoryid);

    @Query(value = """
           SELECT KEP.cim as title, KATEGORIA.megnevezes as designation
           FROM (SELECT KATEGORIA_KEP.kep_id as pictureId, COUNT(KATEGORIA_KEP.kategoria_id) as howMany
           FROM KATEGORIA_KEP
           Group by kep_id)
           JOIN KEP ON pictureId = KEP.kep_id
           JOIN KATEGORIA_KEP ON KATEGORIA_KEP.kep_id = pictureId
           JOIN KATEGORIA ON KATEGORIA_KEP.kategoria_id = KATEGORIA.kategoria_id
           where howMany = 1
    """,
            nativeQuery = true)
    List<PictureOneCategory> oneCategoryInPicture();

    @Query(value = """
        SELECT kep.kep_id as pictureID,  kep.cim AS title, COUNT(*) AS categoryNumber
        FROM KEP INNER JOIN KATEGORIA_KEP ON (kep.kep_id = kategoria_kep.kep_id)
        GROUP BY kep.kep_id, kep.cim
        ORDER BY kep.kep_id
""" ,nativeQuery = true)
    List<CategoryNumberOnPicture> categoryNumberOnPictures();

}
