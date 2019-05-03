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
    <script type="text/javascript" src="lib/fabric.min.js"></script>
    <script type="text/javascript" src="js/all_comics.js"></script>
    <link rel="icon" type="image/png" href="pics/favicon.png" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-grid.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/all_comics.css">
    <link rel="icon" href="/images/logo.png">

    <title>Orange Comics</title>
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
                        %><a class="nav-link" href="user_profile"><%=user%></a><%
                    }
                %>
            </li>
        </ul>
    </div>
</nav>
<div class="splash h-100">
    <div style="height: 5%;">
        <div style="width: 15%; height: 100%; float: left; margin-left: 10%; margin-right: 3%;">

        </div>
        <div style="width: 62%; height: 100%; margin-right: 10%;" id="genre_list">
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Horror</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Fantasy</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Romance</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Action</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Comedy</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Sci-Fi</button>
        </div>
    </div>

    <div style="height: 85%; display: flex">
        <div style="width: 15%; height: 100%; float: left; margin-left: 10%; margin-right: 3%; border-style: solid; border-color: #1d2124;" id="tag_list">
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Gore</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Animals</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Kid</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Love</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Fun</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Camera</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Boy</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Girl</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Robot</button>
            <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Baby</button>
        </div>
        <div style="width: 62%; height: 100%; margin-right: 10%; border-style: solid; border-color: #1d2124;">
            <div style="text-align: center; font-size: 30px">
                <div class="center">
                    <div class="bookshelf">
                        <div class="shelf">
                            <div class="row-1">
                                <div class="loc" id="group1">
                                    <div> <img class="sample" id= "recommended0" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended1" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended2" sample="magazine1"> </div>
                                </div>
                            </div>
                            <div class="row-2">
                                <div class="loc" id="group2">
                                    <div> <img class="sample" id= "recommended3" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended4" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended5" sample="magazine1"> </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bookshelf" style="float: right">
                        <div class="shelf">
                            <div class="row-1">
                                <div class="loc" id="group3">
                                    <div> <img class="sample" id= "recommended6" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended7" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended8" sample="magazine1"> </div>

                                </div>
                            </div>
                            <div class="row-2">
                                <div class="loc" id="group4">
                                    <div> <img class="sample" id= "recommended9" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended10" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended11" sample="magazine1"> </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bookshelf">
                        <div class="shelf">
                            <div class="row-1">
                                <div class="loc" id="group5">
                                    <div> <img class="sample" id= "recommended12" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended13" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended14" sample="magazine1"> </div>

                                </div>
                            </div>
                            <div class="row-2">
                                <div class="loc" id="group6">
                                    <div> <img class="sample" id= "recommended15" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended16" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended17" sample="magazine1"> </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bookshelf" style="float: right">
                        <div class="shelf">
                            <div class="row-1">
                                <div class="loc" id="group7">
                                    <div> <img class="sample" id= "recommended18" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended19" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended20" sample="magazine1"> </div>

                                </div>
                            </div>
                            <div class="row-2">
                                <div class="loc" id="group8">
                                    <div> <img class="sample" id= "recommended21" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended22" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended23" sample="magazine1"> </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Samples-->
                    <div class="samples">
                        <div class="bar">
                            <a class="icon quit"></a>
                        </div>
                        <div id="book-wrapper">
                            <div id="book-zoom"></div>
                        </div>
                        <div id="slider-bar" class="turnjs-slider">
                            <div id="slider"></div>
                        </div>

                    </div>

                    <!-- End samples -->

                </div>
                <div class="gradient"></div>
            </div>
        </div>

    </div>
</div>

<script>
    let chapterList = eval('('+'${allcomics_chapterList}'+')');
    let TitleList = [];
    let AuthorList = [];
    let coverPage;
    let pageLength;
    let chapter;
    let title;
    let author;

    if (TitleList != null && AuthorList != null) {
        <%
            ArrayList<String> TitleList = (ArrayList<String>) request.getAttribute("allcomics_TitleList");
            ArrayList<String> AuthorList = (ArrayList<String>) request.getAttribute("allcomics_AuthorList");
        %>

        <%for(int i=0;i<TitleList.size();i++){%>
        TitleList.push("<%= TitleList.get(i)%>");
        <%}%>

        <%for(int i=0;i<AuthorList.size();i++){%>
        AuthorList.push("<%= AuthorList.get(i)%>");
        <%}%>

        console.log(TitleList);
        console.log(AuthorList);

        $(document).ready(function(){
            for (let i = 0; i < 24; i++) {

                if (chapterList[i] != null){
                    console.log("in");
                    $('#recommended'+i).click(function() {
                        coverPage = chapterList[i][0];
                        pageLength = chapterList[i].length;
                        chapter = i;
                    });

                    let canvasTemp = new fabric.Canvas();
                    coverPage = chapterList[i][0];
                    canvasTemp.setWidth(461);
                    canvasTemp.setHeight(600);
                    canvasTemp = canvasTemp.loadFromJSON(coverPage);
                    let imgPath = canvasTemp.toDataURL();
                    $('#recommended'+i).attr('src', imgPath);
                    $('#recommended'+i).width(97);
                    $('#recommended'+i).height(125);
                }
                else {

                }

            }
        });
    }

</script>>

</body>
</html>