package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.AlbumCreateModel;
import hu.uszeged.fenykepalbum.model.AlbumModel;
import hu.uszeged.fenykepalbum.model.PictureModel;
import hu.uszeged.fenykepalbum.repository.AlbumRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor

public class AlbumService {
    private final AlbumRepository albumRepository;

    public List<AlbumModel> albumModels(){
        return albumRepository.findAll();
    }

    public boolean addNewAlbum(AlbumCreateModel albumCreateModel){
        AlbumModel albumModel = AlbumModel.builder()
                .email(SecurityContextHolder.getContext().getAuthentication().getName())
                .createDate(albumCreateModel.getDate())
                .title(albumCreateModel.getTitle())
                .build();
        albumRepository.save(albumModel);
        return true;
    }
}
