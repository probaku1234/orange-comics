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


    <link rel="icon" type="image/png" href="pics/favicon.png" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
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
        <form class="form-inline my-2 my-lg-0 nav_list_indent" action="search_result">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0">Search</button>
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
                        %><a class="nav-link"><%=user%></a><%
                    }
                %>
            </li>
        </ul>
    </div>
</nav>
<div class="splash h-92">
    <div class="align-content-center" style="display: flex; height: 85%">
        <div style="width: 15%; height: 100%; float: left; margin-left: 10%; margin-right: 2%; align-items: center; border-style: solid; border-color: #1d2124;">
            <button id="cartoonize" type="button" class="btn btn-primary btn-sm active" data-toggle="modal" data-target="#myModal" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Cartoonize Image</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Add Genre & Tags</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="save_button">Save Draft</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="post_button">Post Comics</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="new_page">Add New Page</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="delete_page">Delete Page</button>
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
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="new_chapter">New Chapter</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="free_draw">Free Drawing</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="undo">Undo</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="redo">Redo</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="send_back">Move Back</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="send_front">Move Front</button>
            <div class="dropdown mr-auto mt-2 mt-lg-0">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownComicListButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Comic Titles
                </button>
                <div id="comic_list" class="dropdown-menu" aria-labelledby="dropdownComicListButton">

                </div>
            </div>
            <div class="dropdown mr-auto mt-2 mt-lg-0">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownChapterListButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Chapters
                </button>
                <div id="chapter_list" class="dropdown-menu" aria-labelledby="dropdownChapterListButton">

                </div>
            </div>
        </div>

        <div class="container">
            <ul class="nav nav-tabs" role="tablist">
                <li class="active">
                    <a href="#page1" data-toggle="tab">Page 1</a>
                </li>
                <li><a href="#" class="add-page">+ Add Page</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="page1">
                    <canvas id="canvas" class="draw_canvas">

                    </canvas>
                </div>
            </div>

        </div>

        <div id="functions" style="width: 15%; height: 100%; float: left; margin-left: 2%; margin-right: 10%; align-items: center; border-style: solid; border-color: #1d2124;">
            <div class="navbar" style="height: 33%; width: 100%; border-style: solid; border-color: #1b1e21; flex: 1;">
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
            <div class="navbar" style="height: 33%; width: 100%; border-style: solid; border-color: #1b1e21; flex: 1;">
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
            <div class="navbar" style="height: 34%; width: 100%; border-style: solid; border-color: #1b1e21; flex: 1;">
                <div class="dropdown mr-auto mt-2 mt-lg-0">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Pre-made Characters
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton10" id="premade_images">
                        <a class="dropdown-item" value="add_premade1" href="#">1</a>
                        <a class="dropdown-item" value="add_premade2" href="#">2</a>
                        <a class="dropdown-item" value="add_premade3" href="#">3</a>
                    </div>
                </div>
                <div class="dropdown mr-auto mt-2 mt-lg-0">
                    <button class="btn btn-secondary" type="button" id="dropdownMenuButton11" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Add Image from URL
                    </button>
                    <input type="file" id="imgLoader">
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
        </div>

    </div>
</div>
<div id="wrapper">
    <div>
        <div class="inputoutput">
            <img id="imageSrc" alt="No Image" />
            <div class="caption">imageSrc
                <input type="file" id="fileInput" name="file" />
            </div>
        </div>


        <div class="inputoutput">
            <canvas id="canvasOutput" ></canvas>
            <div class="caption">canvasOutput</div>
        </div>
    </div>
    <div>
        <button id="gray">Effect1</button>
        <button id="bilateralFilter">Effect2</button>
        <button id="ImageCanny">Effect3</button>
        <button>Effect4</button>
        <button>Effect5</button>
    </div>

    <div id="aaa" class="clearfix">
        <div>
            <img id="_mask" src="/images/mask.jpg" height="200" width="200" alt="mask">
            <img id="_img" src="/images/air.jpg" height="200" width="200" alt="butterfly">
            <img id="_hand" src="/images/handd.png" height="200" width="200" alt="hand">
            <img id="_sign" src="/images/signn.png" height="200" width="200" alt="sign">
        </div>

        <div>
            <button onclick="changeImageSet()">Image Setting</button>
            <button onclick="changeImageSet2()">Image Setting</button>
        </div>
    </div>
    <div id="steps" class="clearfix">
        <div>
            <span class="strong">Base Image</span><br />
            <canvas id="base-canvas" height="200" width="200"></canvas>
        </div>
        <div>
            <span class="strong">Blend Source Image</span><br />
            <canvas id="src-canvas" height="200" width="200"></canvas>
        </div>
    </div>
    <div>
        <div>
            <h3>Step1</h3>
            &#8595; Draw mask area. <br />
            <canvas id="mask-canvas" height="200" width="200"></canvas><br />
            <button name="adjustBtn" onclick="adjustBlendPosition()">HERE</button>
            <h3>Step2</h3>
            <canvas id="result-canvas" height="200" width="200"></canvas><br />
            Adjust blend position:
            <button name="directionBtn" onclick="moveBlendPosition('up')">&#8593;</button>
            <button name="directionBtn" onclick="moveBlendPosition('right')">&#8594;</button>
            <button name="directionBtn" onclick="moveBlendPosition('down')">&#8595;</button>
            <button name="directionBtn" onclick="moveBlendPosition('left')">&#8592;</button>
            <br />
            <button name="blendBtn" onclick="blendImages()">Blending</button>
        </div>
    </div>
    <div id="footer1">
        <button name="resetBtn" onclick="initializeCanvas()">Reset all Canvas</button><br />
    </div>
</div>

<%--<div class="modal fade" id="myModal" role="dialog">--%>
<%--    <div class="modal-dialog modal-lg">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <button type="button" class="close" data-dismiss="modal">&times;</button>--%>
<%--            </div>--%>
<%--            <div id="wrapper">--%>
<%--                <div>--%>
<%--                    <div class="inputoutput">--%>
<%--                        <img id="imageSrc" alt="No Image" />--%>
<%--                        <div class="caption">imageSrc--%>
<%--                            <input type="file" id="fileInput" name="file" />--%>
<%--                        </div>--%>
<%--                    </div>--%>


<%--                    <div class="inputoutput">--%>
<%--                        <canvas id="canvasOutput" ></canvas>--%>
<%--                        <div class="caption">canvasOutput</div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div>--%>
<%--                    <button id="gray">Effect1</button>--%>
<%--                    <button id="bilateralFilter">Effect2</button>--%>
<%--                    <button id="ImageCanny">Effect3</button>--%>
<%--                    <button>Effect4</button>--%>
<%--                    <button>Effect5</button>--%>
<%--                </div>--%>

<%--                <div id="aaa" class="clearfix">--%>
<%--                    <div>--%>
<%--                        <img id="_mask" src="/images/mask.jpg" height="200" width="200" alt="mask">--%>
<%--                        <img id="_img" src="/images/air.jpg" height="200" width="200" alt="butterfly">--%>
<%--                        <img id="_hand" src="/images/handd.png" height="200" width="200" alt="hand">--%>
<%--                        <img id="_sign" src="/images/signn.png" height="200" width="200" alt="sign">--%>
<%--                    </div>--%>

<%--                    <div>--%>
<%--                        <button onclick="changeImageSet()">Image Setting</button>--%>
<%--                        <button onclick="changeImageSet2()">Image Setting</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div id="steps" class="clearfix">--%>
<%--                    <div>--%>
<%--                        <span class="strong">Base Image</span><br />--%>
<%--                        <canvas id="base-canvas" height="200" width="200"></canvas>--%>
<%--                    </div>--%>
<%--                    <div>--%>
<%--                        <span class="strong">Blend Source Image</span><br />--%>
<%--                        <canvas id="src-canvas" height="200" width="200"></canvas>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div>--%>
<%--                    <div>--%>
<%--                        <h3>Step1</h3>--%>
<%--                        &#8595; Draw mask area. <br />--%>
<%--                        <canvas id="mask-canvas" height="200" width="200"></canvas><br />--%>
<%--                        <button name="adjustBtn" onclick="adjustBlendPosition()">HERE</button>--%>
<%--                        <h3>Step2</h3>--%>
<%--                        <canvas id="result-canvas" height="200" width="200"></canvas><br />--%>
<%--                        Adjust blend position:--%>
<%--                        <button name="directionBtn" onclick="moveBlendPosition('up')">&#8593;</button>--%>
<%--                        <button name="directionBtn" onclick="moveBlendPosition('right')">&#8594;</button>--%>
<%--                        <button name="directionBtn" onclick="moveBlendPosition('down')">&#8595;</button>--%>
<%--                        <button name="directionBtn" onclick="moveBlendPosition('left')">&#8592;</button>--%>
<%--                        <br />--%>
<%--                        <button name="blendBtn" onclick="blendImages()">Blending</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div id="footer1">--%>
<%--                    <button name="resetBtn" onclick="initializeCanvas()">Reset all Canvas</button><br />--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
</body>
</html>