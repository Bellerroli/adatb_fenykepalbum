package hu.uszeged.fenykepalbum.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "KEP")
@Entity
@Builder
public class PictureModel {
    @Column(name = "EMAIL")
    private String email;
    @Id
    @SequenceGenerator(name = "kepid_generator", sequenceName = "KEP_SEQUENCE", initialValue = 3, allocationSize = 1)
    @GeneratedValue(generator = "kepid_generator")
    @Column(name = "KEP_ID")
    private int pictureID;
    @Column(name = "CIM")
    private String pictureTitle;
    @Column(name = "LEIRAS")
    private String pictureDescription;
    @Column(name = "ERTEKELES")
    private double rating;
    @Column(name = "FELTOLTES_IDEJE")
    @Temporal(TemporalType.DATE)
    private Date uploadDate;
    @Column(name = "HELY_ID")
    private int placeID;
    @Column(name = "FAJL_ELERES")
    private String filepath;
//    @Column(name = "SZOVEGES_ERTEKELES")
//    private String ratingText;
}
