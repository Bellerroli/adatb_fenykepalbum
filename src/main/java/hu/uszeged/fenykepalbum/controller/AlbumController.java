package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.AlbumCreateModel;
import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.service.AlbumService;
import hu.uszeged.fenykepalbum.service.PictureService;
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
public class AlbumController {
    private final AlbumService albumService;

    @PostMapping("/Albums/Upload")
    public String albumCreate(@ModelAttribute("albumModel") AlbumCreateModel albumCreateModel){
        try {
                albumService.addNewAlbum(albumCreateModel);
        }catch(Exception e){
            return "redirect:/Albums/album?msg=Upload+failed";
        }
        return "redirect:/Albums/album?msg=Upload+successful";
    }

    @GetMapping("/Albums/album")
    public String saveNewAlbum(Model model){
        model.addAttribute("albumModel", new AlbumCreateModel());
        return "album_create";
    }

}
