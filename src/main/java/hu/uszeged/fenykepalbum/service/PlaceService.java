package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.PlaceModel;
import hu.uszeged.fenykepalbum.model.PlaceUploadModel;
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

    public String newPlace(PlaceUploadModel placeUploadModel){
        PlaceModel placeModel = PlaceModel.builder()
                .city(placeUploadModel.getCity())
                .country(placeUploadModel.getCountry())
                .county(placeUploadModel.getCounty())
                .settlement(placeUploadModel.getSettlement())
                .build();
        placeRepository.save(placeModel);
        return "OK";
    }

    public void deletePlace(int id){
        placeRepository.deleteById(id);
    }

    public PlaceModel placeById(int id){
        return placeRepository.findById(id).orElseThrow();
    }
}
