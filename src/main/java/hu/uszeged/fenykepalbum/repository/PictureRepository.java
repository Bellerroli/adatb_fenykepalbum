package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.PictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PictureRepository extends JpaRepository<PictureModel, Integer> {
}
