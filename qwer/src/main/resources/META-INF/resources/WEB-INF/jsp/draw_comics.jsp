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
    <script type="text/javascript" src="extras/all.js"></script>
    <script type="text/javascript" src="lib/hash.js"></script>
    <script type="text/javascript" src="lib/turn.min.js"></script>
    <script type="text/javascript" src="lib/zoom.min.js"></script>
    <script type="text/javascript" src="lib/bookshelf.js"></script>
    <script type="text/javascript" src="lib/fabric.min.js"></script>
    <script type="text/javascript" src="js/draw_comics.js"></script>
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
    <div class="align-content-center" style="display: flex; margin-top: 2%; height: 85%">
        <div style="width: 15%; height: 100%; float: left; margin-left: 10%; margin-right: 2%; align-items: center; border-style: solid; border-color: #1d2124;">
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Navigate Comic Pages</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Add Background</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Upload Image</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Upload moving Image</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Cartoonize Image</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Add Genre & Tags</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="save_button">Save Draft</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;">Post Comics</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="new_page">Add New Page</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="delete_page">Delete Page</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="load_draft">Load Draft</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="new_comicbook">New Comic Book</button>
            <button type="button" class="btn btn-primary btn-sm active" style="margin-top: 5px; margin-left: 5px; margin-right: 5px; width: 96%;" id="new_chapter">New Chapter</button>
        </div>

        <canvas id="canvas" style="width: 46%; height: 100%; border-style: solid; border-color: #1d2124; font-size: 30px; text-align: center">

        </canvas>

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

</body>
</html>