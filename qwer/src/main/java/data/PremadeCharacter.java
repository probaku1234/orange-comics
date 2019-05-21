package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.net.URL;
import java.util.ArrayList;

@Document
public class PremadeCharacter {
    @Id
    public String id;

    public boolean isPublic;
    public String image;

    public PremadeCharacter(boolean isPublic, String image){
        this.isPublic = isPublic;
        this.image= image;
    }
}
