package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.CategoryModel;
import hu.uszeged.fenykepalbum.model.CategoryPictureModel;
import hu.uszeged.fenykepalbum.model.CategoryPictureUploadModel;
import hu.uszeged.fenykepalbum.model.PictureModel;
import hu.uszeged.fenykepalbum.repository.CategoryPictureRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class CategoryPictureService {
    private final CategoryPictureRepository categoryPictureRepository;

    public void saveCategoryPicture(CategoryPictureUploadModel categoryPictureUploadModel){
        for(int id: categoryPictureUploadModel.getCategoryIDs()){
            categoryPictureRepository.save(CategoryPictureModel.builder()
                            .pictureID(categoryPictureUploadModel.getPictureID())
                            .categoryID(id)
                    .build());
        }

    }

    public void deleteCategoryFromPicture(int categoryID, int pictureID){
        categoryPictureRepository.deleteByCategoryIDAndPictureID(categoryID, pictureID);
    }
}
