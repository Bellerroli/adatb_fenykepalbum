package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.*;
import hu.uszeged.fenykepalbum.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@EnableMethodSecurity(securedEnabled = true)
public class PictureController {
    private final PlaceService placeService;
    private final PictureService pictureService;
    private final CommentService commentService;
    private final AlbumService albumService;
    private final CategoryService categoryService;

    @PostMapping("/gallery/upload")
    public String imageUpload(@ModelAttribute("uploadModel") PictureUploadModel pictureUploadModel){
        try {
            if(pictureService.savePictureFile(pictureUploadModel))
                pictureService.addNewPicture(pictureUploadModel);
            else throw new Exception("Not supported picture format");
        }catch(Exception e){
            return "redirect:/gallery/pictureForm?msg=Upload+failed";
        }
        return "redirect:/gallery/pictureForm?msg=Upload+successful";
    }

    @GetMapping("/gallery/pictureForm")
    public String imageUploadForm(Model model){
        model.addAttribute("uploadModel", new PictureUploadModel());
        model.addAttribute("places", placeService.allPlaces());
        return "image_upload";
    }

    @GetMapping("/gallery")
    public String gallery(Model model){
        model.addAttribute("pictures", pictureService.allPictures());
        return "gallery";
    }

    @GetMapping("/gallery/{id}")
    public String showPicture(@PathVariable("id") int id, Model model){
        model.addAttribute("picture", pictureService.pictureById(id));
        model.addAttribute("albums", albumService.userAlbumModels());
        model.addAttribute("albumPicture", new AlbumPictureModel());
        model.addAttribute("comments", commentService.commentsByPictureiD((long) id));
        model.addAttribute("newComment", new CommentModel());
        model.addAttribute("categories", categoryService.allCategories());
        model.addAttribute("isPictureUserPicture", SecurityContextHolder.getContext()
                .getAuthentication().getName().equals(pictureService.pictureById(id).getEmail()));
        model.addAttribute("categoryPicture", new CategoryPictureUploadModel());
        model.addAttribute("currCategories", categoryService.categoriesOfPicture(id));
        model.addAttribute("isUserAdmin", SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream().anyMatch(a->a.getAuthority().equals("ROLE_ADMIN")));
        model.addAttribute("picturePlace", placeService.placeById(pictureService.pictureById(id).getPlaceID()));
        return "single_image";
    }

    @GetMapping("/user/gallery")
    public String userGallery(Model model){
        try{
            model.addAttribute("userPictures", pictureService.userPictures(SecurityContextHolder.getContext().
                    getAuthentication().getName()));
        }catch(Exception e){
            System.err.println(e.getMessage());
        }

        return "user/gallery";
    }

    @GetMapping("/picture/delete/{id}")
    public String deletePicture(@PathVariable("id") int pictureID){
        try{
            pictureService.deletePicture(pictureID);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
        return "redirect:/user/gallery";
    }

    @GetMapping("/picture/update")
    public String updatePicture(@RequestParam("pictureID") int id, @RequestParam("rating") int newRating){
        try{
            PictureModel pictureModel = pictureService.pictureById(id);
            pictureModel.setRating(newRating);
            pictureService.updatePicture(pictureModel);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
        return "redirect:/gallery/"+id;
    }
}
