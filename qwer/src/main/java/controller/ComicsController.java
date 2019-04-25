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
import java.util.Date;
import java.util.List;

@Controller
public class ComicsController {
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private UserServices userServices;
    @Autowired
    private ComicRepository comicRepository;
    final String baseURL = "http://orangecomics.herokuapp.com";

    @RequestMapping(value = {"/save_draft"}, method = RequestMethod.POST)
    @ResponseBody
    public int saveDraftRequset(@RequestParam("jsonArray") String jsonString, @RequestParam(value = "comic_name") String title, @RequestParam(value = "chapter") int chapterIndex, HttpSession session) throws MalformedURLException  {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        JSONArray jsonArray = new JSONArray(jsonString);
        ArrayList<String> pages = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            pages.add(jsonObject.toString());
            System.out.println(jsonObject);
        }

        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                ArrayList<String> chapterIds = comicServices.getChapters(comic.id);
                comicServices.updatePages(chapterIds.get(chapterIndex-1), comic.id, userId, pages);
                break;
            }
        }

        return 1;
    }

    @RequestMapping(value = {"/post_request"}, method = RequestMethod.POST)
    @ResponseBody
    public int PostRequest(@RequestParam("jsonArray") String jsonString, @RequestParam(value = "comic_name") String title, @RequestParam(value = "chapter") int chapterIndex, HttpSession session) throws MalformedURLException  {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        JSONArray jsonArray = new JSONArray(jsonString);
        ArrayList<String> pages = new ArrayList<>();
        boolean ChapterExist = false;
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            pages.add(jsonObject.toString());
        }
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));

        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                ArrayList<String> chapterIds = comicServices.getChapters(comic.id);
                comicServices.publishChapter(chapterIds.get(chapterIndex),comic.id, userId);
                ChapterExist = true;
                System.out.println("[In draft] chapter is published");
                break;
            }
        }
        if(ChapterExist ==false) {
            System.out.println("Comic was not made yet");
        }
        return 1;
    }

    @RequestMapping(value = {"/load_draft"}, method = RequestMethod.POST)
    @ResponseBody
    public ArrayList<String> loadDraftRequset(@RequestParam(value = "comic_name") String title, @RequestParam(value = "chapter") int chapter, HttpSession session) {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                ArrayList<String> pages = comicServices.getPages(comic.chapters.get(chapter-1),comic.id);
                return pages;
            }
        }
        return null;
    }

    @RequestMapping(value = {"/create_comic"}, method = RequestMethod.POST)
    public void createComicRequest(@RequestParam(value = "comic_name") String title, HttpSession session) throws MalformedURLException {
        // create comic in db
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        URL url = new URL(baseURL + title);
        comicServices.createComic(title, userId, url, "UNLISTED");
    }

    @RequestMapping(value = {"/create_chapter"}, method = RequestMethod.POST)
    @ResponseBody
    public int createChapterRequset(@RequestParam(value = "comic_name") String title, HttpSession session) throws MalformedURLException{
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));

        //comicServices.createChapter();
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                URL url = new URL(baseURL+title+"/" + comicServices.getChapters(comic.id).size()+1);
                comicServices.createChapter(comic.id, userId, url);
                return 1;
            }
        }
        return 0;
    }

    @RequestMapping(value = {"/get_comic_list"}, method = RequestMethod.POST)
    @ResponseBody
    public ArrayList<Comic> getComicListRequset(HttpSession session) {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        return comics;
    }

    @RequestMapping(value = {"/get_chapter_list"}, method = RequestMethod.POST)
    @ResponseBody
    public ArrayList<String> getChapterListRequest(@RequestParam(value = "comic_name") String title ,HttpSession session) {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                ArrayList<String> chapterIdList = comicServices.getChapters(comic.id);
                return chapterIdList;
            }
        }
        return null;
    }
}
