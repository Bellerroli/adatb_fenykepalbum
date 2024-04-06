package hu.uni.albums.controller;

import hu.uni.albums.dao.UserDAO;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
    private final UserDAO userDAO = new UserDAO();
    @GetMapping(value="/firstUser", produces = MediaType.TEXT_HTML_VALUE)
    @ResponseBody
    public String callUser(){
        return "<h1>"+userDAO.getFirstUser().toString()+"</h1>";
    }

    @GetMapping(value = "/allUsers")
    public String allUsers(Model model){
        model.addAttribute("users", userDAO.getUsers());
        return "allUsers";
    }

    @GetMapping(value = "/login")
    public String login(){
        return "login";
    }

    @GetMapping(value = "/")
    public String index(){
        return "index";
    }
}
