package controller;

import com.google.gson.Gson;
import data.*;
import model.Greeting;
import model.HelloMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Map;

@Controller
public class GreetingController {

    @Autowired
    private UserServices userServices;

    @Autowired
    MessagingServices messagingServices;

    @Autowired
    private UserRepository userRepository;


    @MessageMapping("/hello")
    @SendTo("/topic/greetings/")
    public Greeting greeting(HelloMessage message) throws Exception {
        System.out.println("greetingController");
        Thread.sleep(1000); // simulated delay
        System.out.println(message);

        System.out.println(message.getName());
        System.out.println(message.getUser2());

        User sender = userRepository.findByName(HtmlUtils.htmlEscape(message.getName()));
        User rec = userRepository.findByName(HtmlUtils.htmlEscape(message.getUser2()));
        String msg = HtmlUtils.htmlEscape(message.getMessage());

        if(sender ==null || rec == null){
            return new Greeting("false input");
        }
        messagingServices.sendMessage(sender.id,rec.id,msg);

        return new Greeting(sender.name, rec.name, msg);

    }






    @RequestMapping("/hallo")
    public String login(Map<String, Object> model) {
        model.put("message", "You are in new page !!");
        return "index1";
    }

    public int firstMsg(@RequestParam("user2") String user2, @RequestParam("message") String message, HttpSession session) {

        return 1;
    }



    @RequestMapping(value = {"/msgGroupId"}, method = RequestMethod.POST)
    @ResponseBody
    public String loginRequest(@RequestParam("msgGroupId") String msgGroupId, HttpSession session, HttpServletResponse response) throws IOException {
        ArrayList<Comment> comments= messagingServices.getMessages(msgGroupId , 50, 0);
        System.out.println(comments);
        for(int i=0;i<comments.size();i++){
            String user_name = userServices.getUsername(comments.get(i).user);
            comments.get(i).user = user_name;
        }

        String json = new Gson().toJson(comments);


        return json;
    }
    @RequestMapping(value = {"/removeMsg"}, method = RequestMethod.POST)
    @ResponseBody
    public String removeMsgRequest(@RequestParam("msgId") String msgId, HttpSession session, HttpServletResponse response) throws IOException {
        messagingServices.deleteComment(msgId);
        System.out.println("message hi");

        return "succ";
    }

}