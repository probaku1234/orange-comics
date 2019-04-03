package controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class WelcomeController {
    @RequestMapping("/index")
    public String index(Map<String, Object> model) {
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
