package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.dto.UsedCategoryNumber;
import hu.uszeged.fenykepalbum.model.CategoryModel;
import hu.uszeged.fenykepalbum.model.PictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface CategoryRepository extends JpaRepository<CategoryModel, Integer> {
    @Query(value = """
        SELECT kategoria.kategoria_id, kategoria.megnevezes, kategoria.leiras
        FROM KATEGORIA INNER JOIN KATEGORIA_KEP ON (kategoria.kategoria_id = kategoria_kep.kategoria_id)
        WHERE kategoria_kep.kep_id = :pictureid
        ORDER BY kategoria.megnevezes
""",
    nativeQuery = true)
    List<CategoryModel> findCategoriesByPictureID(@Param("pictureid") int pictureid);

    @Query(value = """
    SELECT DISTINCT kategoria.kategoria_id, kategoria.megnevezes, kategoria.leiras 
    FROM KATEGORIA LEFT JOIN KATEGORIA_KEP ON (kategoria.kategoria_id = kategoria_kep.kategoria_id) 
    WHERE should_include_category(:pictureid, kategoria.kategoria_id) = 1
    ORDER BY kategoria.megnevezes
""",nativeQuery = true)
    List<CategoryModel> findByPictureIDFiltered(@Param("pictureid") int pictureid);
    @Query(value = "SELECT * FROM KATEGORIA ORDER BY megnevezes",
    nativeQuery = true)
    List<CategoryModel> findAllOrdered();

    @Query(value = """
            SELECT KATEGORIA.megnevezes AS designation, COUNT(KATEGORIA_KEP.kep_id) AS used
            FROM KATEGORIA
            JOIN KATEGORIA_KEP ON Kategoria.kategoria_id = KATEGORIA_KEP.kategoria_id
            JOIN Kep ON KATEGORIA_KEP.kep_id = KEP.kep_id
            GROUP BY KATEGORIA.megnevezes
            ORDER BY used DESC
            """,
            nativeQuery = true)
    List<UsedCategoryNumber> usedCategory();
}
