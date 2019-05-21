<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    if (session == null) {
        %><jsp:forward page="login.jsp"></jsp:forward><%
    } else {
        System.out.println(session);
    }
%>
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
    <script type="text/javascript" src="lib/hash.js"></script>
    <script type="text/javascript" src="lib/turn.min.js"></script>
    <script type="text/javascript" src="lib/zoom.min.js"></script>
    <script type="text/javascript" src="lib/bookshelf.js"></script>
    <script type="text/javascript" src="lib/fabric.min.js"></script>

    <script type="text/javascript" src="js/draw_comics.js"></script>
    <script type="text/javascript" src="js/ImageEffectHandling.js"></script>
    <script type="text/javascript" src="js/comics.js"></script>
    <script type="text/javascript" src="lib/imageBlending.js"></script>
    <script type="text/javascript" src="lib/blendings.js"></script>
    <script type="text/javascript" src="lib/jscolor.js"></script>

    <link rel="icon" type="image/png" href="pics/favicon.png" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-grid.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/draw_comics.css">
    <link rel="icon" href="/images/logo.png">

    <title>Orange Comics</title>
    <%
        if (session.getAttribute("user") == null) {
            %><jsp:forward page="login.jsp"></jsp:forward><%
        }
    %>
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
<div class="splash h-92">
    <div class="page-header"> Post Comics </div>
    <div class="d-flex justify-content-between flex-row align-items-stretch body-container">
        <%-- left tab bar --%>
        <div class="d-flex flex-row align-items-stretch body-container-inner">
            <div class="left-tabs-container">
                <div id="left-tabs-new" class="left-tabs">
                    New <i class="fas fa-chevron-right"></i>
                </div>
                <div id="left-tabs-load" class="left-tabs">
                    Load <i class="fas fa-chevron-right"></i>
                </div>
                <div id="left-tabs-save" class="left-tabs">
                    Save <i class="fas fa-chevron-right"></i>
                </div>
                <div id="left-tabs-post" class="left-tabs">
                    Post <i class="fas fa-chevron-right"></i>
                </div>
            </div>
            <div class="left-list-container" id="left-list-container">
                <div class="left-list-items" id="left-list-new">
                    <p class="left-list-item" style="padding-top: 40px; padding-bottom: 10px">Add a New Comic</p>
                    <p class="form-inline left-list-item" style="padding-bottom: 40px;">
                        <input class="form-control mr-sm-2" id="add-new-comic-input" type="search" placeholder="Enter the Title" aria-label="Search">
                        <button class="btn-sm btn-success my-2 my-sm-0 add-new-comic-button list-button" id="add-new-comic-button">
                            Add
                        </button>
                    </p>
                </div>
                <div class="left-list-items" id="left-list-load">
                    <p class="left-list-item" style="padding-top: 40px; padding-bottom: 15px">Load a Comic</p>
                    <div class="left-list-item list-block dropdown mr-auto mt-2 mt-lg-0">
                        <button class="btn btn-secondary dropdown-toggle list-button" type="button" id="dropdownComicListButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Comic Titles
                        </button>
                        <div id="comic_list" class="dropdown-menu" aria-labelledby="dropdownComicListButton">

                        </div>
                    </div>
                    <p class="left-list-item" style="padding-top: 0px; padding-bottom: 5px">Choose a Chapter</p>
                    <p class="left-list-item" style="padding-top: 0px; padding-bottom: 5px; padding-left: 100px">or</p>
                    <p class="left-list-item" style="padding-top: 0px; padding-bottom: 15px">Add a New Chapter</p>
                    <div class="form-inline left-list-item dropdown mr-auto mt-2 mt-lg-0" style="padding-bottom: 40px;">
                        <button class="btn btn-secondary dropdown-toggle list-button" type="button" id="dropdownChapterListButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Load Chapter
                        </button>
                        <div id="chapter_list" class="dropdown-menu" aria-labelledby="dropdownChapterListButton">

                        </div>
                        <button type="button" class="btn btn-secondary btn-sm list-button" id="new_chapter" style="margin-left: 20px">
                            New Chapter
                        </button>
                    </div>
                </div>
                <div class="left-list-items" id="left-list-save" style="padding-bottom: 40px; text-align: center;">
                    <p class="left-list-item" style="padding-top: 40px; padding-bottom: 5px">Do you really want to</p>
                    <p class="left-list-item" style="padding-bottom: 15px">save a comic?</p>
                    <button type="button" class="btn btn-success btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 60%;" id="save_button">
                        Save Draft
                    </button>
                </div>
                <div class="left-list-items" id="left-list-post" style="padding-bottom: 40px; text-align: center;">
                    <p class="left-list-item " style="padding-top: 40px; padding-bottom: 15px">Select Genres & Tags</p>
                    <button type="button" class="btn btn-success btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 60%;" data-toggle="modal" data-target="#exampleModal">
                        Add Genres & Tags
                    </button>
                    <p class="left-list-item" style="padding-top: 75px; padding-bottom: 5px">Do you really want to</p>
                    <p class="left-list-item" style="padding-bottom: 15px">post a comic?</p>
                    <button type="button" class="btn btn-success btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 60%;" id="post_button">Post Comic</button>
                </div>
            </div>
        </div>
        <%-- left tab bar --%>
        <div class="h-92">
            <div class="container container-width-limit">
                <ul class="nav nav-tabs nav-tabs-custom" role="tablist" id="tab">
                    <li class="nav-item">
                        <a class="nav-link active" href="#page1" data-toggle="tab" role="tab" aria-controls="home" aria-selected="true">Cover Page</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link add-page page-nav-link" href="#">+ Add</a>
                    </li>
                </ul>
                <div class="row" style="align-items: center; justify-content: center;">
                    <div class="col-sm">
                        <div class="row">
                            <div class="col-2 tabs-margin">
                                <div class="nav flex-column nav-pills" style="transform: scale(0.85, 1);" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                    <a class="nav-link active function-menu-tabs" id="v-pills-images-tab" data-toggle="pill" href="#v-pills-images" role="tab" aria-controls="v-pills-images" aria-selected="true">IMAGES</a>
                                    <a class="nav-link function-menu-tabs" id="v-pills-shapes-tab" data-toggle="pill" href="#v-pills-shapes" role="tab" aria-controls="v-pills-shapes" aria-selected="false">SHAPES</a>
                                    <a class="nav-link function-menu-tabs" id="v-pills-text-tab" data-toggle="pill" href="#v-pills-text" role="tab" aria-controls="v-pills-text" aria-selected="false">TEXT</a>
                                    <a class="nav-link function-menu-tabs" id="v-pills-cartoonize-tab" data-toggle="pill" href="#v-pills-cartoonize" role="tab" aria-controls="v-pills-cartoonize" aria-selected="false">CARTOONIZE</a>
                                    <a class="nav-link function-menu-tabs" id="v-pills-post-tab" data-toggle="pill" href="#v-pills-post" role="tab" aria-controls="v-pills-post" aria-selected="false">POST</a>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="tab-content" id="v-pills-tabContent">

                                    <div class="tab-pane fade show active" id="v-pills-images" role="tabpanel" aria-labelledby="v-pills-images-tab">
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Pre-made Characters
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton10" id="premade_images">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade1" href="#" style="padding:5px 5px">
                                                            <img width="30px" height="30px" src="https://www.pinclipart.com/picdir/big/91-910919_mule-clipart-shrek-character-donkey-from-shrek-png.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade2" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="https://www.pinclipart.com/picdir/big/202-2020508_shrek-face-png-shrek-pixel-art-maker-pixel.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade3" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="https://www.pinclipart.com/picdir/big/194-1949751_newest-version-of-pixel-art-maker-sans-clipart.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade4" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932658217304.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade5" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/61/13540113018988.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade6" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932662416551.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade7" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932670829054.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade8" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932677419173.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade9" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932657015284.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade10" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932666019343.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade11" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932668414295.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade12" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932658817069.png">
                                                            </a>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade13" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932700211017.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade14" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932664223023.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade15" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932649215024.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade16" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932697814193.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade17" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932645615835.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade18" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932688212001.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade19" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932684611250.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade20" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932664815276.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade21" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932634218307.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade22" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932622829846.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade23" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932613219416.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade24" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932606612912.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade25" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932641417567.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade26" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/83/13939161014804.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade27" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932607811463.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade28" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932672025948.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade29" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/100/13950199211486.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade30" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932639612165.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade31" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932639014891.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade32" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/60/13539934212140.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade33" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/65/13550874017348.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade34" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/1/13488914417662.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade35" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/53/13526767212422.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade36" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/1/13488673219292.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade37" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/113/13958583025224.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade38" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932291011199.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade39" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/51/13525719619719.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade40" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/55/13528019416469.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade41" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/52/13526095811713.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade42" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/52/13526245819001.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade43" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/83/13939368015951.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade44" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/55/13528267221867.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade45" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/93/13945504815093.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade46" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/17/13504596613288.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade47" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/17/13504552819340.png">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade48" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/60/13534727415379.png">
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a class="dropdown-item " value="add_premade49" href="#" style="padding:5px 5px">
                                                                <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/53/13526739613080.png">
                                                            </a>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>


                                                </table>

                                            </div>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <input type="file" id="myFile">
                                            <button class="btn btn-secondary" type="button" id="dropdownMenuButton11" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Add Image from URL
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton11">
                                                <input class="form-control mr-sm-2" id="addImageFromURL" type="search" placeholder="Enter the URL" aria-label="Search">
                                                <button class="btn btn-outline-success my-2 my-sm-0" id="addImageButton">Add</button>
                                            </div>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary" type="button" id="dropdownMenuButton12" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Add Background from URL
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton12">
                                                <input class="form-control mr-sm-2" id="addBackgroundFromURL" type="search" placeholder="Enter the URL" aria-label="Search">
                                                <button class="btn btn-outline-success my-2 my-sm-0" id="addBackgroundButton">Add</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-shapes" role="tabpanel" aria-labelledby="v-pills-shapes-tab">
                                        <div class="mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary" type="button" id="dropdownMenuButton3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Draw Line
                                            </button>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Draw Shapes
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton4" id="shapes">
                                                <a class="dropdown-item" value="rectangle" href="#">Rectangle</a>
                                                <a class="dropdown-item" value="circle" href="#">Circle</a>
                                                <a class="dropdown-item" value="triangle" href="#">Triangle</a>
                                            </div>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Speech Bubbles
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton5" id="speech_bubbles">
                                                <a class="dropdown-item" value="bubble1" href="#">1</a>
                                                <%--<a class="dropdown-item" value="bubble2" href="#">2</a>--%>
                                                <%--<a class="dropdown-item" value="bubble3" href="#">3</a>--%>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-text" role="tabpanel" aria-labelledby="v-pills-text-tab">
                                        <div class="mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Add Textbox
                                            </button>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton0" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Fonts
                                            </button>
                                            <div id="font-family" class="dropdown-menu" aria-labelledby="dropdownMenuButton0">
                                                <a class="dropdown-item" href="#">Ariel</a>
                                                <a class="dropdown-item" href="#">Helvetica</a>
                                                <a class="dropdown-item" href="#">Times New Roman</a>
                                                <a class="dropdown-item" href="#">Courier New</a>
                                            </div>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Font Style
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                                <a class="dropdown-item" href="#">Normal</a>
                                                <a class="dropdown-item" href="#">Bold</a>
                                                <a class="dropdown-item" href="#">Italic</a>
                                            </div>
                                        </div>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Font Size
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                                                <a class="dropdown-item" href="#">12</a>
                                                <a class="dropdown-item" href="#">14</a>
                                                <a class="dropdown-item" href="#">16</a>
                                            </div>
                                        </div>
                                    </div>

                            <div class="tab-pane fade" id="v-pills-cartoonize" role="tabpanel" aria-labelledby="v-pills-post-tab">
                                <span>sepia</span>
                                <input type="checkbox" id="sepia">
                                <label>
                                    <span>grayScale</span>
                                    <input type="checkbox" id="grayScale">
                                </label>
                                <label>
                                    <span>invert</span>
                                    <input type="checkbox" id="invert">
                                </label>
                                <label>
                                    <span>Black/White</span>
                                    <input type="checkbox" id="BlackWhite">
                                </label>
                                <label>
                                    <span>Brownie</span>
                                    <input type="checkbox" id="Brownie">
                                </label>
                                <label>
                                    <span>Vintage</span>
                                    <input type="checkbox" id="Vintage">
                                </label>
                                <label>
                                    <span>Kodachrome</span>
                                    <input type="checkbox" id="Kodachrome">
                                </label>
                                <label>
                                    <span>Technicolor</span>
                                    <input type="checkbox" id="Technicolor">
                                </label>
                                <label>
                                    <span>Polaroid</span>
                                    <input type="checkbox" id="Polaroid">
                                </label>
                                <label>
                                    <span>Brightness</span>
                                    <input type="checkbox" id="Brightness">
                                    <input type="range" id="brightnessValue" value="0.1" min="-1" max="1" step="0.003921">
                                </label>


                                <label><span>Gamma:</span> <input type="checkbox" id="gamma"></label>
                                <label>R : <input type="range" id="gamma_red" value="1" min="0.2" max="2.2" step="0.003921"></label>
                                <label>G : <input type="range" id="gamma_green" value="1" min="0.2" max="2.2" step="0.003921"></label>
                                <label>B : <input type="range" id="gamma_blue" value="1" min="0.2" max="2.2" step="0.003921"></label>


                                <label>
                                    <span>Contrast:</span>
                                    <input type="checkbox" id="contrast">
                                    <input type="range" id="contrastValue" value="0" min="-1" max="1" step="0.003921">
                                </label>
                                <label>
                                    <span>Saturation:</span>
                                    <input type="checkbox" id="saturation">
                                    <input type="range" id="saturationValue" value="0" min="-1" max="1" step="0.003921">
                                </label>
                                <label>
                                    <span>Hue </span>
                                    <input type="checkbox" id="hue">
                                    <input type="range" id="hueValue" value="0" min="-1" max="1" step="0.003921">
                                </label>
                                <label>
                                    <span>Noise </span>
                                    <input type="checkbox" id="noise">
                                    <input type="range" id="noiseValue" value="100" min="0" max="1000">
                                 </label>
                                <label>
                                    <span>Pixelate</span>
                                    <input type="checkbox" id="pixelate">
                                    <input type="range" id="pixelateValue" value="4" min="2" max="20">
                                </label>

                                <label>
                                    <span>Blur:</span>
                                    <input type="checkbox" id="blur">
                                    <input type="range" id="blurValue" value="0.1" min="0" max="1" step="0.01">
                                </label>

                                    </div>

                                    <div class="tab-pane fade" id="v-pills-post" role="tabpanel" aria-labelledby="v-pills-post-tab">
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;"id="cartoonize">Cartoonize Image</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="load_draft">Load Draft</button>
                                        <div class="dropdown mr-auto mt-2 mt-lg-0">
                                            <button class="btn btn-secondary" type="button" id="newComicButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Add Comic Title
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="newComicButton">
                                                <input class="form-control mr-sm-2" id="new_comic_book_input" type="search" placeholder="Enter the Title" aria-label="Search">
                                                <button class="btn btn-outline-success my-2 my-sm-0" id="new_comicbook">Add</button>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="undo">Undo</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="redo">Redo</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="send_back">Move Back</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="send_front">Move Front</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="copy">Copy</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="cut">Cut</button>
                                        <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="paste">Paste</button>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg canvas_container">
                        <div class="tab-content">
                            <div class="tab-pane active" id="page1">
                                <canvas id="canvas" class="draw_canvas">

                                </canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%-- right tab bar --%>
        <div class="d-flex flex-row-reverse align-items-stretch body-container-inner">
            <div class="right-tabs-container">
                <div id="right-tabs-tools" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Tools">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-tools vertical-align"></i>
                </div>
                <div id="right-tabs-drawing" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Drawing">
                    <i class="fas fa-angle-left vertical-align"></i> <img src="icons/drawing.png" class="vertical-align" id="drawing-icon" style="width: 25px; height: 25px">
                </div>
                <div id="right-tabs-shapes" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Shapes">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-shapes vertical-align"></i>
                </div>
                <div id="right-tabs-text" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Text">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="material-icons vertical-align">font_download</i>
                </div>
                <div id="right-tabs-images" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Images">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-image vertical-align"></i>
                </div>
                <div id="right-tabs-premade-characters" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Pre-made Charaters">
                    <i class="fas fa-angle-left vertical-align"></i> <img src="icons/premade.png" class="vertical-align" id="premade-character-icon" style="width: 25px; height: 25px">
                </div>
                <div id="right-tabs-filtering" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Images">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-filter vertical-align"></i>
                </div>
            </div>
            <div class="right-list-container" id="right-list-container">
                <div class="right-list-items" id="right-list-tools">
                    <div class="icons-container">

                    </div>
                </div>
                <div class="right-list-items" id="right-list-drawing">
                    <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="free_draw">Free Drawing</button>

                </div>
                <div class="right-list-items" id="right-list-shapes">
                    <p class="right-list-item">CHAPTER</p>
                </div>
                <div class="right-list-items" id="right-list-text"></div>
                <div class="right-list-items" id="right-list-images"></div>
                <div class="right-list-items" id="right-list-premade-characters"></div>
                <div class="right-list-items" id="right-list-filtering"></div>
            </div>
        </div>
        <%-- right tab bar --%>
    </div>
</div>

<script>
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>

<div id="wrapper">
            <canvas id="base-canvas" height="200" width="200" style="display:none"></canvas>
            <canvas id="src-canvas" height="200" width="200" style="display:none"></canvas>
    <div>
        <div>
            <h3>Step1</h3>
            &#8595; Draw mask area. <br />
            <canvas id="mask-canvas" height="200" width="200"></canvas><br />
            <button name="adjustBtn" onclick="adjustBlendPosition()">HERE</button>
            <button id="changeImageBtn">Change Images</button>

            <h3>Step2</h3>
            <canvas id="result-canvas" height="200" width="200"></canvas><br />
            Adjust blend position:
            <button name="directionBtn" onclick="moveBlendPosition('up')">&#8593;</button>
            <button name="directionBtn" onclick="moveBlendPosition('right')">&#8594;</button>
            <button name="directionBtn" onclick="moveBlendPosition('down')">&#8595;</button>
            <button name="directionBtn" onclick="moveBlendPosition('left')">&#8592;</button>
            <br />
            <button name="blendBtn" onclick="blendImages()">Blending</button>
            <button id="addToFabric">AddToFabric</button>
        </div>
    </div>
    <div id="footer1">
        <button name="resetBtn" onclick="initializeCanvas()">Reset all Canvas</button><br />
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Tags and Genres</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h3>Genres</h3>
                <div id="genre_list">
                    <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Horror</button>
                    <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Fantasy</button>
                    <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Romance</button>
                    <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Action</button>
                    <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Comedy</button>
                    <button href="#" class="btn btn-primary btn-sm" role="button" aria-pressed="true" style="width: 7%; margin-top: 4px; margin-left: 4px; margin-right: 0px">Sci-Fi</button>
                </div>
                <h3>Tags</h3>
                <div id="tag_list">
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="tagandgenre_button">Add Selected Genres and Tags</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        let title = '<%=session.getAttribute("title")%>';
        let chapter = '<%=session.getAttribute("chapter")%>';
        console.log(title);
        console.log(chapter);
        <%
            if (session.getAttribute("title") != null) { %>
                $("#dropdownComicListButton").text(title);
                $("#dropdownChapterListButton").text(chapter);
                loadComic();
                <%
                    session.removeAttribute("title");
                    session.removeAttribute("chapter");
                %>
                console.log("from user profile");
            <%}
        %>
        console.log('<%=session.getAttribute("title")%>');
    });
</script>
</html>