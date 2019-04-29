package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.Date;

@Document
public class MessageGroup {
    @Id
    public String id;

    public ArrayList<String> users; //id of user who posted comment
    public Date lastMessage;

    public MessageGroup(ArrayList<String> users){
        this.users = users;
    }
}
