package hu.uszeged.fenykepalbum.model;

import hu.uszeged.fenykepalbum.composites.CategoryPictureKey;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "KATEGORIA_KEP")
@Entity
@IdClass(CategoryPictureKey.class)
public class CategoryPictureModel {
    @Id
    @Column(name = "KATEGORIA_ID")
    private int categoryID;
    @Id
    @Column(name = "KEP_ID")
    private int pictureID;
}
