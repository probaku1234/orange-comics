package controller;

import model.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import springboot.database.UserServices;
import springboot.database.UserRepository;
import springboot.database.User;
import java.util.Random;

@Controller
public class SignupController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private JavaMailSender sender;

    @Value("${local.server.port}")
    private String serverPort;

    @RequestMapping(value = "/signupSubmit", method = RequestMethod.GET)
//    public ModelAndView signUpRequset(){
    public ModelAndView signUpRequset(@RequestParam("signup_id") String id, @RequestParam("signup_pw") String pwd,
                                      @RequestParam("e_mail") String email) {
        if (userRepository.findByName(id) == null) {
            userRepository.save(UserServices.signUp(id,pwd,email,activationCode,activationBoolean));
            System.out.println("If there is no error print before this sentence,sign up complete");
        }
        //Generate Random key for e mail verification
        String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        alphabet.charAt(random.nextInt(alphabet.length()));
        StringBuilder builder = new StringBuilder(20);

        for (int i = 0; i < 20; i++) {
            builder.append(alphabet.charAt(random.nextInt(alphabet.length())));
        }
        System.out.println("Key for email verification : "+builder.toString());


        //temp


        //Send mail to user
        String setTo = id;
        String text ="[Click the link below to verify it]"+
                      "http://localhost:8080/joinConfirm?signup_id="+signup_id+"&auth_key="+builder.toString();

        String subject = "[Orange Comics]E-mail Verification Request";
        Mail mail = new Mail(sender, setTo, text, subject);
        mail.sendMail();

        return new ModelAndView("index");
    }


    @RequestMapping(value = "/joinConfirm", method = RequestMethod.GET)
    public String email_verification(@RequestParam("auth_key") String auth_key,@RequestParam("signup_id") String signup_id){

        System.out.println("printed : When the user clicks url in their email");
        User user = userRepository.findByName(signup_id);
        if(user == null){
            System.out.println("Wrong user id while email verification");
        }else{
            if ( user.activationCode == auth_key && user.activateBoolean == false) {
                user.activateBoolean =true;
                System.out.println("User Account is activated");
            }
            if (user.activateBoolean == true) {
                System.out.println("User Account is already activated");
            }
        }

        return "redirect:/index";


    }


//    @RequestMapping(value = "/signup_id", method = RequestMethod.GET)
//    @ResponseBody
//    public int checkId(@RequestParam("signup_id") String id) {
//        if (userRepository.findByName(id) != null) {
//            return 1;
//        } else {
//            return 0;
//        }
//    }
}