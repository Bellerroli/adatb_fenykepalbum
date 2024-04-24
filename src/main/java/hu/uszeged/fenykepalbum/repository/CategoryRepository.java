package hu.uszeged.fenykepalbum.repository;

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
""",
    nativeQuery = true)
    List<CategoryModel> findCategoriesByPictureID(@Param("pictureid") int pictureid);
}
