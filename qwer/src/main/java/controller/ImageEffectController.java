package controller;

import data.UserRepository;
import data.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;
import java.util.Random;

@Controller
public class ImageEffectController {

    @RequestMapping("/ImageEffect")
    public String messages(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "ImageEffect";
    }
    @RequestMapping("/ImageEffect2")
    public String messages2(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "ImageEffect2";
    }
}