package controller;

import data.*;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String messages(Map<String, Object> model) {
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
