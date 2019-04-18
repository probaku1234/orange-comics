package controller;

import data.Comic;
import data.ComicRepository;
import data.ComicServices;
import data.UserServices;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ComicsController {
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private UserServices userServices;
    @Autowired
    private ComicRepository comicRepository;

    @RequestMapping(value = {"/save_draft"}, method = RequestMethod.POST)
    @ResponseBody
    public int saveDraftRequset(@RequestParam("jsonArray") String jsonString, String title, int chapterIndex, HttpSession session) throws MalformedURLException  {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        JSONArray jsonArray = new JSONArray(jsonString);
        ArrayList<String> pages = new ArrayList<>();
        URL url = new URL("/a-guide-to-java-sockets");

        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            pages.add(jsonObject.toString());
            System.out.println(jsonObject);
        }

        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                ArrayList<String> chapterIds = comicServices.getChapters(comic.id);
                comicServices.updatePages(chapterIds.get(chapterIndex), comic.id, userId, pages);
                break;
            }
        }

        return 1;
    }

    @RequestMapping(value = {"/load_draft"}, method = RequestMethod.POST)
    @ResponseBody
    public int loadDraftRequset(@RequestParam(value = "jsonArray[]", required = false) String[] jsonArray) {
        System.out.println(jsonArray);
        // save jsonArray to db
        return 1;
    }

    @RequestMapping(value = {"/create_comic"}, method = RequestMethod.POST)
    public void createComicRequest(@RequestParam(value = "comic_name") String title, HttpSession session) throws MalformedURLException {
        // create comic in db
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        URL url = new URL("/a-guide-to-java-sockets");
        comicServices.createComic(title, userId, url, "UNLISTED");
    }

    @RequestMapping(value = {"/create_chapter"}, method = RequestMethod.POST)
    public void createChapterRequset(String title, HttpSession session) throws MalformedURLException{
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        URL url = new URL("/a-guide-to-java-sockets");
        //comicServices.createChapter();
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                comicServices.createChapter(comic.id, userId, url);
                break;
            }
        }
    }
}
