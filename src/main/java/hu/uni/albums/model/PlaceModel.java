package hu.uni.albums.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlaceModel {
    private int placeID;
    private String country;
    private String county;
    private String city;
    private String settlement;
}
