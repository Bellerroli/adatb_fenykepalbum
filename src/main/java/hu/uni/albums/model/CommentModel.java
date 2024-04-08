package hu.uni.albums.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentModel {
    private int commentID;
    private String email;
    private int pictureID;
    private String text;
    private String commentDate;
}
