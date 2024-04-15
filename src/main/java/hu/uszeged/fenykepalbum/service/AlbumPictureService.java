package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.AlbumPictureModel;
import hu.uszeged.fenykepalbum.repository.AlbumPictureRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@Transactional
@RequiredArgsConstructor
public class AlbumPictureService {
    private final AlbumPictureRepository albumPictureRepository;

    public void addPictureToAlbum(AlbumPictureModel albumPictureModel){
        albumPictureRepository.save(albumPictureModel);
    }
}
