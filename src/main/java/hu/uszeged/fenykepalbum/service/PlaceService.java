package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.PictureModel;
import hu.uszeged.fenykepalbum.model.PictureUploadModel;
import hu.uszeged.fenykepalbum.model.PlaceModel;
import hu.uszeged.fenykepalbum.model.PlaceUploadModel;
import hu.uszeged.fenykepalbum.repository.PlaceRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class PlaceService {
    private final PlaceRepository placeRepository;

    public List<PlaceModel> allPlaces(){
        return placeRepository.findAll();
    }

    public boolean addNewPlace(PlaceUploadModel placeUploadModel){
        PlaceModel placeModel = PlaceModel.builder()
                .placeID(placeUploadModel.getPlaceid())
                .country(placeUploadModel.getCountry())
                .county(placeUploadModel.getCounty())
                .city(placeUploadModel.getCity())
                .settlement(placeUploadModel.getSettlement())
                .build();
        placeRepository.save(placeModel);
        return true;
    }

    public boolean isSettlement(PlaceUploadModel placeUploadModel){
        if (placeUploadModel.getSettlement() == null){
            return false;
        }
        return true;
    }
}


