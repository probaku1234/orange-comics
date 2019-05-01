package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SearchController {
    @RequestMapping(value = {"/search_result"}, method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView searchRequset(@RequestParam(value = "keyword") String keyword) {
        System.out.println(keyword);
        ModelAndView modelAndView = new ModelAndView("search_result");
        modelAndView.addObject("keyword",keyword);
        // search comics by keyword
        // add attribute
        return modelAndView;
    }
}
