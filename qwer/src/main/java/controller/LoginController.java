package controller;

import data.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Optional;

@Controller
public class LoginController {
    @Autowired
    private UserServices usrServices;
    @Autowired
    ChapterRepository chapterRepository;
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private UserServices userServices;

    @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
    @ResponseBody
    public int loginRequest(@RequestParam("login_username") String username, @RequestParam("login_password") String password, HttpSession session, HttpServletResponse response) throws IOException {
        int result = usrServices.signIn(username, password);
        if (result == 0)
            return 0;
        else {
            session.setAttribute("user", username);
            //response.sendRedirect("/index");
            return 1;
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public ModelAndView logoutRequest(HttpSession session) {
        session.removeAttribute("user");
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
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("chapterList", chapterList);
        modelAndView.addObject("TitleList", TitleList);
        modelAndView.addObject("AuthorList", AuthorList);
        modelAndView.addObject("chapterIds", chapterIds);
        return modelAndView;
    }
}
