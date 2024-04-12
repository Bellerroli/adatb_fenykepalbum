package hu.uszeged.fenykepalbum.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PictureUploadModel {
    private String title;
    private String description;
    private int placeID;
    private MultipartFile file;
    private Date date;
    private String newFileName;
}
