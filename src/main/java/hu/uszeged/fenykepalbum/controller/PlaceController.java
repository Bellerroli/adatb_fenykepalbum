package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.PlaceUploadModel;
import hu.uszeged.fenykepalbum.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class PlaceController {
    private final PlaceService placeService;

    @GetMapping("places/newPlace")
    public String newPlace(Model model){
        model.addAttribute("placeModel", new PlaceUploadModel());
        return "place_create";
    }

    @PostMapping("/places/upload")
    public String saveNewPlace(@ModelAttribute("placeModel") PlaceUploadModel placeUploadModel){
        try{
            placeService.newPlace(placeUploadModel);
        }catch (Exception e){
            return "redirect:/places/newPlace?msg=Failed to create new place";
        }
        return  "redirect:/places/newPlace?msg=New place created";
    }
}
