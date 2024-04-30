package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.CategoryModel;
import hu.uszeged.fenykepalbum.model.CategoryPictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryPictureRepository extends JpaRepository<CategoryPictureModel, Integer> {

    @Modifying
    @Query(value = "DELETE FROM KATEGORIA_KEP WHERE kep_id = :pictureid AND kategoria_id = :catid",
    nativeQuery = true)
    void deleteByCategoryIDAndPictureID(@Param("catid") int catid, @Param("pictureid") int pictureid);
}
