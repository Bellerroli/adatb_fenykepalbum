package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.CategoryPictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryPictureRepository extends JpaRepository<CategoryPictureModel, Integer> {
}
