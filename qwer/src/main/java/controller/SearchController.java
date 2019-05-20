package controller;

import data.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Optional;

@Controller
public class SearchController {
    @Autowired
    private ComicRepository comicRepository;
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private ChapterRepository chapterRepository;
    @Autowired
    private UserServices userServices;

    @RequestMapping(value = {"/search_result"}, method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView searchRequset(@RequestParam(value = "keyword") String keyword) {
        System.out.println(keyword);
        ArrayList<Comic> comics = comicServices.findComicsByTitle(keyword, 12, 0);
        ArrayList<String> chapterIds = new ArrayList<>();
        ArrayList<ArrayList<String> > chapterList = new ArrayList< >();
        ArrayList<String> authorList = new ArrayList<>();
        ArrayList<String> titleList = new ArrayList<>();

        for(int i = 0; i < comics.size(); i++) {
            for(int j = 0; j < comics.get(i).chapters.size(); j++) {

                Optional<Chapter> optChapter = chapterRepository.findById(comics.get(i).chapters.get(j));
                Chapter chapter = optChapter.get();

                if(chapter.isDraft == false){
                    chapterIds.add(comics.get(i).chapters.get(j));
                    ArrayList<String> pages = comicServices.getPages(comics.get(i).chapters.get(j),comics.get(i).id);

                    chapterList.add(pages);
                    titleList.add(comics.get(i).title);
                    authorList.add(userServices.getUsername(comics.get(i).author));
//                    idList.add(comics.get(i).id);
                }
            }
        }

        ModelAndView modelAndView = new ModelAndView("search_result");
        modelAndView.addObject("keyword",keyword);
        modelAndView.addObject("searchResult_TitleList", titleList);
        modelAndView.addObject("searchResult_AuthorList", authorList);
        modelAndView.addObject("searchResult_chapterList", chapterList);
        // search comics by keyword
        // add attribute
        return modelAndView;
    }
}
