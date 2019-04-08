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
//import springboot.database.Passwords;
//import springboot.database.UserRepository;

@Controller
public class SignupController {
//    @Autowired
//    private UserRepository userRepository;
    @Autowired
    private JavaMailSender sender;


    @RequestMapping(value = "/signupSubmit", method = RequestMethod.GET)
    public ModelAndView signUpRequset() {
//    public ModelAndView signUpRequset(@RequestParam("signup_id") String id, @RequestParam("signup_pw") String pwd) {
//        if (userRepository.findByName(id) == null) {
//            System.out.println("sign up complete");
//            userRepository.save(Passwords.createUser(id,pwd));
//        }

        String setTo = "yonghun.jeong@stonybrook.edu";
        String text = "hello";
        String subject = "subject";

        Mail mail = new Mail(sender, setTo, text, subject);
        mail.sendMail();



        return new ModelAndView("index");
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