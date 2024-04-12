package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.PlaceModel;
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
}
