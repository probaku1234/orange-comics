$(document).ready(function () {
    let tags = new Array();
    let genres = new Array();

    $("#tag_list button").click(function () {
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
            tags.splice(tags.indexOf($(this).text()), 1);
            console.log(tags);
        } else {
            $(this).addClass("active");
            tags.push($(this).text());
            console.log(tags);
        }
        getComicListByTags(tags);
    });
    
    $("#genre_list button").click(function () {
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
            genres.splice(genres.indexOf($(this).text()), 1);
            console.log(genres);
        } else {
            $(this).addClass("active");
            genres.push($(this).text());
            console.log(genres);
        }
        getComicsListByGenres(genres);
    });
});

function getComicListByTags(tags) {
    $.ajax({
        type: "POST",
        url: "/get_comic_list_by_tags",
        data: {
            "tags": tags
        },
        success: function (data) {
            console.log(data);
        }
    });
}

function getComicsListByGenres(genres) {
    $.ajax({
        type: "POST",
        url: "/get_comic_list_by_genres",
        data: {
            "genres": genres
        },
        success: function (data) {
            console.log(data);
        }
    });
}