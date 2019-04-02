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
}
