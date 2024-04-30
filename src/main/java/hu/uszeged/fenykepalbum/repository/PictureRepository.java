package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.dto.PictureDataWithPlace;
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

}
