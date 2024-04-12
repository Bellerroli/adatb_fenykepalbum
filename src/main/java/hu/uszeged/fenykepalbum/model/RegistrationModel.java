package hu.uszeged.fenykepalbum.model;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegistrationModel {
    private String email;
    private String pwd;
    private String fullName;
    private int placeID;
    private String nickname;

    @Override
    public String toString() {
        return String.join( " : ", email, pwd, fullName, nickname);
    }
}
