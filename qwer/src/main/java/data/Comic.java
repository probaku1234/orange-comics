package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.Date;

@Document
public class Comic {
    @Id
    public String id;

    public String title;
    public String author; //ID of the author
    public String description;
    public String url;
    public String publishedStatus;
    public Date publishedDate;
    public Date lastUpdate;
    public ArrayList<String> genres;
    public ArrayList<String> tags;
    public ArrayList<String> chapters; //IDs of each chapter


    public Comic(String title, String author, String url){
        this.title = title;
        this.author = author;
        description = "";
        this.url = url;
        publishedStatus = "";
        publishedDate = null;
        lastUpdate = null;
        genres = new ArrayList<String>();
        tags = new ArrayList<String>();
        chapters = new ArrayList<String>();
    }
}
