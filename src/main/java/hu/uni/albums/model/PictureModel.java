package hu.uni.albums.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PictureModel {
    private String email;
    private int pictureID;
    private String title;
    private String description;
    private double rating;
    private String uploadDate;
    private int placeID;
    private String filepath;
}
