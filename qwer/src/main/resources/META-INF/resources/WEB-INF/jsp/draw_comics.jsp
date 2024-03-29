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
    <script type="text/javascript" src="js/logout.js"></script>
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
            <!--<li class="nav-item nav_list_indent">
                <a class="nav-link" href="my_favorites">My Favorites</a>
            </li>-->
        </ul>
        <form class="form-inline my-2 my-lg-0 nav_list_indent" action="search_result" method="get">
            <input class="form-control mr-sm-2 top-nav-search-bar" type="search" placeholder="Search" aria-label="Search" name="keyword">
            <button class="btn btn-outline-success my-2 my-sm-0 top-nav-search-button" type="submit"><i class="fas fa-search"></i></button>
        </form>
        <ul class="navbar-nav mr-10 mt-2 mt-lg-0 nav_right_margin">
            <li class="nav-item">
                <a class="nav-link" href="messages" data-toggle="tooltip" data-placement="left" title="Messages"><i class="fas fa-envelope" style="font-size: 25px"></i></a>
            </li>

            <li class="nav-item dropdown" style="margin-right: 20px" data-toggle="tooltip" data-placement="left" title="Notification">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-bell" style="font-size: 25px"></i>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="notifications">notification 1</a>
                    <a class="dropdown-item" href="notifications">notification 2</a>
                    <a class="dropdown-item" href="notifications">notification 3</a>
                </div>
            </li>
            <li class="nav-item d-flex">
                <%
                    if (session.getAttribute("user") == null) {
                        %><a class="nav-link" href="login" data-toggle="tooltip" data-placement="left" title="Signs In">Sign In</a><%
                    }
                    else {
                        String user = (String)session.getAttribute("user");
            %><a class="nav-link" href="user_profile" data-toggle="tooltip" data-placement="left" title="My Profile" ><div id="user_id"><%=user%></div></a><%
                        %><a class="nav-link" id="logout_button" href="" data-toggle="tooltip" data-placement="left" title="Sign Out"><i class="fas fa-sign-out-alt" style="font-size: 25px"></i></a><%
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
                    <button type="button" class="btn-sm btn-success" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 60%;" id="save_button">
                        Save Draft
                    </button>
                </div>
                <div class="left-list-items" id="left-list-post" style="padding-bottom: 40px; text-align: center;">
                    <p class="left-list-item " style="padding-top: 40px; padding-bottom: 15px">Select Genres & Tags</p>
                    <button type="button" class="btn-sm btn-success" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 60%;" data-toggle="modal" data-target="#exampleModal">
                        Add Genres & Tags
                    </button>
                    <p class="left-list-item" style="padding-top: 75px; padding-bottom: 5px">Do you really want to</p>
                    <p class="left-list-item" style="padding-bottom: 15px">post a comic?</p>
                    <button type="button" class="btn-sm btn-success" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 60%;" id="post_button">Post Comic</button>
                </div>
            </div>
        </div>
        <%-- left tab bar --%>

        <div class="h-92">
            <div class="d-flex" style="margin-left: 100px">
                <div style="display: inline; margin-right: 100px;font-family: 'Comic Sans MS'; font-size: 20px; font-weight: bold;">
                    Title: <span id="show-title" style="font-weight: normal;"></span>
                </div>
                <div style="display: inline; margin-right: 100px; font-family: 'Comic Sans MS'; font-size: 20px; font-weight: bold;">
                    Chapter: <span id="show-chapter" style="font-weight: normal;"></span>
                </div>
            </div>
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
                    <!--

                    -->
                    <div class="col-lg canvas_container">
                        <div class="tab-content">
                            <div class="tab-pane active" id="page1">
                                <canvas id="canvas" class="draw_canvas" >

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
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-tools vertical-align icon-style"></i>
                </div>
                <div id="right-tabs-drawing" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Drawing">
                    <i class="fas fa-angle-left vertical-align"></i> <img src="icons/drawing.png" class="vertical-align icon-style" id="drawing-icon">
                </div>
                <div id="right-tabs-shapes" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Shapes">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-shapes vertical-align icon-style"></i>
                </div>
                <div id="right-tabs-text" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Text">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="material-icons vertical-align icon-style">font_download</i>
                </div>
                <div id="right-tabs-images" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Images">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-image vertical-align icon-style"></i>
                </div>
                <div id="right-tabs-premade-characters" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Pre-made Charaters">
                    <i class="fas fa-angle-left vertical-align"></i> <img src="icons/premade.png" class="vertical-align icon-style" id="premade-character-icon">
                </div>
                <div id="right-tabs-filtering" class="right-tabs" data-toggle="tooltip" data-placement="left" title="Filtering">
                    <i class="fas fa-angle-left vertical-align"></i> <i class="fas fa-filter vertical-align icon-style"></i>
                </div>
            </div>
            <div class="right-list-container" id="right-list-container">
                <div class="right-list-items" id="right-list-tools">
                    <div class="row" style="width: 330px">
                        <a class="right-list-item"><i id="send_front" class="fas fa-arrow-up vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Bring to Front"></i></a>
                        <a class="right-list-item"><i id="send_back" class="fas fa-arrow-down vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Send to Back"></i></a>
                        <a class="right-list-item"><i id="undo" class="fas fa-undo-alt vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Undo"></i></a>
                        <a class="right-list-item"><i id="redo" class="fas fa-redo-alt vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Redo"></i></a>
                        <a class="right-list-item"><i id="copy" class="fas fa-copy vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Copy"></i></a>
                        <a class="right-list-item"><i id="cut" class="fas fa-cut vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Cut"></i></a>
                        <a class="right-list-item"><i id="paste" class="fas fa-paste vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Paste"></i></a>
                        <a class="right-list-item"><img id="flip_horizon" src="icons/flip-horizon.png" class="vertical-align icon-style" id="flip_horizon-icon" data-toggle="tooltip" data-placement="top" title="Flip Horizontally"></a>
                        <a class="right-list-item"><img id="flip_vertical" src="icons/flip-vertical.png" class="vertical-align icon-style" id="flip_vertical-icon" data-toggle="tooltip" data-placement="top" title="Flip Vertically"></a>
                        <button class="right-list-item" id="cartoonize">Cartoonize</button>
                    </div>
                </div>
                <div class="right-list-items" id="right-list-drawing">
                    <div class="row" style="width: 330px">
                        <a class="right-list-item" id="free_draw"><i class="fas fa-pencil-alt vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Pencil"></i></a>
                    </div>

                </div>
                <div class="right-list-items" id="right-list-shapes">
                    <div class="row" id="shapes" style="width: 330px">
                        <a class="right-list-item" value="rectangle" href="#"><i class="far fa-square vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Rectangle"></i></a>
                        <a class="right-list-item" value="circle" href="#"><i class="far fa-circle vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Circle"></i></a>
                        <a class="right-list-item" value="triangle" href="#"><img src="icons/triangle.png" class="vertical-align image-style" data-toggle="tooltip" data-placement="top" title="Triangle"></a>
                        <a class="right-list-item" id="speech_bubbles" href="#"><i class="far fa-comment vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Speech Bubble"></i></a>
                        <a class="right-list-item" id="draw_line"><img src="icons/straight-line.png" class="vertical-align image-style" data-toggle="tooltip" data-placement="top" title="Straight Line"></a>
                    </div>
                </div>
                <div class="right-list-items" id="right-list-text">
                    <div class="row" style="width: 330px">
                        <a class="right-list-item" id="textbox" href="#"><i class="far fa-edit vertical-align icon-style" data-toggle="tooltip" data-placement="top" title="Text Box"></i></a>
                        <div class="right-list-item">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton0" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Fonts
                            </button>
                            <div id="text-font-family" class="dropdown-menu" aria-labelledby="dropdownMenuButton0">
                                <a class="dropdown-item" href="#">Ariel</a>
                                <a class="dropdown-item" href="#">sans-serif</a>
                                <a class="dropdown-item" href="#">Calibri</a>
                                <a class="dropdown-item" href="#">Comic Sans MS</a>
                                <a class="dropdown-item" href="#">Consolas</a>
                                <a class="dropdown-item" href="#">Courier New</a>
                                <a class="dropdown-item" href="#">Helvetica</a>
                                <a class="dropdown-item" href="#">Tahoma</a>
                                <a class="dropdown-item" href="#">Verdana</a>
                            </div>
                        </div>
                        <div class="right-list-item">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Font Style
                            </button>
                            <div id="text-font-style" class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                <a class="dropdown-item" href="#">Normal</a>
                                <a class="dropdown-item" href="#">Italic</a>
                            </div>
                        </div>
                        <div class="right-list-item">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Font Size
                            </button>
                            <div id="text-font-size" class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                                <a class="dropdown-item" href="#">10</a>
                                <a class="dropdown-item" href="#">12</a>
                                <a class="dropdown-item" href="#">14</a>
                                <a class="dropdown-item" href="#">16</a>
                                <a class="dropdown-item" href="#">18</a>
                                <a class="dropdown-item" href="#">20</a>
                                <a class="dropdown-item" href="#">24</a>
                                <a class="dropdown-item" href="#">28</a>
                                <a class="dropdown-item" href="#">32</a>
                                <a class="dropdown-item" href="#">36</a>
                                <a class="dropdown-item" href="#">40</a>
                                <a class="dropdown-item" href="#">44</a>
                                <a class="dropdown-item" href="#">48</a>
                                <a class="dropdown-item" href="#">54</a>
                                <a class="dropdown-item" href="#">60</a>
                                <a class="dropdown-item" href="#">66</a>
                            </div>
                        </div>


                    </div>
                </div>
                <div class="right-list-items" id="right-list-images">
                    <p class="right-list-item" style="padding-top: 40px; padding-bottom: 10px">Upload Image</p>
                    <input type="file" id="myFile" style=""width:200px>
                    <p class="right-list-item" style="padding-top: 40px; padding-bottom: 10px">Add Image from URL</p>
                    <p class="form-inline right-list-item list-block">
                        <input class="form-control mr-sm-2 right-list-input" id="addImageFromURL" type="search" placeholder="Enter the URL" aria-label="Search">
                        <button class="btn-sm btn-success my-2 my-sm-0 right-list-button" id="addImageButton"> Add </button>
                    </p>
                    <p class="right-list-item" style="padding-top: 40px; padding-bottom: 10px">Add Background from URL</p>
                    <p class="form-inline right-list-item list-block">
                        <input class="form-control mr-sm-2 right-list-input" id="addBackgroundFromURL" type="search" placeholder="Enter the URL" aria-label="Search">
                        <button class="btn-sm btn-success my-2 my-sm-0 right-list-button" id="addBackgroundButton"> Add </button>
                    </p>
                </div>
                <div class="right-list-items" id="right-list-premade-characters">
                    <div class="row" id="premade_images"  style="width: 330px">
                        <a class="right-list-item " value="add_premade48" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/60/13534727415379.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade49" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/53/13526739613080.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade4" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932658217304.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade47" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/17/13504552819340.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade5" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/61/13540113018988.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade6" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932662416551.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade7" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932670829054.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade8" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932677419173.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade9" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932657015284.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade10" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932666019343.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade11" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932668414295.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade12" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932658817069.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade13" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932700211017.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade14" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932664223023.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade15" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932649215024.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade16" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932697814193.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade17" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932645615835.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade18" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932688212001.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade19" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932684611250.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade20" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932664815276.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade21" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932634218307.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade22" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932622829846.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade23" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932613219416.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade24" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932606612912.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade25" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932641417567.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade26" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/83/13939161014804.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade27" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932607811463.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade28" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932672025948.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade29" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/100/13950199211486.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade30" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932639612165.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade31" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932639014891.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade32" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/60/13539934212140.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade33" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/65/13550874017348.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade34" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/1/13488914417662.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade35" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/53/13526767212422.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade36" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/1/13488673219292.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade37" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/113/13958583025224.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade38" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/74/13932291011199.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade39" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/51/13525719619719.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade40" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/55/13528019416469.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade41" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/52/13526095811713.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade42" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/52/13526245819001.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade43" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/83/13939368015951.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade44" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/55/13528267221867.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade45" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/93/13945504815093.png" class="vertical-align icon-style">
                        </a>
                        <a class="right-list-item " value="add_premade46" href="#" style="padding:5px 5px">
                            <img width="30px" height="30px" src="http://res.publicdomainfiles.com/pdf_view/17/13504596613288.png" class="vertical-align icon-style">
                        </a>
                    </div>
                </div>
                <div class="right-list-items" id="right-list-filtering" style="padding: 20px 20px 20px 20px">
                    <label>
                        <span>Sepia</span>
                        <input type="checkbox" id="sepia">
                    </label>
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