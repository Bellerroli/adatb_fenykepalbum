package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.CategoryCreateModel;
import hu.uszeged.fenykepalbum.model.CategoryPictureModel;
import hu.uszeged.fenykepalbum.model.CategoryPictureUploadModel;
import hu.uszeged.fenykepalbum.model.PlaceCreateModel;
import hu.uszeged.fenykepalbum.repository.CategoryRepository;
import hu.uszeged.fenykepalbum.service.CategoryPictureService;
import hu.uszeged.fenykepalbum.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@EnableMethodSecurity(securedEnabled = true)

public class CategoryController {
    private final CategoryService categoryService;
    private final CategoryPictureService categoryPictureService;

    @PostMapping("/category/Upload")
    public String categoryCreate(@ModelAttribute("categoryModel") CategoryCreateModel categoryCreateModel) {
        try {
            categoryService.addNewCategory(categoryCreateModel);
        } catch (Exception e) {
            return "redirect:/category/Upload?msg=Create+failed";
        }
        return "redirect:/category/Upload?msg=Create+successful";
    }

    @GetMapping("/category/Upload")
    public String place(Model model) {
        model.addAttribute("categoryModel", new CategoryCreateModel());
        return "category_create";
    }

    @PostMapping("/category/addPicture")
    public String addCategoryToPicture(@ModelAttribute("categoryPicture") CategoryPictureUploadModel categoryPictureUploadModel){
        categoryPictureService.saveCategoryPicture(categoryPictureUploadModel);
        return "redirect:/gallery/"+categoryPictureUploadModel.getPictureID();
    }

    @GetMapping("/category/picture/remove")
    public String removeCategoryFromPicture(@RequestParam("catid") int catID, @RequestParam("pictureid") int pictureID){
        try{
            categoryPictureService.deleteCategoryFromPicture(catID, pictureID);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
        return "redirect:/gallery/"+pictureID;
    }
}
