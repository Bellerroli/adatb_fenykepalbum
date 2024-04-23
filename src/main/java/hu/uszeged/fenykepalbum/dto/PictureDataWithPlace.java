package hu.uszeged.fenykepalbum.dto;

import java.util.Date;

public interface PictureDataWithPlace {
    String getEamil();
    int getPictureID();
    String getTitle();
    String getDescription();
    double getRating();
    Date getUploadDate();
    String getCountry();
    String getCounty();
    String getCity();
    String getSettlement();
    String getFilePath();
}
