package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
    @ResponseBody
    public int loginRequest(@RequestParam("login_username") String username, @RequestParam("login_password") String password, HttpSession session) {
        // UserSerVices service = new UserServices();
        // int result = service.signIn(username, password);
        // if (result == 0)
        // return 0
        // else
        // session.setAttribute("user", username);
        // move page to index r
        // return new ModelAndView("index");

        return 0;
    }
}
