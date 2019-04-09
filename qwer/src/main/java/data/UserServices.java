package data;

import org.springframework.beans.factory.annotation.Autowired;
import java.util.Optional;
import java.net.URL;

public class UserServices {

    public static String FAVORITE_NOTIFICATIONS = "FAVORITE";
    public static String COMMENT_NOTIFICATIONS = "COMMENT";
    public static String MESSAGE_NOTIFICATIONS = "MESSAGE";

    @Autowired
    UserRepository userRepository;

    public void signUp(String username, String password, String email){
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

        User user = new User(username, password_salt, password_hash, email);
        user.notification_settings.put(FAVORITE_NOTIFICATIONS, true);
        user.notification_settings.put(COMMENT_NOTIFICATIONS, true);
        user.notification_settings.put(MESSAGE_NOTIFICATIONS, true);
        userRepository.save(user);
    }

    public void signIn(String username, String password){
        User user = userRepository.findByName(username);

        if(user == null){
            System.out.println("User with given username doesn't exist.");
            return;
        }

        if(!Passwords.isExpectedPassword(password.toCharArray(), user.password_salt, user.password_hash)){
            System.out.println("Password is incorrect.");
            return;
        }

        //TODO rest of login
    }

    public void signOut(){
        //TODO
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

    public void setNotifications(String userID, String notificationType, boolean enabled){
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

    public String getTheme(String userID){
        Optional<User> optUser = userRepository.findById(userID);

        if(!optUser.isPresent()){
            System.out.println("User doesn't exist.");
            return;
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
}
