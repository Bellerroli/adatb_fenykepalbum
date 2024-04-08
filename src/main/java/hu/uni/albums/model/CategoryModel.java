package hu.uni.albums.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryModel {
    private int categoryID;
    private String categoryName;
    private String categoryDescription;
}
