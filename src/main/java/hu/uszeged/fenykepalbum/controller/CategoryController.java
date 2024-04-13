package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.CategoryCreateModel;
import hu.uszeged.fenykepalbum.model.PlaceCreateModel;
import hu.uszeged.fenykepalbum.repository.CategoryRepository;
import hu.uszeged.fenykepalbum.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
@EnableMethodSecurity(securedEnabled = true)

public class CategoryController {
    private final CategoryService categoryService;

    @PostMapping("/category")
    public String imageUpload(@ModelAttribute("categoryModel") CategoryCreateModel categoryCreateModel) {
        try {
            categoryService.addNewCategory(categoryCreateModel);
        } catch (Exception e) {
            return "redirect:/category?msg=Create+failed";
        }
        return "redirect:/category?msg=Create+successful";
    }

    @GetMapping("/category")
    public String place(Model model) {
        model.addAttribute("categoryModel", new CategoryCreateModel());
        return "category_create";
    }
}
