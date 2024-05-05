package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.UserModel;
import hu.uszeged.fenykepalbum.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@EnableMethodSecurity(securedEnabled = true)
public class AdminUserController {
    private final UserService userService;
    private final PictureService pictureService;
    private final AlbumService albumService;
    private final CategoryService categoryService;
    private final PlaceService placeService;
    @Secured("ROLE_ADMIN")
    @GetMapping("/admin")
    public String admin(){
        return "admin";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/users")
    public String adminUsers(Model model){
        model.addAttribute("users", userService.allUSers());
        return "admin/users";
    }

    @Secured("ROLE_ADMIN")
    @PostMapping("/admin/users/update")
    public String updateForm(@ModelAttribute("user") UserModel userModel){
        userService.adminUpdateUser(userModel);
        return "redirect:/admin/users";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("admin/users/delete")
    public String deleteUser(@RequestParam(name = "id") String id){
        userService.deleteUser(id);
        return "redirect:/admin/users";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/albums")
    public String adminAlbumList(Model model){
        model.addAttribute("albums", albumService.allAlbums());
        return "/admin/albums";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/categories")
    public String adminCategoryList(Model model){
        model.addAttribute("categories", categoryService.allCategories());
        return "/admin/categories";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/places")
    public String adminPlaceList(Model model){
        model.addAttribute("places", placeService.allPlaces());
        return "/admin/places";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/pictures")
    public String adminPictureList(Model model){
        model.addAttribute("pictures", pictureService.allPictures());
        return "/admin/pictures";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/pictures/delete/{id}")
    public String adminDeletePicture(@PathVariable("id") int id ){
        pictureService.deletePicture(id);
        return "redirect:/admin/pictures";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/albums/delete/{id}")
    public String adminDeleteAlbum(@PathVariable("id") int id){
        albumService.deleteAlbum(id);
        return "redirect:/admin/albums";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/categories/delete/{id}")
    public String adminDeleteCategory(@PathVariable("id") int id){
        categoryService.deleteCategory(id);
        return "redirect:/admin/categories";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/places/delete/{id}")
    public String adminDeletePlace(@PathVariable("id") int id){
        try{
            placeService.deletePlace(id);
        }catch(Exception e){
            System.err.println(e.getMessage());
            return "redirect:/admin/places?msg=Cannot+delete";
        }

        return "redirect:/admin/places";
    }
    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/statistics")
    public String adminStatistics(Model model){
        model.addAttribute("place_statistics", placeService.countyPictures());
        model.addAttribute("category_statistics", categoryService.categoryNumber());
        model.addAttribute("picture_one_category", pictureService.pictureOneCategory());
        model.addAttribute("user_not_upload", userService.userNotIn());
        model.addAttribute("empty_albums", albumService.emptyAlbums());
        model.addAttribute("categoriesOnPictures", pictureService.categoryNumberOnPictures());
        return "/admin/statistics";
    }
}
