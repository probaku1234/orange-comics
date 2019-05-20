$(document).ready(function () {
    let selectedComics;
    let index;
    let chapter;

    $('#post').hide();
    $.ajax({
        type: "POST",
        url: "/get_user_comic_list",
        success: function (array) {
            for (var i = 0; i < array.length; i++) {
                for (var j = 0; j < array[i].chapters.length; j++) {
                    $("#comic_list").append("<button class='list-group-item'><h4 class='list-group-item-heading'>"+ array[i].title +"</h4><p class='list-group-item-text'>Chapter "+ (j+1) +"</p><p class='list-group-item-text'>"+ array[i].publishedDate+ "</p></button>");
                }
            }
        }
    });

    $('.list-group button').click(function () {
        var index = $(this).index();
        console.log(index);

        if (index == 0) {
            $(this).addClass("active");
            $(this).parent().children().eq(1).removeClass("active");
            $("#profile").show();
            $('#post').hide();
        } else {
            $(this).addClass("active");
            $(this).parent().children().eq(0).removeClass("active");
            $('#post').show();
            $('#profile').hide();
        }
    });

    $(document).on("click","#comic_list button",function () {
        $(this).parent().children().removeClass("active");
        $(this).addClass("active");
        selectedComics = $(this).children().eq(0).text();
        chapter = parseInt($(this).children().eq(1).text().substring(8));
        index = $(this).index();
        console.log(selectedComics);
        console.log(chapter);
    });
    
    $("#delete_comic_button").click(function () {
        if (selectedComics == undefined) {
            alert("Please select comic");
        } else {
            $.ajax({
                type: "POST",
                url: "/delete_selected_comic",
                data: {
                    "title" : selectedComics
                },
                success: function (response) {
                    console.log(response);
                    if (response == 1) {
                        $("#comic_list").children().eq(index).remove();
                    }
                }
            });
        }
    });

    $("#delete_chapter_button").click(function () {
        if (selectedComics == undefined || chapter == undefined) {
            alert("Please select comic");
        } else {
            $.ajax({
                type: "POST",
                url: "/delete_selected_chapter",
                data: {
                    "title" : selectedComics,
                    "chapter" : chapter
                },
                success: function (response) {
                    console.log(response);
                    if (response == 1) {
                        $("#comic_list").children().eq(index).remove();
                    }
                }
            });
        }
    });

    $("#edit_chapter_button").click(function () {
        if (selectedComics == undefined || chapter == undefined) {
            alert("Please select comic");
        } else {
            $.ajax({
                type: "POST",
                url: "/edit_selected_chapter",
                data: {
                    "title" : selectedComics,
                    "chapter" : chapter
                },
                complete: function () {
                    window.location.replace("/draw_comics");
                }
            });
        }
    });
});