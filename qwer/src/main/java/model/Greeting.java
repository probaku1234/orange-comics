package model;

public class Greeting {

    private String content;
    private String sender;
    private String receiver;

    public void setContent(String content) {
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }
    public Greeting() {
    }

    public Greeting(String content) {

        this.content = content;
    }
    public Greeting(String sender,String receiver,String content) {

        this.content = content;
        this.sender = sender;
        this.receiver = receiver;

    }
    public String getContent() {
        return content;
    }

}