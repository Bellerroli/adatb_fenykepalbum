package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.RegistrationModel;
import hu.uszeged.fenykepalbum.model.UserModel;
import hu.uszeged.fenykepalbum.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Transactional
public class RegistrationService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    public String register(RegistrationModel registrationModel){
        UserModel userModel = UserModel.builder()
                .email(registrationModel.getEmail())
                .pwd(passwordEncoder.encode(registrationModel.getPwd()))
                .nickname(registrationModel.getNickname())
                .fullName(registrationModel.getFullName())
                .placeID(registrationModel.getPlaceID())
                .isAdmin(false)
                .build();
        userRepository.save(userModel);
        return "OK";
    }
}
