package data;

import org.springframework.beans.factory.annotation.Autowired;
import java.util.Optional;

public class UserServices {

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
}
