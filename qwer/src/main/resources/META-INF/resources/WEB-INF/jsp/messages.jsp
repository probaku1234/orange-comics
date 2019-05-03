<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta name="viewport" content="width=1200" />
    <meta name="keywords" content="page,flip,pages,effect,flipbook,flipboard,jquery,html5,book,magazine,newspaper,ipad,iphone,android,ios" />
    <meta name="description" content="Turn.js makes a beautiful page turning effect using HTML5 and jQuery" />
    <link type="text/css" rel="stylesheet" href="css/jquery.ui.css">
    <link type="text/css" rel="stylesheet" href="css/default.css">
    <script src="jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js'></script>
    <script type="text/javascript" src='bootstrap/js/bootstrap.min.js'></script>
    <script type="text/javascript" src="extras/all.js"></script>
    <script type="text/javascript" src="lib/hash.js"></script>
    <script type="text/javascript" src="lib/turn.min.js"></script>
    <script type="text/javascript" src="lib/zoom.min.js"></script>
    <script type="text/javascript" src="lib/bookshelf.js"></script>


<%--    <spring:url value="extras/all.js" var="mainJs" />--%>
<%--    <script src="${mainJs}"></script>--%>



    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>



<%--    <spring:url value="js/message.js" var="amainJs" />--%>
<%--    <script src="${amainJs}"></script>--%>

    <link rel="icon" type="image/png" href="pics/favicon.png" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-grid.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/messages.css">
    <link rel="icon" href="/images/logo.png">


    <script type="text/javascript" src="app.js"></script>
    <script type="text/javascript" src="js/message.js"></script>
    <title>Orange Comics</title>
    <%
        if (session.getAttribute("user") == null) {
            %><jsp:forward page="login.jsp"></jsp:forward><%
        }
    %>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-white sticky-top">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse no_padding_margin nav_left_margin" id="navbarTogglerDemo01">
        <a class="navbar-brand no_padding_margin" href="index">
            <img src="/images/logo2.png" width="150" alt="">
        </a>
        <p class="nav_logo_indent"></p>
        <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
            <li class="nav-item nav_list_indent">
                <a class="nav-link" href="all_comics">All Comics</a>
            </li>
            <li class="nav-item nav_list_indent">
                <a class="nav-link" href="draw_comics">Post Comics</a>
            </li>
            <li class="nav-item nav_list_indent">
                <a class="nav-link" href="my_favorites">My Favorites</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0 nav_list_indent" action="search_result" method="get">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="keyword">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <ul class="navbar-nav mr-10 mt-2 mt-lg-0 nav_right_margin">
            <li class="nav-item">
                <a class="nav-link" href="messages">Messages</a>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Notification (3)
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="notifications">notification 1</a>
                    <a class="dropdown-item" href="notifications">notification 2</a>
                    <a class="dropdown-item" href="notifications">notification 3</a>
                </div>
            </li>
            <li class="nav-item">
                <%
                    if (session.getAttribute("user") == null) {
                        %><a class="nav-link" href="login">Log In</a><%
                    } else {
                        String user = (String)session.getAttribute("user");
                        %><a class="nav-link" id="user_id"><%=user%></a><%
                    }
                %>
            </li>
        </ul>
    </div>
</nav>
<div class="splash h-92">
    <div style="height: 10%">
        To : <input type="text" id="_user2">
        Content : <input type="text" id="_contents">
        <button id="_msgBtn">Send</button>
    </div>
    <div class="container">
        <div class="messaging">
            <div class="inbox_msg">
                <div class="inbox_people">
                    <div class="headind_srch">
                        <div class="recent_heading">

                            <%
                                ArrayList<String> msgGroupId = (ArrayList<String>) request.getAttribute("msgGroupId");
                                ArrayList<String> UserName = (ArrayList<String>) request.getAttribute("UserName");
                                ArrayList<String> lastMsg = (ArrayList<String>) request.getAttribute("lastMsg");

                            %>

                        </div>
                        <div class="srch_bar">
                            <div class="stylish-input-group">
                                <input type="text" class="search-bar"  placeholder="Search" >
                                <span class="input-group-addon">
                <button type="button"> <i class="fa fa-search" aria-hidden="true"></i> </button>
                </span> </div>
                        </div>
                    </div>
                    <div class="inbox_chat" id="inbox_chat">
                        <div class="chat_list active_chat">
                            <div class="chat_people">
                                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>
                                <div class="chat_ib">
                                    <h5>Kyung Chul Cho <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mesgs">
                    <div class="msg_history" id="id_msg_history" name="">
                        <div class="incoming_msg">
                            <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>
                            <div class="received_msg">
                                <div class="received_withd_msg">
                                    <p>Test which is a new approach to have all
                                        solutions</p>
                                    <span class="time_date"> 11:01 AM    |    June 9</span></div>
                            </div>
                        </div>
                        <div class="outgoing_msg">
                            <div class="sent_msg">
                                <p>Test which is a new approach to have all
                                    solutions</p>
                                <span class="time_date"> 11:01 AM    |    June 9</span> </div>
                        </div>
                        <div class="incoming_msg">
                            <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>
                            <div class="received_msg">
                                <div class="received_withd_msg">
                                    <p>Test, which is a new approach to have</p>
                                    <span class="time_date"> 11:01 AM    |    Yesterday</span></div>
                            </div>
                        </div>
                        <div class="outgoing_msg">
                            <div class="sent_msg">
                                <p>Apollo University, Delhi, India Test</p>
                                <span class="time_date"> 11:01 AM    |    Today</span> </div>
                        </div>
                        <div class="incoming_msg">
                            <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>
                            <div class="received_msg">
                                <div class="received_withd_msg">
                                    <p>We work directly with our designers and suppliers,
                                        and sell direct to you, which means quality, exclusive
                                        products, at a price anyone can afford.</p>
                                    <span class="time_date"> 11:01 AM    |    Today</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="type_msg">
                        <div class="input_msg_write">
                            <input id = "input_msg_write" type="text" class="write_msg" placeholder="Type a message" />
                            <button id= "input_msg_btn" class="msg_send_btn" type="button">Send</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    var msgGroupId = [];
    var UserName = [];
    var lastMsg = [];
    <%for(int i=0;i<msgGroupId.size();i++){%>
    msgGroupId.push("<%= msgGroupId.get(i)%>");<%}%>
    <%for(int i=0;i<UserName.size();i++){%>
    UserName.push("<%= UserName.get(i)%>");<%}%>
    <%for(int i=0;i<lastMsg.size();i++){%>
    lastMsg.push("<%= lastMsg.get(i)%>");<%}%>

    for(let i=0;i<msgGroupId.length;i++) {


        $('#inbox_chat').append(
            '<a href="#"  id=inbox_list_id'+i+'>'+
            `<div class="inbox_list_class chat_list active_chat"> ` +
                `<div class="chat_people"> ` +
                    `<div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>` +
                    `<div class="chat_ib">` +
                        ' <h5>'+UserName[i]+'<span class="chat_date">May 3</span></h5>' +
                        '<p>'+lastMsg[i]+'</p><span class="msgGroupId" hidden>'+msgGroupId[i]+'</span>'+
                    `</div>` +
                `</div>` +
            '</div>'+'</a>');
    }
</script>
</html>