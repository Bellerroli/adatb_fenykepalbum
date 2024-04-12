package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.PictureModel;
import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.repository.PictureRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class PictureService {
    private final String[] acceptedExtensions = {"png", "jpg", "jpeg"};
    private final String IMG_ROOT = System.getProperty("user.dir")+"/uploads";
    private final PictureRepository pictureRepository;

    public List<PictureModel> allPictures(){
        return pictureRepository.findAll();
    }

    public boolean addNewPicture(PictureUploadModel pictureUploadModel){
        PictureModel pictureModel = PictureModel.builder()
                .email(SecurityContextHolder.getContext().getAuthentication().getName())
                .pictureTitle(pictureUploadModel.getTitle())
                .pictureDescription(pictureUploadModel.getDescription())
                .rating(2.5)
                .uploadDate(pictureUploadModel.getDate())
                .filepath(pictureUploadModel.getNewFileName())
                .placeID(pictureUploadModel.getPlaceID())
                .build();
        pictureRepository.save(pictureModel);
        return true;
    }

    public boolean savePictureFile(PictureUploadModel pictureUploadModel) throws IOException {
        if(!isPictureFormat(pictureUploadModel)) return false;
        Date date = new Date();
        String filename = SecurityContextHolder.getContext().getAuthentication().getName()+"_"+(date)+"."+fileExtension(pictureUploadModel);
        Path filenameAndPath = Paths.get(IMG_ROOT, filename);
        Files.write(filenameAndPath, pictureUploadModel.getFile().getBytes());
        pictureUploadModel.setDate(date);
        pictureUploadModel.setNewFileName(filename);
        return true;
    }

    private boolean isPictureFormat(PictureUploadModel pictureUploadModel){
        String filename = pictureUploadModel.getFile().getOriginalFilename();
        for (String e: acceptedExtensions
             ) {
            if(filename != null && filename.toLowerCase().endsWith(e)) return true;
        }
        return false;
    }

    private String fileExtension(PictureUploadModel pictureUploadModel){
        String[] fileArr = pictureUploadModel.getFile().getOriginalFilename().split("[.]");
        return fileArr[fileArr.length-1];
    }
}
