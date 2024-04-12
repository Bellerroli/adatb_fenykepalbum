package hu.uszeged.fenykepalbum.model;

import jakarta.persistence.Column;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "FELHASZNALOK")
@Entity
@Builder
public class UserModel {
    @Id
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "JELSZO")
    private String pwd;
    @Column(name = "FELHASZNALONEV")
    private String nickname;
    @Column(name = "TELJES_NEV")
    private String fullName;
    @Column(name = "HELY_ID")
    private int placeID;
    @Column(name = "IS_ADMIN")
    private boolean isAdmin;

    @Override
    public String toString(){
        return email+" : "+nickname;
    }

}
