package controller;

import data.Comic;
import data.ComicRepository;
import data.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
public class AuthorProfileController {
    @Autowired
    private ComicRepository comicRepository;
    @Autowired
    private UserServices userServices;

    @RequestMapping(value = "/get_author_comic_list", method = RequestMethod.POST)
    public ArrayList<Comic> getAuthorComicListRequest(@RequestParam(value = "name") String name) {
        String userId = userServices.getIDbyUsername(name);
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        return comics;
    }
}
