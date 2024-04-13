package hu.uszeged.fenykepalbum.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryCreateModel {
    private int categoryid;
    private String designation;
    private String description;
}
