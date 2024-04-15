package hu.uszeged.fenykepalbum.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserUpdateModel {
    private String email;
    private String fullName;
    private String nickname;
    private String pwd;
    private String pwdAgain;
    private int placeID;
}
