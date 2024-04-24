package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.CommentModel;
import hu.uszeged.fenykepalbum.repository.CommentRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class CommentService {
    private final CommentRepository commentRepository;

    //TODO: a következő mérföldkőre ezt a metódust át kell dolgozni
    public List<CommentModel> commentsByPictureiD(Long pictureID){
        List<CommentModel> ret = new ArrayList<>();
        //SQL query a CommentRepositoryban a foreach loop helyett
        for(CommentModel cm: commentRepository.findAll()){
            if(cm.getPictureID() == pictureID) ret.add(cm);
        }

        return ret;
    }

    public CommentModel commentByID(int id){
        return commentRepository.findById((long) id).orElseThrow();
    }

    public void deleteComment(int id){
        commentRepository.deleteById((long) id);
    }

    public void newComment(CommentModel cm){
        if(cm.getContent().isEmpty()) return;
        cm.setTimeStamp(new Date());
        cm.setEmail(SecurityContextHolder.getContext().getAuthentication().getName());
        commentRepository.save(cm);
    }
}
