package hu.uszeged.fenykepalbum.controller;

import hu.uszeged.fenykepalbum.model.CommentModel;
import hu.uszeged.fenykepalbum.service.CommentService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;

    @PostMapping("comment/save")
    public String saveComment(@ModelAttribute("newComment")CommentModel commentModel){
        commentService.newComment(commentModel);
        return "redirect:/gallery/"+commentModel.getPictureID();
    }
}
