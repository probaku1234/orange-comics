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
    <script>
        let chapterList;
        let TitleList = [];
        let AuthorList = [];
        let coverPage;
        let pageLength;
        let chapter;
        let title;
        let author;
        let pageSize = parseInt(${page_number});
        let currentSubPageIndex = 0;
        let maxSubPageIndex = parseInt(pageSize / 10);
        console.log(maxSubPageIndex);

        if (TitleList != null && AuthorList != null) {


            function generateThumbnail() {
                chapterList = eval('('+'${allcomics_chapterList}'+')')
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

                for (let i = 0; i < 12; i++) {

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
                }
            }

            $(document).ready(function(){
                function createPageNavigationNumbers(length, sub_index) {
                    for (var i = 0; i < length; i++) {
                        $('#page_navigation').append("<li class=\"page-item number\"><a class=\"page-link\" href=\"#\">"+ (i + 1 + 10*sub_index)+ "</a></li>");
                    }
                    $('#page_navigation').append("<li class=\"page-item next\"><a class=\"page-link\" href=\"#\">Next</a></li>");
                }



                if (pageSize > 10) {
                    createPageNavigationNumbers(10, 0);
                } else {
                    createPageNavigationNumbers(pageSize, 0);
                }
                generateThumbnail();

                $(document).on("click", "#page_navigation li a", function () {
                    var count = $("#page_navigation li").length;
                    if ($(this).parent().index() == 0) {
                        if (currentSubPageIndex > 0) {
                            $(".page-item number").remove();
                            $('.page-item next').remove();
                            currentSubPageIndex -= 1;
                            createPageNavigationNumbers(10, currentSubPageIndex);
                        }
                        $(this).parent().children().eq(1).trigger("click");
                    } else if ($(this).parent().index() == count -1) {
                        if (currentSubPageIndex < maxSubPageIndex) {
                            currentSubPageIndex += 1;
                            if (currentSubPageIndex == maxSubPageIndex) {
                                createPageNavigationNumbers(pageSize - 10 * currentSubPageIndex, currentSubPageIndex);
                            } else {
                                createPageNavigationNumbers(10, currentSubPageIndex);
                            }
                        }
                        $(this).parent().children().eq(1).trigger("click");
                    } else {
                        if (!$(this).parent().hasClass("active")) {
                            $('.page-item number').removeClass('active');
                            $(this).parent().addClass('active');
                            $.ajax({
                                type:"post",
                                url: "/page_number_request",
                                data: {
                                    "page_number" : $(this).text()
                                },
                                dataType:'json',
                                success : function(data) {
                                    console.log(data);
                                    generateThumbnail();
                                }
                            });
                        }
                    }
                })
            });
        }

    </script>
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
<nav class="navbar navbar-expand-lg navbar-dark bg-white sticky-top top-nav-font-style">
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
            <input class="form-control mr-sm-2 top-nav-search-bar" type="search" placeholder="Search" aria-label="Search" name="keyword">
            <button class="btn btn-outline-success my-2 my-sm-0 top-nav-search-button" type="submit"><i class="fas fa-search"></i></button>
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
<div class="page-header"> All Comics </div>
<div class="splash h-100">
    <nav style="width:15%; height:100%; margin-top: 1px; float:left;">
        <div id="left-tab"  style="width: 100%;  position: relative; z-index:100;">
            <a id="genre-tab" href="#" class="btn btn-primary btn-sm active genre" role="button"  aria-pressed="true" style="float:left; font-size:20px; font-weight: 400; border:none; width: 50%; background-color: #f39c12;">genre</a>
            <a id="tag-tab" href="#" class="btn btn-primary btn-sm active tag" role="button" aria-pressed="true" style="float:right; font-size:20px; font-weight: 400; border:none;width: 50%; background-color: #ffc107;">tag</a>
        </div>
        <div id="left-items" style=" width:100%; height: 100%; position: relative;">
            <div id="genre_list" class="genre" style=" width:100%; height: 100%; position: relative; float:left; z-index: 200; background: #f39c12;">
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Horror</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Fantasy</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Romance</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Action</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Comedy</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Sci-Fi</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Superhero</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Erotic</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Gore</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Mystery</button>
            </div>
            <div id="tag_list" class="tag" style=" width:100%; height:100%; position: relative; float:left; z-index: 200; display:none; background: #f39c12;">
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
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Crime</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Zombie</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Steampunk</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Suspense</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Vampire</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">School Life</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Martial Arts</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Mature</button>
                <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 47%; margin-top: 4px; margin-left: 0px; margin-right: 4px">Leading Ladies</button>
            </div>
        </div>
    </nav>
    <div style="height: 85%; display: flex;">
        <div style="width: 100%; height: 100%;">
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
                            <div class="h-10"></div>
                            <div class="row-2">
                                <div class="loc" id="group2">
                                    <div> <img class="sample" id= "recommended3" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended4" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended5" sample="magazine1"> </div>
                                </div>
                            </div>
                            <div class="h-10"></div>
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
                            <div class="h-10"></div>
                            <div class="row-2">
                                <div class="loc" id="group4">
                                    <div> <img class="sample" id= "recommended9" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended10" sample="magazine1"> </div>
                                    <div> <img class="sample" id= "recommended11" sample="magazine1"> </div>
                                </div>
                            </div>
                            <div class="h-10"></div>
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
            <nav aria-label="Page navigation example">
                <ul class="pagination" id="page_navigation">
                    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                </ul>
            </nav>
        </div>

    </div>
</div>



</body>
</html>