package hu.uszeged.fenykepalbum.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlaceCreateModel {
    private int placeid;
    private String country;
    private String county;
    private String city;
    private String settlement;
}
