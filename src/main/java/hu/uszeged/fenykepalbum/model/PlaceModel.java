package hu.uszeged.fenykepalbum.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "HELYSZIN")
@Entity
@Builder
public class PlaceModel {
    @Id
    @GeneratedValue(generator = "placeid_generator")
    @SequenceGenerator(name = "placeid_generator", sequenceName = "HELY_SEQUENCE", initialValue = 5, allocationSize = 1)
    @Column(name = "HELY_ID")
    private int placeID;
    @Column(name = "ORSZAG")
    private String country;
    @Column(name = "MEGYE")
    private String county;
    @Column(name = "VAROS")
    private String city;
    @Column(name = "TELEPULES")
    private String settlement;


    @Override
    public String toString(){
        return country+", "+county+", "+city+((settlement == null) || settlement.isEmpty() ? "":", "+settlement);
    }
}
