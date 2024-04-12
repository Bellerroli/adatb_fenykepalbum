package hu.uszeged.fenykepalbum.service;

import hu.uszeged.fenykepalbum.model.AuthModel;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
@RequiredArgsConstructor
public class AuthService{
    private final AuthenticationManager authenticationManager;

    public String authenticate(AuthModel authModel) throws Exception{
        Objects.requireNonNull(authModel.getEmail());
        Objects.requireNonNull(authModel.getPwd());
        try {
            Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authModel.getEmail(), authModel.getPwd()));
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return authentication.getPrincipal().toString();
        }catch(BadCredentialsException e){
            throw new Exception("INVALID CREDENTIALS", e);
        }
    }
}
