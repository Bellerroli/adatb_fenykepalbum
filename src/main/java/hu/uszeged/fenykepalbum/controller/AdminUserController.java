package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.UserModel;
import hu.uszeged.fenykepalbum.service.UserService;
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
}
