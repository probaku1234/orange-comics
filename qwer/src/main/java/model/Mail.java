package model;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

public class Mail {

    private String setTo;
    private String text;
    private String subject;
    private JavaMailSender sender;
    private MimeMessage message;
    private MimeMessageHelper helper;

    public Mail(JavaMailSender sender, String setTo, String text, String subject)
    {
        setSender(sender);
        setSetTo(setTo);
        setText(text);
        setSubject(subject);
        setMessage(sender.createMimeMessage());
        setHelper(new MimeMessageHelper(message));
    }


    public String getSetTo() {
        return setTo;
    }

    public void setSetTo(String setTo) {
        this.setTo = setTo;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public JavaMailSender getSender() {
        return sender;
    }

    public void setSender(JavaMailSender sender) {
        this.sender = sender;
    }
    public MimeMessage getMessage() {
        return message;
    }

    public void setMessage(MimeMessage message) {
        this.message = message;
    }

    public MimeMessageHelper getHelper() {
        return helper;
    }

    public void setHelper(MimeMessageHelper helper) {
        this.helper = helper;
    }




    public void sendMail() {

        try {
            helper.setTo(setTo);
            helper.setText(text);
            helper.setSubject(subject);
        } catch (MessagingException e) {
            e.printStackTrace();
//            return "Error while sending mail ..";
        }
        sender.send(message);
//        return "Mail Sent Success!";
    }
}
