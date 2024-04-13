package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.model.PlaceUploadModel;
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
public class PlaceController {
    private final PlaceService placeService;

    @PostMapping("/place")
    public String imageUpload(@ModelAttribute("placeModel") PlaceUploadModel placeUploadModel) {
        try {
            if (!placeService.isSettlement(placeUploadModel)){
                placeUploadModel.setSettlement(null);
            }
            placeService.addNewPlace(placeUploadModel);
        } catch (Exception e) {
            return "redirect:/place?msg=Create+failed";
        }
        return "redirect:/place?msg=Create+successful";
    }

    @GetMapping("/place")
    public String place(Model model) {
        model.addAttribute("placeModel", new PlaceUploadModel());
        return "place_create";
    }
}
