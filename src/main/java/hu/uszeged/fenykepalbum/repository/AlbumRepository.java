package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.AlbumModel;
import hu.uszeged.fenykepalbum.model.CategoryModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlbumRepository extends JpaRepository<AlbumModel, Integer> {
}
