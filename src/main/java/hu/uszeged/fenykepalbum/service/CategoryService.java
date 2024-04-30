package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.CategoryCreateModel;
import hu.uszeged.fenykepalbum.model.CategoryModel;
import hu.uszeged.fenykepalbum.model.PlaceModel;
import hu.uszeged.fenykepalbum.repository.CategoryRepository;
import hu.uszeged.fenykepalbum.repository.PlaceRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional

public class CategoryService {
    private final CategoryRepository categoryRepository;

    public List<CategoryModel> allCategories(){
        return categoryRepository.findAll();
    }

    public boolean addNewCategory(CategoryCreateModel categoryCreateModel){
        CategoryModel categoryModel = CategoryModel.builder()
                .categoryID(categoryCreateModel.getCategoryid())
                .categoryDesignation(categoryCreateModel.getDesignation())
                .categoryDescription(categoryCreateModel.getDescription())
                .build();
        categoryRepository.save(categoryModel);
        return true;
    }

    public void deleteCategory(int id){
        categoryRepository.deleteById(id);
    }

    public List<CategoryModel> categoriesOfPicture(int pictureID){
        return categoryRepository.findCategoriesByPictureID(pictureID);
    }

    public List<CategoryModel> categoriesWithoutPicture(int pictureID){
        return categoryRepository.findByPictureIDFiltered(pictureID);
    }
}
