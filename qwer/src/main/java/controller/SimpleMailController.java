package controller;


import model.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SimpleMailController {
    @Autowired
    private JavaMailSender sender;

    @RequestMapping("/sendMail")
    public String login() {

        String setTo = "yonghun.jeong@stonybrook.edu";
        String text = "hello";
        String subject = "subject";

        Mail mail = new Mail(sender, setTo, text, subject);
        mail.sendMail();
        return "login";
    }
}