package hu.uszeged.fenykepalbum.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryPictureUploadModel {
    private int pictureID;
    private List<Integer> categoryIDs;
}
