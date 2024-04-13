package hu.uszeged.fenykepalbum.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "ALBUM")
@Entity
@Builder
public class AlbumModel {
    @Id
    @SequenceGenerator(name = "albumid_generator", sequenceName = "ALBUM_SEQUENCE", initialValue = 5, allocationSize = 1)
    @GeneratedValue(generator = "albumid_generator")
    @Column(name = "ALBUM_ID")
    private int albumID;
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "LETREHOZAS_DATUM")
    @Temporal(TemporalType.DATE)
    private Date createDate;
    @Column(name = "CIM")
    private String title;

}
