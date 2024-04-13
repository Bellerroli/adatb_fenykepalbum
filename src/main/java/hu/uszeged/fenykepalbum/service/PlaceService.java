package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.PlaceModel;
import hu.uszeged.fenykepalbum.model.PlaceCreateModel;
import hu.uszeged.fenykepalbum.repository.PlaceRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
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

    public boolean addNewPlace(PlaceCreateModel placeCreateModel){
        PlaceModel placeModel = PlaceModel.builder()
                .placeID(placeCreateModel.getPlaceid())
                .country(placeCreateModel.getCountry())
                .county(placeCreateModel.getCounty())
                .city(placeCreateModel.getCity())
                .settlement(placeCreateModel.getSettlement())
                .build();
        placeRepository.save(placeModel);
        return true;
    }

    public boolean isSettlement(PlaceCreateModel placeCreateModel){
        if (placeCreateModel.getSettlement() == null){
            return false;
        }
        return true;
    }
}


