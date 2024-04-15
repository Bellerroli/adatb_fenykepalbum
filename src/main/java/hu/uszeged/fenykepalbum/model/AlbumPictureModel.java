package hu.uszeged.fenykepalbum.model;

import hu.uszeged.fenykepalbum.composites.AlbumPictureKey;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "ALBUM_KEP")
@Entity
@IdClass(AlbumPictureKey.class)
public class AlbumPictureModel {
    @Id
    @Column(name = "ALBUM_ID")
    private int albumID;
    @Id
    @Column(name = "KEP_ID")
    private int pictureID;
}
