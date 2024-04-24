package hu.uszeged.fenykepalbum.repository;

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
}
