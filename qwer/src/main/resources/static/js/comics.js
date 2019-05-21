$(document).ready(function () {
    let comicList;
    let chapterList;
    let currentComicTitle;
    let tags = new Array();
    let genres = new Array();

    $.ajax({
        type: "POST",
        url: "/get_comic_list",
        success: function (array) {
            comicList = array;
            for (var i = 0; i < array.length; i++) {
                $("#comic_list").append("<a class='dropdown-item' value='"+ i + "'>" + array[i].title + "</a>");
                getChapterList(array[i].title);
            }
        }
    });

    $(document).on("click", '#comic_list a',function () {
        var value = $(this).attr('value');
        currentComicTitle = $(this).text();
        $(this).parents('.dropdown').find('.dropdown-toggle').html(currentComicTitle);
        $('.chapter').hide();
        $('.' + currentComicTitle).show();
        //$('.dropdown-item chapter ' + currentComicTitle).show();
        //getChapterList(comicList[value].title);
    });
    


    $("#add-new-comic-button").click(function () {
        var title = $("#add-new-comic-input").val();

        $.ajax({
            type: "POST",
            url: "/create_comic",
            data: {
                "comic_name" : title
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
                $("#comic_list").append("<a class='dropdown-item'>" + title + "</a>");
                currentComicTitle = title;
                $.ajax({
                    type: "POST",
                    url: "/create_chapter",
                    data: {
                        "comic_name" : title
                    },
                    dataType: 'json',
                    success: function (response) {
                        $("#chapter_list").append("<a class='dropdown-item chapter " + title + "' value='0'>" + 1 + "</a>");
                        $("#dropdownComicListButton").text(title);
                        $("#dropdownChapterListButton").text("1");
                        $('.chapter').hide();
                        $('.'+title).show();
                        //$("#chapter_list a").trigger('click');
                        clearCanvas();
                        $('#show-title').text(title);
                        $('#show-chapter').text('1');
                    }
                });
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
                var count = $('.'+currentComicTitle).length;
                $("#chapter_list").append("<a class='dropdown-item chapter " + currentComicTitle + "' value='"+ count +"'>" + (count+1) + "</a>");
            }
        });
    });

    $(document).on("click","#tag_list button",function () {
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
            tags.splice(tags.indexOf($(this).text()), 1);
            console.log(tags);
        } else {
            $(this).addClass("active");
            tags.push($(this).text());
            console.log(tags);
        }
    });

    $(document).on("click", "#genre_list button",function () {
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
            genres.splice(genres.indexOf($(this).text()), 1);
            console.log(genres);
        } else {
            $(this).addClass("active");
            genres.push($(this).text());
            console.log(genres);
        }
    });

    $(document).on("click","#tagandgenre_button", function () {
        $.ajax({
            type: "POST",
            url: "/add_tags_and_genres",
            data: {
                "title": $("#dropdownComicListButton").text(),
                "tags": tags,
                "genres": genres
            },
            success: function (data) {
                console.log(data);
            }
        });
    });
});

function getChapterList(title) {
    $.ajax({
        type: "POST",
        url: "/get_chapter_list",
        data: {
            "comic_name" : title
        },
        dataType: "json",
        success: function (array) {
            for (var i = 0; i < array.length; i++) {
                var text = i + 1;
                $("#chapter_list").append("<a class='dropdown-item chapter " + title + "' value='"+ i + "'>" + text + "</a>");
            }

        }
    });
}