package controller;

import data.*;
import model.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
//import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import data.UserServices;
import data.UserRepository;

import java.util.ArrayList;
import java.util.Optional;
import java.util.Random;

@Controller
public class SignupController {
    @Autowired
    private UserRepository userRepository;
    //@Autowired
    //private JavaMailSender sender;
    @Autowired
    private UserServices usrServices;
    @Autowired
    ChapterRepository chapterRepository;
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private UserServices userServices;

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView signUpRequset(@RequestParam("signup_username") String id, @RequestParam("signup_password") String pwd,
                                      @RequestParam("signup_email") String email) {

        //Generate Random key for e mail verification
        String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        alphabet.charAt(random.nextInt(alphabet.length()));
        StringBuilder builder = new StringBuilder(20);

        for (int i = 0; i < 20; i++) {
            builder.append(alphabet.charAt(random.nextInt(alphabet.length())));
        }
        System.out.println("Key for email verification : "+builder.toString());

        //save data
        if (userRepository.findByName(id) == null) {
            usrServices.signUp(id, pwd, email, builder.toString());
            System.out.println("If there is no error print before this sentence,sign up complete");
        }

        ArrayList<Comic> comics = comicServices.getRecentComics(12, 0);
        ArrayList<String> chapterIds = new ArrayList<>();
        ArrayList<ArrayList<String> > chapterList = new ArrayList< >();
        ArrayList<String> AuthorList = new ArrayList<>();
        ArrayList<String> TitleList = new ArrayList<>();
//        ArrayList<String> idList = new ArrayList<>();
        for(int i = 0; i < comics.size(); i++) {
            for(int j = 0; j < comics.get(i).chapters.size(); j++) {

                Optional<Chapter> optChapter = chapterRepository.findById(comics.get(i).chapters.get(j));
                Chapter chapter = optChapter.get();

                if(chapter.isDraft == false){
                    String chapterId = comics.get(i).chapters.get(j);
                    chapterIds.add(Integer.toString(comics.get(i).chapters.indexOf(chapterId) + 1));
                    ArrayList<String> pages = comicServices.getPages(comics.get(i).chapters.get(j),comics.get(i).id);

                    chapterList.add(pages);
                    TitleList.add(comics.get(i).title);
                    AuthorList.add(userServices.getUsername(comics.get(i).author));
//                    idList.add(comics.get(i).id);
                }
            }
        }
        //Send mail to user
        /*
        String setTo = email;
        String text ="[Click the link below to verify it]"+
                      "http://localhost:8080/joinConfirm?signup_id="+id+"&activationCode="+builder.toString();

        String subject = "[Orange Comics]E-mail Verification Request";
        Mail mail = new Mail(sender, setTo, text, subject);
        mail.sendMail();
        */
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("chapterList", chapterList);
        modelAndView.addObject("TitleList", TitleList);
        modelAndView.addObject("AuthorList", AuthorList);
        modelAndView.addObject("chapterIds", chapterIds);
        return modelAndView;
    }

    /*
    @RequestMapping(value = "/joinConfirm", method = RequestMethod.GET)
    public String email_verification(@RequestParam("activationCode") String activationCode,@RequestParam("signup_id") String signup_id){

        System.out.println("printed : When the user clicks url in their email");
        User user = userRepository.findByName(signup_id);
        if(user == null){
            System.out.println("Wrong user id while email verification");
        }else{
            if ( user.activationCode == activationCode && user.activated == false) {
                user.activated =true;
                System.out.println("User Account is activated");
            }
            if (user.activated == true) {
                System.out.println("User Account is already activated");
            }
            System.out.println("you are here");
        }

        return "redirect:/index";


    }
    */

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