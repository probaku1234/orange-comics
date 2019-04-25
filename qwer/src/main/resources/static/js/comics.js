$(document).ready(function () {
    let comicList;
    let chapterList;
    let currentComicTitle;

    $.ajax({
        type: "POST",
        url: "/get_comic_list",
        success: function (array) {
            comicList = array;
            for (var i = 0; i < array.length; i++) {
                $("#comic_list").append("<a class='dropdown-item' value='"+ i + "'>" + array[i].title + "</a>");
            }
        }
    });

    $(document).on("click", '#comic_list a',function () {
        var value = $(this).attr('value');
        currentComicTitle = $(this).text();
        $(this).parents('.dropdown').find('.dropdown-toggle').html(currentComicTitle);
        getChapterList(comicList[value].title);
    });
    


    $("#new_comicbook").click(function () {
        var title = $("#new_comic_book_input").val();

        $.ajax({
            type: "POST",
            url: "/create_comic",
            data: {
                "comic_name" : title
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
            }
        });
    });

    $("#new_chapter").click(function () {

        $.ajax({
            type: "POST",
            url: "/create_chapter",
            data: {
                "comic_name" : currentComicTitle
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
            }
        });
    });


});

function getComicList() {
    $.ajax({
        type: "POST",
        url: "/get_comic_list",
        success: function (array) {
            comicList = array;
            for (var i = 0; i < array.length; i++) {
                $("#comic_list").append("<a class='dropdown-item' value='"+ i + "'>" + array[i].title + "</a>");
            }
        }
    });
}

function getChapterList(title) {
    $.ajax({
        type: "POST",
        url: "/get_chapter_list",
        data: {
            "comic_name" : title
        },
        dataType: "json",
        success: function (array) {
            $("#chapter_list").empty();
            for (var i = 0; i < array.length; i++) {
                var text = i + 1;
                $("#chapter_list").append("<a class='dropdown-item' value='"+ i + "'>" + text + "</a>");
            }
        }
    });
}