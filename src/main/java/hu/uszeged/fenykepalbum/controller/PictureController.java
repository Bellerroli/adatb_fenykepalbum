package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.service.PictureService;
import hu.uszeged.fenykepalbum.service.PlaceService;
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
public class PictureController {
    private final PlaceService placeService;
    private final PictureService pictureService;

    @PostMapping("/gallery/upload")
    public String imageUpload(@ModelAttribute("uploadModel") PictureUploadModel pictureUploadModel){
        try {
            if(pictureService.savePictureFile(pictureUploadModel))
                pictureService.addNewPicture(pictureUploadModel);
        }catch(Exception e){
            return "redirect:/gallery/pictureForm?msg=Upload+failed";
        }
        return "redirect:/gallery/pictureForm?msg=Upload+successful";
    }

    @GetMapping("/gallery/pictureForm")
    public String imageUploadForm(Model model, PictureUploadModel pictureUploadModel){
        model.addAttribute("uploadModel", new PictureUploadModel());
        model.addAttribute("places", placeService.allPlaces());
        return "image_upload";
    }
}
