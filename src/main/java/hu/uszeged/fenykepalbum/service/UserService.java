package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.dto.UserNotInPictures;
import hu.uszeged.fenykepalbum.model.UserModel;
import hu.uszeged.fenykepalbum.model.UserUpdateModel;
import hu.uszeged.fenykepalbum.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

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

    public UserUpdateModel mapToUserUpdateModel(UserModel userModel){
        return UserUpdateModel.builder()
                .email(userModel.getEmail())
                .fullName(userModel.getFullName())
                .placeID(userModel.getPlaceID())
                .nickname(userModel.getNickname())
                .build();
    }

    private UserModel mapToUserModel(UserUpdateModel userUpdateModel) {
        UserModel oldModel = userByID(userUpdateModel.getEmail());
        oldModel.setPlaceID(userUpdateModel.getPlaceID());
        oldModel.setPwd((!validatePassword(userUpdateModel.getPwd(), userUpdateModel.getPwdAgain())) ?
                oldModel.getPwd() : passwordEncoder.encode(userUpdateModel.getPwd()));
        oldModel.setFullName(userUpdateModel.getFullName());
        return oldModel;
    }

    public void updateUser(UserUpdateModel userUpdateModel){
        userRepository.save(mapToUserModel(userUpdateModel));
    }

    public boolean validatePassword(String pwd, String pwdAgain){
        return (pwd.equals(pwdAgain) && pwd.length() >= 6);
    }

    public List<UserNotInPictures> userNotIn(){
        return userRepository.userNotUpload();
    }
}
