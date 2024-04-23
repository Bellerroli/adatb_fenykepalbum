package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.dto.PictureDataWithPlace;
import hu.uszeged.fenykepalbum.model.AlbumPictureModel;
import hu.uszeged.fenykepalbum.repository.AlbumPictureRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class AlbumPictureService {
    private final AlbumPictureRepository albumPictureRepository;

    public void addPictureToAlbum(AlbumPictureModel albumPictureModel){
        albumPictureRepository.save(albumPictureModel);
    }

    public List<PictureDataWithPlace> albumPicturesByAlbumID(int albumid){
        return albumPictureRepository.findPictureByAlbumID(albumid);
    }

    public void removePictureFromAlbum(int albumID, int pictureID){
        albumPictureRepository.deleteByPictureAndAlbumID(albumID, pictureID);
    }
}
