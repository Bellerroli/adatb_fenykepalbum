package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.dto.PictureDataWithPlace;
import hu.uszeged.fenykepalbum.dto.PictureNumberByCounty;
import hu.uszeged.fenykepalbum.model.PlaceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository<PlaceModel, Integer> {
    @Query(value = """
            SELECT HELYSZIN.megye AS placeCounty, COUNT(*) AS pictureNumber
            FROM HELYSZIN
            JOIN Kep ON HELYSZIN.hely_id = KEP.hely_id
            GROUP BY HELYSZIN.megye
            ORDER BY pictureNumber DESC
    """, nativeQuery = true)
    List<PictureNumberByCounty> picturesInCounty();
}
