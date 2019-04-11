package controller;

import data.UserServices;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
    @ResponseBody
    public Object loginRequest(@RequestParam("login_username") String username, @RequestParam("login_password") String password, HttpSession session) {
        UserServices service = new UserServices();
        int result = service.signIn(username, password);
        if (result == 0)
            return 0;
        else {
            session.setAttribute("user", username);
            return new ModelAndView("index");
        }
    }
}
