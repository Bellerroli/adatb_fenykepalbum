package hu.uszeged.fenykepalbum.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "KATEGORIA")
@Entity
@Builder

public class CategoryModel {
    @Id
    @GeneratedValue(generator = "categoryid_generator")
    @SequenceGenerator(name = "categoryid_generator", sequenceName = "KATEGORIA_SEQUENCE", initialValue = 5, allocationSize = 1)
    @Column(name = "KATEGORIA_ID")
    private int categoryID;
    @Column(name = "MEGNEVEZES")
    private String categoryDesignation;
    @Column(name = "LEIRAS")
    private String categoryDescription;

    @Override
    public String toString(){
        return categoryDesignation +", " + categoryDescription;
    }
}
