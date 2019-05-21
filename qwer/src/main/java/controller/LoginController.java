package controller;

import data.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {
    @Autowired
    private UserServices usrServices;

    @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
    @ResponseBody
    public int loginRequest(@RequestParam("login_username") String username, @RequestParam("login_password") String password, HttpSession session, HttpServletResponse response) throws IOException {
        int result = usrServices.signIn(username, password);
        if (result == 0)
            return 0;
        else {
            session.setAttribute("user", username);
            //response.sendRedirect("/index");
            return 1;
        }
    }

    public String logoutRequest(HttpSession session) {
        session.removeAttribute("user");
        return "index";
    }
}
