package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.model.AlbumModel;
import hu.uszeged.fenykepalbum.model.CategoryModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlbumRepository extends JpaRepository<AlbumModel, Integer> {
    @Query(value = "SELECT * FROM ALBUM WHERE email=?1",
    nativeQuery = true)
    List<AlbumModel> findAlbumsByEmail(String email);

    @Query(value = """
        SELECT DISTINCT album.* FROM ALBUM LEFT JOIN ALBUM_KEP ON(album.album_id = album_kep.album_id) 
        WHERE should_include_album(:pictureid, album.album_id) = 1 AND album.email = :email
    """,
            nativeQuery = true)
    List<AlbumModel> findByEmailAndPictureIDFiltered(@Param("email") String email, @Param("pictureid") int pictureID);
}
