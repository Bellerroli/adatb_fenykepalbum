package hu.uni.albums.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserModel {
    private String email;
    private String pwd;
    private String nickname;
    private String fullName;
    private int placeID;
    private boolean isAdmin;

    @Override
    public String toString(){
        return email+" : "+nickname;
    }
}
