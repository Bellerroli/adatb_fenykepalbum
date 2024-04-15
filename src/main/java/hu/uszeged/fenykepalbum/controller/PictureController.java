package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.CommentModel;
import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.service.CommentService;
import hu.uszeged.fenykepalbum.service.PictureService;
import hu.uszeged.fenykepalbum.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
@EnableMethodSecurity(securedEnabled = true)
public class PictureController {
    private final PlaceService placeService;
    private final PictureService pictureService;
    private final CommentService commentService;

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
        model.addAttribute("comments", commentService.commentsByPictureiD((long) id));
        model.addAttribute("newComment", new CommentModel());
        return "single_image";
    }
}
