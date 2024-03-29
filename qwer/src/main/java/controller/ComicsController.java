package controller;

import data.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

@Controller
public class ComicsController {
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private UserServices userServices;
    @Autowired
    private ComicRepository comicRepository;
    @Autowired
    private ChapterRepository chapterRepository;

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
                comicServices.publishChapter(chapterIds.get(chapterIndex-1),comic.id, userId);
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
    @ResponseBody
    public int createComicRequest(@RequestParam(value = "comic_name") String title, HttpSession session) throws MalformedURLException {
        // create comic in db
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        URL url = new URL(baseURL + title);
        comicServices.createComic(title, userId, url, "PUBLIC");
        return 1;
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
        return 1;
    }

    @RequestMapping(value = {"/get_comic_list", "/get_user_comic_list"}, method = RequestMethod.POST)
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

    @RequestMapping(value = "/get_comic_list_by_tags_and_genres", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getComicsListByTagsRequest(@RequestParam(value = "tags[]") ArrayList<String> tags, @RequestParam(value = "genres[]") ArrayList<String> genres, Model model) {
        System.out.println(tags);
        ArrayList<Comic> comics = comicServices.advancedComicSearch("NEW", 12, 0, tags, genres);
        Map<String, Object> map = new HashMap<>();
        ArrayList<String> chapterIds = new ArrayList<>();
        ArrayList<ArrayList<String> > chapterList = new ArrayList< >();
        ArrayList<String> AuthorList = new ArrayList<>();
        ArrayList<String> TitleList = new ArrayList<>();

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

        model.addAttribute("allcomics_chapterList", chapterList);
        model.addAttribute("allcomics_TitleList", TitleList);
        model.addAttribute("allcomics_AuthorList", AuthorList);
        model.addAttribute("allcomics_chapterIds", chapterIds);

        map.put("allcomics_chapterList", chapterList);
        map.put("allcomics_TitleList", TitleList);
        map.put("allcomics_AuthorList", AuthorList);
        map.put("allcomics_chapterIds", chapterIds);
        return map;
    }

    @RequestMapping(value = "/add_tags_and_genres", method = RequestMethod.POST)
    @ResponseBody
    public int addTagAndGenreRequest(@RequestParam(value = "tags[]") ArrayList<String> tags, @RequestParam(value = "genres[]") ArrayList<String> genres, @RequestParam(value = "title") String title, HttpSession session) {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                comicServices.updateGenress(comic.id, userId, genres);
                comicServices.updateTags(comic.id, userId, tags);
                return 1;
            }
        }
        return 1;
    }

    @RequestMapping(value = "/page_number_request", method = RequestMethod.POST)
    @ResponseBody
    public int getComicListByPageIndex(@RequestParam(value = "page_number") int pageIndex ,Model _model) {
        ArrayList<Comic> comics = comicServices.getRecentComics(12, pageIndex-1);
        ArrayList<String> chapterIds = new ArrayList<>();
        ArrayList<ArrayList<String> > chapterList = new ArrayList< >();
        ArrayList<String> AuthorList = new ArrayList<>();
        ArrayList<String> TitleList = new ArrayList<>();

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

        _model.addAttribute("allcomics_chapterList", chapterList);
        _model.addAttribute("allcomics_TitleList", TitleList);
        _model.addAttribute("allcomics_AuthorList", AuthorList);
        return pageIndex;
    }
}
