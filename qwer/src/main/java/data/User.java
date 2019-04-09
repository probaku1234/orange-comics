package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.net.URL;
import java.util.ArrayList;

@Document
public class User {
    @Id
    public String id;

    public String name;
    public byte[] password_salt;
    public byte[] password_hash;
    public String email;
    public URL avatar;
    public String profile_description;
    public ArrayList<String> notification_settings;
    public ArrayList<String> notifications;
    public String site_theme;
    public ArrayList<String> favorites;
    public ArrayList<String> conversations;
    public ArrayList<String> comics;
    public ArrayList<String> private_characters;


    public User(String name, byte[] password_salt, byte[] password_hash, String email){
        this.name = name;
        this.password_salt = password_salt;
        this.password_hash = password_hash;
        this.email = email;
        avatar = null;
        profile_description = "";
        notification_settings = new ArrayList<String>();
        notifications = new ArrayList<String>();
        site_theme = "DEFAULT";
        favorites = new ArrayList<String>();
        conversations = new ArrayList<String>();
        comics = new ArrayList<String>();
        private_characters = new ArrayList<String>();
    }
}
