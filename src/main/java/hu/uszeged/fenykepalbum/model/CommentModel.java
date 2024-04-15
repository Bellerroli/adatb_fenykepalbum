package hu.uszeged.fenykepalbum.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "HOZZASZOLAS")
@Entity
public class CommentModel {
    @Id
    @SequenceGenerator(name = "hozzaszolasid_generator", sequenceName = "HOZZASZOLAS_SEQUENCE", initialValue = 1, allocationSize = 1)
    @GeneratedValue(generator = "hozzaszolasid_generator")
    @Column(name = "HOZZASZOLAS_ID")
    private long id;
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "KEP_ID")
    private int pictureID;
    @Column(name = "SZOVEG")
    private String content;
    @Column(name = "IDOPONT")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeStamp;
}
