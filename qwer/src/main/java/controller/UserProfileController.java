package controller;

import data.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Map;

@Controller
public class UserProfileController {
    @Autowired
    private UserServices userServices;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ComicServices comicServices;
    @Autowired
    private ComicRepository comicRepository;

    @RequestMapping("/user_profile")
    public ModelAndView user_profile(HttpSession session) {
        String userName = (String) session.getAttribute("user");
        String userId = userServices.getIDbyUsername(userName);
        ModelAndView mav = new ModelAndView("user_profile");
        mav.addObject("name", userName);
        mav.addObject("email", userRepository.findByName(userName).email);
        mav.addObject("description", userServices.getProfileDescription(userId));
        return mav;
    }

    @RequestMapping(value = "/user_profile", method = RequestMethod.POST)
    public void updateProfileRequset(@RequestParam(value = "newpass") String password, @RequestParam(value = "description") String description, HttpSession session) {
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));
        if (!password.equals("")) {
            userServices.changePassword(userId, password);
        }
        userServices.setProfileDescription(userId, description);
    }

    @RequestMapping(value = "/delete_selected_comic", method = RequestMethod.POST)
    public int deleteComicRequest(@RequestParam(value = "title") String title, HttpSession session) {
        // delete comic
        String userId = userServices.getIDbyUsername((String) session.getAttribute("user"));

        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userId));
        for (Comic comic : comics) {
            if (comic.title.equals(title)) {
                comicServices.deleteComic(comic.id, userId);
            }
        }
        return 1;
    }
}
