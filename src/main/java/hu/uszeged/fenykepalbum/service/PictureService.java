package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.dto.PictureDataWithPlace;
import hu.uszeged.fenykepalbum.model.PictureModel;
import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.repository.PictureRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class PictureService {
    private final String[] acceptedExtensions = {"png", "jpg", "jpeg", "webp"};
    private final String IMG_ROOT_str = System.getProperty("user.dir")+"/src/main/resources/static/imgs";
    private final Path path = Paths.get(System.getProperty("user.dir"), "src", "main", "resources", "static", "imgs");
    private final String IMG_ROOT = path.toString();
    private final PictureRepository pictureRepository;

    public List<PictureModel> allPictures(){
        return pictureRepository.findAll();
    }

    public PictureModel addNewPicture(PictureUploadModel pictureUploadModel){
        PictureModel pictureModel = PictureModel.builder()
                .email(SecurityContextHolder.getContext().getAuthentication().getName())
                .pictureTitle(pictureUploadModel.getTitle())
                .pictureDescription(pictureUploadModel.getDescription())
                .rating(2.5)
                .uploadDate(pictureUploadModel.getDate())
                .filepath(pictureUploadModel.getNewFileName())
                .placeID(pictureUploadModel.getPlaceID())
                .build();
        return pictureRepository.save(pictureModel);
    }

    public boolean savePictureFile(PictureUploadModel pictureUploadModel) throws IOException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH-mm-ss");
        if(!isPictureFormat(pictureUploadModel)) return false;
        Date date = new Date();
        String filename = SecurityContextHolder.getContext().getAuthentication().getName().split("@")[0]+"_"+(formatter.format(date))+"."+fileExtension(pictureUploadModel);
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

    public PictureModel pictureById(int id){
        return pictureRepository.findById(id).orElseThrow();
    }

    public PictureDataWithPlace pictureByIdWithPlace(int id){
        return pictureRepository.findByIdWithPlace(id);
    }

    public boolean deletePicture(int id){
        Path path = Paths.get(IMG_ROOT, pictureById(id).getFilepath());
        File file = new File(path.toString());
        if(file.delete()){
            pictureRepository.deleteById(id);
            return true;
        }

        return false;
    }

    public List<PictureModel> userPictures(String email){
        return pictureRepository.findPictureByEmail(email);
    }

    public void updatePicture(PictureModel pictureModel){
        pictureRepository.save(pictureModel);
    }


    public List<PictureModel> picturesInCategory(int categoryID){
        return pictureRepository.findByCategory(categoryID);
    }
}
