package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.AlbumCreateModel;
import hu.uszeged.fenykepalbum.model.AlbumPictureModel;
import hu.uszeged.fenykepalbum.service.AlbumPictureService;
import hu.uszeged.fenykepalbum.service.AlbumService;
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
public class AlbumController {
    private final AlbumService albumService;
    private final AlbumPictureService albumPictureService;

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

    @PostMapping("/albums/addPicture")
    public String addPictureToAlbum(@ModelAttribute("model")AlbumPictureModel albumPictureModel){
        albumPictureService.addPictureToAlbum(albumPictureModel);
        return "redirect:/gallery/"+albumPictureModel.getPictureID();
    }

    @GetMapping("/user/albums")
    public String userAlbums(Model model){
        try{
            model.addAttribute("userAlbums", albumService.loggedInUserAlbums());
        }catch (Exception e){
            return "redirect:/error";
        }

        return "user/albums";
    }

    @GetMapping("/user/album/{id}")
    public String singleAlbum(@PathVariable("id") int id, Model model){
        model.addAttribute("albumDetails", albumService.albumById(id));
        model.addAttribute("albumPictures", albumPictureService.albumPicturesByAlbumID(id));
        model.addAttribute("pictureToRemove", new AlbumPictureModel());
        model.addAttribute("userEmail", SecurityContextHolder.getContext().getAuthentication().getName());
        return "single_album";
    }

    @PostMapping("/album/picture/delete")
    public String removePictureFromAlbum(@ModelAttribute("pictureToRemove")AlbumPictureModel albumPictureModel){
        try{
            albumPictureService.removePictureFromAlbum(albumPictureModel.getAlbumID(), albumPictureModel.getPictureID());
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
        return "redirect:/user/album/"+albumPictureModel.getAlbumID();
    }

    @GetMapping("/album/delete/{id}")
    public String deleteAlbum(@PathVariable("id") int albumid){
        try{
            albumService.deleteAlbum(albumid);
        }catch (Exception e){
            System.err.println(e.getMessage());
        }
        return "redirect:/user/albums";
    }
}
