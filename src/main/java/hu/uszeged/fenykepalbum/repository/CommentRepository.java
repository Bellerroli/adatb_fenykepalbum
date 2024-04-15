package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.CommentModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<CommentModel, Long> {
}
