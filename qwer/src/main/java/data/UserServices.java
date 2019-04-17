package data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Optional;
import java.net.URL;

@Component
public class UserServices {

    public static String FAVORITE_NOTIFICATIONS = "FAVORITE";
    public static String COMMENT_NOTIFICATIONS = "COMMENT";
    public static String MESSAGE_NOTIFICATIONS = "MESSAGE";

    @Autowired
    private UserRepository userRepository;

    @Autowired
    PremadeCharacterRepository premadeCharacterRepository;

    public void signUp(String username, String password, String email, String activationCode){
        if(userRepository.findByName(username) != null){
            System.out.println("User with username already exists.");
            return;
        }
        if(userRepository.findByEmail(email) != null){
            System.out.println("User with email already exists.");
            return;
        }
        byte[] password_salt = Passwords.generateSalt();
        byte[] password_hash = Passwords.hash(password.toCharArray(), password_salt);

        User user = new User(username, password_salt, password_hash, email, activationCode);
        user.notification_settings.put(FAVORITE_NOTIFICATIONS, true);
        user.notification_settings.put(COMMENT_NOTIFICATIONS, true);
        user.notification_settings.put(MESSAGE_NOTIFICATIONS, true);
        userRepository.save(user);
    }

    public void activateUser(String userID, String activationCode){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        if (user.activated) {
            System.out.println("User already activated.");
            return;
        }

        if(activationCode != user.activationCode){
            System.out.println("Activation code is incorrect.");
            return;
        }

        user.activated = true;
        userRepository.save(user);
    }

    public int signIn(String username, String password){
        User user = userRepository.findByName(username);

        if(user == null){
            System.out.println("User with given username doesn't exist.");
            return 0;
        }

        if(!Passwords.isExpectedPassword(password.toCharArray(), user.password_salt, user.password_hash)){
            System.out.println("Password is incorrect.");
            return 0;
        }

        //TODO rest of login

        return 1;
    }

    public void signOut(){
        //TODO
    }

    public String getIDbyUsername(String username){
        User user = userRepository.findByName(username);

        if(user == null){
            System.out.println("User with given username doesn't exist.");
            return null;
        }

        return user.id;
    }

    public void changePassword(String userID, String password){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.password_hash = Passwords.hash(password.toCharArray(), user.password_salt);
        userRepository.save(user);
    }

    public void changeUsername(String userID, String name){
        if(userRepository.findByName(name) != null){
            System.out.println("User with username already exists.");
            return;
        }

        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.name = name;
        userRepository.save(user);
    }

    public String getUsername(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();
        return user.name;
    }

    public void setAvatar(String userID, URL imageLink){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.avatar = imageLink;
        userRepository.save(user);
    }

    public URL getAvatarLink(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();
        if(user.avatar == null){
            System.out.println("User doesn't have avatar");
            return null; //TODO change to link for default avatar
        }
        return user.avatar;
    }

    public void setProfileDescription(String userID, String description){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.profile_description = description;
        userRepository.save(user);
    }

    public String getProfileDescription(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();
        return user.profile_description;
    }

    public void setNotificationSettings(String userID, String notificationType, boolean enabled){
        if(notificationType != FAVORITE_NOTIFICATIONS && notificationType != COMMENT_NOTIFICATIONS &&
                notificationType != MESSAGE_NOTIFICATIONS){
            System.out.println("Invalid notification type.");
        }

        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.notification_settings.put(notificationType, enabled);
        userRepository.save(user);
    }

    public void addNotification(String userID, String notificationType, String notification){
        if(notificationType != FAVORITE_NOTIFICATIONS && notificationType != COMMENT_NOTIFICATIONS &&
                notificationType != MESSAGE_NOTIFICATIONS){
            System.out.println("Invalid notification type.");
        }

        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        if(!user.notification_settings.get(notification)){
            System.out.println("Notification type disabled.");
        }

        user.notifications.add(notification);
        userRepository.save(user);
    }

    public void clearNotifications(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.notifications.clear();
        userRepository.save(user);
    }

    public ArrayList<String> getNotifications(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();
        return user.notifications;
    }

    public String getTheme(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();

        return user.site_theme;
    }

    public void setTheme(String userID, String siteTheme){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        user.site_theme = siteTheme;
        userRepository.save(user);
    }

    public void addFavoriteComic(String userID, String comicID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        if(user.favorites.contains(comicID)){
            System.out.println("Comic is already set as favorite");
            return;
        }

        user.favorites.add(comicID);
        userRepository.save(user);
    }

    public void removeFavoriteComic(String userID, String comicID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        if(!user.favorites.contains(comicID)){
            System.out.println("Comic is not set as favorite");
            return;
        }

        user.favorites.remove(comicID);
        userRepository.save(user);
    }

    public ArrayList<String> getFavoriteComics(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();
        return user.favorites;
    }

    public ArrayList<PremadeCharacter> getAllPublicCharacters(){
        return new ArrayList<>(premadeCharacterRepository.findByIsPublicIsTrue());
    }

    public void createPremadeCharacter(String userID, URL image){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        PremadeCharacter character = new PremadeCharacter(false, image);

        premadeCharacterRepository.save(character);

        user.private_characters.add(character.id);
        userRepository.save(user);
    }

    public void deletePremadeCharacter(String userID, String charID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
        }
        User user = optUser.get();

        if(!user.private_characters.contains(charID)){
            System.out.println("User does not have rights to delete given character.");
            return;
        }

        Optional<PremadeCharacter> optChar = premadeCharacterRepository.findById(charID);

        if(!optChar.isPresent()){
            System.out.println("Character doesn't exist.");
            user.private_characters.remove(charID);
            userRepository.save(user);
            return;
        }

        PremadeCharacter character = optChar.get();

        premadeCharacterRepository.delete(character);
        user.private_characters.remove(charID);
        userRepository.save(user);
    }

    public ArrayList<PremadeCharacter> getAllUserCharacters(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return null;
        }
        User user = optUser.get();

        ArrayList<PremadeCharacter> characters = new ArrayList<>();
        ArrayList<String> toRemove = new ArrayList<>(); //character IDs that somehow don't match to characters
        for (String charID: user.private_characters){

            Optional<PremadeCharacter> optChar = premadeCharacterRepository.findById(charID);

            if(!optChar.isPresent()){
                System.out.println("Character doesn't exist.");
                toRemove.add(charID);
            }else{
                PremadeCharacter character = optChar.get();
                characters.add(character);
            }
        }
        user.private_characters.removeAll(toRemove);
        userRepository.save(user);

        return characters;
    }
}
