package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.AuthModel;
import hu.uszeged.fenykepalbum.model.RegistrationModel;
import hu.uszeged.fenykepalbum.model.UserUpdateModel;
import hu.uszeged.fenykepalbum.service.AuthService;
import hu.uszeged.fenykepalbum.service.PlaceService;
import hu.uszeged.fenykepalbum.service.RegistrationService;
import hu.uszeged.fenykepalbum.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequiredArgsConstructor
@EnableMethodSecurity(
        securedEnabled = true
)
public class UserController {
    private final AuthService authService;
    private final RegistrationService registrationService;
    private final PlaceService placeService;
    private final UserService userService;

    @GetMapping(value = "/")
    public String indexPage() {
        return "index";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute("authModel") AuthModel authModel) {
        try {
            String userPrincipal = authService.authenticate(authModel);
        } catch (Exception e) {
            return "redirect:login";
        }
        return "redirect:/";
    }

    @GetMapping("/login")
    public ModelAndView loginPage(ModelMap model) {
        model.addAttribute("authmodel", new AuthModel());
        model.addAttribute("isAuthenticated", true);
        return new ModelAndView("login", model);
    }


    @GetMapping("/registration")
    public String registerPage(Model model) {
        model.addAttribute("regmodel", new RegistrationModel());
        model.addAttribute("places", placeService.allPlaces());
        return "register";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("regmodel") RegistrationModel registrationModel) {
        String regResponse = "";
        try{
            regResponse = registrationService.register(registrationModel);
        }catch(Exception e){
            return "redirect:/registration?msg=Registration+failed";
        }

        return "redirect:/login?msg=Registration?successful";
    }


    @GetMapping("profile/update")
    public String updateProfile(Model model){
        model.addAttribute("userDetails", userService.
                mapToUserUpdateModel(userService.userByID(SecurityContextHolder.getContext().getAuthentication().getName())));
        model.addAttribute("places", placeService.allPlaces());
        return "profile_update";
    }

    @PostMapping("profile/update")
    public String processUpdateProfile(@ModelAttribute("userDetails")UserUpdateModel userUpdateModel){
        userService.updateUser(userUpdateModel);
        return "redirect:/profile/update";
    }
}