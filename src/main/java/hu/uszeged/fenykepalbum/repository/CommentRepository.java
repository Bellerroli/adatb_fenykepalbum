package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.CommentModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<CommentModel, Long> {
    @Query(value = "SELECT * FROM HOZZASZOLAS WHERE kep_id = :pictureid",
    nativeQuery = true)
    List<CommentModel> findCommentByPictureID(@Param("pictureid") long pictureID);
}
