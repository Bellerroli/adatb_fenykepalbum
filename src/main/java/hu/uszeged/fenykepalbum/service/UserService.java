package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.UserModel;
import hu.uszeged.fenykepalbum.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public List<UserModel> allUSers(){
        return userRepository.findAll();
    }

    public UserModel userByID(String id){
        return userRepository.findById(id).orElseThrow();
    }
    public void deleteUser(String id){
        userRepository.deleteById(id);
    }

    public void adminUpdateUser(UserModel userModel){
        UserModel oldData = userRepository.findById(userModel.getEmail()).orElseThrow();
        oldData.setAdmin(userModel.isAdmin());
        userRepository.save(oldData);
    }
}
