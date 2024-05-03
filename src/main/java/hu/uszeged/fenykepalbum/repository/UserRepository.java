package hu.uszeged.fenykepalbum.repository;

import hu.uszeged.fenykepalbum.dto.PictureOneCategory;
import hu.uszeged.fenykepalbum.dto.UserNotInPictures;
import hu.uszeged.fenykepalbum.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<UserModel, String> {
    @Query(value = """
           SELECT FELHASZNALOK.email as email, FELHASZNALOK.teljes_nev as fullname
                            FROM FELHASZNALOK
                            where FELHASZNALOK.email not in(SELECT KEP.email FROM KEP group by email)
    """,
            nativeQuery = true)
    List<UserNotInPictures> userNotUpload();
}
