package hu.uszeged.fenykepalbum.composites;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
@NoArgsConstructor
@AllArgsConstructor
@Data
public class AlbumPictureKey implements Serializable {
    private int albumID;
    private int pictureID;
}
