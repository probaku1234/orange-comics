package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document
public class Comment {
    @Id
    public String id;

    public String user; //id of user who posted comment
    public String message;  //contents of comment
    public Date datePosted;
    public String comic;  //id of comic comment is posted on
    public String messageGroup;  //id of message group message is posted in

    public Comment(String user, String message, Date datePosted){
        this.user = user;
        this.message = message;
        this.datePosted = datePosted;
    }

    public void setComic(String comic){
        this.comic = comic;
    }

    public void setMessageGroup(String messageGroup){
        this.messageGroup = messageGroup;
    }
}
