package data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

@Document
public class User {
    @Id
    public String id;

    public String name;
    public byte[] password_salt;
    public byte[] password_hash;
    public String email;
    public String avatar;  //imageID
    public String profile_description;
    public String site_theme;
    public ArrayList<String> favorites;
    public ArrayList<String> conversations;
    public ArrayList<String> private_characters;

    public HashMap<String, Boolean> notification_settings;
    public ArrayList<String> newNotifications;
    public ArrayList<String> oldNotifications;

    public boolean activated;
    public String activationCode;
    public URL resetURL;


    public User(String name, byte[] password_salt, byte[] password_hash, String email, String activationCode){
        this.name = name;
        this.password_salt = password_salt;
        this.password_hash = password_hash;
        this.email = email;
        avatar = null;
        profile_description = "";
        notification_settings = new HashMap<String, Boolean>();
        newNotifications = new ArrayList<String>();
        oldNotifications = new ArrayList<String>();
        site_theme = "DEFAULT";
        favorites = new ArrayList<String>();
        conversations = new ArrayList<String>();
        private_characters = new ArrayList<String>();

        activated = false;
        this.activationCode = activationCode;
    }
}
