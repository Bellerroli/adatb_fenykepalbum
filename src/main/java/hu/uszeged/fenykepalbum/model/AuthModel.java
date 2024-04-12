package hu.uszeged.fenykepalbum.model;

import lombok.*;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AuthModel implements Serializable {
    private String email;
    private String pwd;
}
