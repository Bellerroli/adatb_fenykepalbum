package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.AlbumPictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlbumPictureRepository extends JpaRepository<AlbumPictureModel, Integer> {
}
