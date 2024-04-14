package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.UserModel;
import hu.uszeged.fenykepalbum.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@Transactional
@RequiredArgsConstructor
public class ProfileDetailService implements UserDetailsService {
    private final UserRepository userRepository;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserModel user = userRepository.findById(username).orElseThrow(() -> new UsernameNotFoundException("No user with this email"));
        User loginUser = (User) User.builder().username(user.getEmail()).password(user.getPwd()).roles(roleMapper(user.isAdmin())).build();
        return loginUser;
    }

    private String[] roleMapper(boolean isAdmin){
        if(isAdmin) return new String[]{"ADMIN", "USER"};
        return new String[]{"USER"};
    }
}
