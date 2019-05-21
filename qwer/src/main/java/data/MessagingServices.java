package data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Optional;
import java.net.URL;

@Component
public class MessagingServices {

    @Autowired
    CommentRepository commentRepository;

    @Autowired
    MessageGroupRepository messageGroupRepository;

    @Autowired
    UserServices userServices;

    public void postComment(String userID, String comicID, String message){
        Comment comment = new Comment(userID, message, new Date());
        comment.setComic(comicID);
        commentRepository.save(comment);
    }

    public void deleteComment(String commentID){
        commentRepository.deleteById(commentID);
    }

    public void sendMessage(String fromUserID, String toUserID, String message){
        ArrayList<String> users = new ArrayList<>();
        users.add(fromUserID);
        users.add(toUserID);
        Collections.sort(users);//add sort to prevent from making 2 rooms for 2 users
        MessageGroup messageGroup = messageGroupRepository.findByUsers(users);
        if(messageGroup == null){
            messageGroup = new MessageGroup(users);
            messageGroupRepository.save(messageGroup);
        }
        Comment comment = new Comment(fromUserID, message, new Date());
        comment.setMessageGroup(messageGroup.id);
        commentRepository.save(comment);
        messageGroup.lastMessage = comment.datePosted;
        messageGroupRepository.save(messageGroup);

        System.out.println(toUserID);
        System.out.println(message);


        userServices.addNotification(toUserID, "MESSAGE", message);

    }

    public ArrayList<Comment> getComments(String comicID, int amount, int page){
        Page<Comment> comments = commentRepository.findByComic(comicID,
                PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "datePosted")));
        return new ArrayList<>(comments.getContent());
    }

    public ArrayList<MessageGroup> getMessageGroups(String userID, int amount, int page){
        Page<MessageGroup> groups = messageGroupRepository.findByUsersContaining(userID,
                PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "lastMessage")));
        return new ArrayList<>(groups.getContent());
    }

    public ArrayList<Comment> getMessages(String messageGroupID, int amount, int page){
        Page<Comment> comments = commentRepository.findByMessageGroup(messageGroupID,
                PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "datePosted")));
        return new ArrayList<>(comments.getContent());
    }
}
