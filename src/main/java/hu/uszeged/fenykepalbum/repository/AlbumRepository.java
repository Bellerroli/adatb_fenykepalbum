package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.AlbumModel;
import hu.uszeged.fenykepalbum.model.CategoryModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AlbumRepository extends JpaRepository<AlbumModel, Integer> {
    @Query(value = "SELECT * FROM ALBUM WHERE email=?1",
    nativeQuery = true)
    List<AlbumModel> findAlbumsByEmail(String email);
}
