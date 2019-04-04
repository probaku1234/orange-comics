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
    public int loginRequest(@RequestParam("login_id") String uname, @RequestParam("login_pw") String psw, HttpSession session) {
        User user = userRepository.findByName(uname);
        if (user != null) {
            if (Passwords.isExpectedPassword(psw.toCharArray(), user.password_salt, user.password_hash)) {
                session.setAttribute("user", uname);
                return 0;
            } else {
                return 1;
            }
        }else {
            return 2;
        }

    }
}
