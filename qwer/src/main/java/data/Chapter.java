package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.net.URL;
import java.util.ArrayList;
import java.util.Date;

@Document
public class Chapter {
    @Id
    public String id;

    public URL url;
    public boolean isDraft;
    public Date publishedDate;
    public ArrayList<String> pages; //(Fabric.js files)
    public ArrayList<String> comments; //ids of comments

    public Chapter(URL url){
        this.url = url;
        isDraft = true;
        publishedDate = null;
        pages = new ArrayList<>();
        comments = new ArrayList<>();
    }
}
