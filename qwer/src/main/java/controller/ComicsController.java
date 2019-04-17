package controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ComicsController {
    @RequestMapping(value = {"/save_draft"}, method = RequestMethod.POST)
    @ResponseBody
    public int saveDraftRequset(@RequestParam("jsonArray") String jsonString) {
        System.out.println(jsonString);
        JSONArray jsonArray = new JSONArray(jsonString);

        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            System.out.println(jsonObject);
            // save jsonArray to db
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
    public void createComicRequest(@RequestParam(value = "comic_name") String name) {
        // create comic in db
    }
}
