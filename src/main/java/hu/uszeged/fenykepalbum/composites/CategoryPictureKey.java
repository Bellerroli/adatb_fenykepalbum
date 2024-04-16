package hu.uszeged.fenykepalbum.composites;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CategoryPictureKey implements Serializable {
    private int categoryID;
    private int pictureID;
}
