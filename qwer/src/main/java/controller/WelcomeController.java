package controller;

import data.*;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Map;
import java.util.Optional;

@Controller
public class WelcomeController {

    @Autowired
    private ComicServices comicServices;
    @Autowired
    private UserServices userServices;
    @Autowired
    private ComicRepository comicRepository;
    @Autowired
    ChapterRepository chapterRepository;

    @Autowired
    MessagingServices messagingServices;


    final String baseURL = "http://orangecomics.herokuapp.com";


    @RequestMapping(value={"/index","/"})
    public String index(Map<String, Object> model, Model _model) {

        String userId = "5cafaeae0309f52d4420c7dc";//id=yong
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
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
                    chapterIds.add(comics.get(i).chapters.get(j));
                    ArrayList<String> pages = comicServices.getPages(comics.get(i).chapters.get(j),comics.get(i).id);
                        
                    chapterList.add(pages);
                    TitleList.add(comics.get(i).title);
                    AuthorList.add(userServices.getUsername(comics.get(i).author));
//                    idList.add(comics.get(i).id);
                }
            }
        }
        _model.addAttribute("chapterList", chapterList);
        _model.addAttribute("TitleList", TitleList);
        _model.addAttribute("AuthorList", AuthorList);
//        _model.addAttribute("idList", idList);



        model.put("message", "You are in new page !!");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "login";
    }

    @RequestMapping("/messages")
    public String messages(Map<String, Object> model, HttpSession session,Model _model) {

        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        String userName = userServices.getUsername(userId);
        ArrayList<MessageGroup> msgGroup = messagingServices.getMessageGroups(userId, 50, 0);
        ArrayList<String> lastMsg  = new ArrayList<>();
        ArrayList<String> UserName  = new ArrayList<>();
        ArrayList<String> Opponent  = new ArrayList<>();
        ArrayList<String> msgGroupId  = new ArrayList<>();

        for(int i=0;i<msgGroup.size();i++){// iterate message group for getting opponent name and last message
            ArrayList<Comment>  comments= messagingServices.getMessages(msgGroup.get(i).id , 50, 0);
            if(comments.size() >0) {
                String val = comments.get(0).message; // get recent messeage
                String post_userID = comments.get(0).user;
                String post_userNAME = userServices.getUsername(post_userID);

                ArrayList<String> users = msgGroup.get(i).users;
                if(users.get(0).equals(userId)){ //group first member vs login user
                    Opponent.add(userServices.getUsername(users.get(1)));
                }else{
                    Opponent.add(userServices.getUsername(users.get(0)));
                }
                lastMsg.add(val);
                UserName.add(post_userNAME);
                msgGroupId.add(msgGroup.get(i).id);
            }
        }
//        System.out.println(UserName);
//        System.out.println(lastMsg);

        _model.addAttribute("lastMsg", lastMsg);
        _model.addAttribute("UserName", UserName);
        _model.addAttribute("msgGroupId", msgGroupId);
        _model.addAttribute("Opponent", Opponent);


//        System.out.println(lastMsg);
//        messagingServices.getMessages(String messageGroupID, 1, 0)


        model.put("message", "You are in new page !!");
        return "messages";
    }








    @RequestMapping("/all_comics")
    public String all_comics(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "all_comics";
    }

    @RequestMapping("/my_favorites")
    public String my_favorites(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "my_favorites";
    }

    @RequestMapping("/draw_comics")
    public String draw_comics(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "draw_comics";
    }

    @RequestMapping("/search_result")
    public String search_result(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "search_result";
    }
}
