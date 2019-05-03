$(document).ready(function () {
    let tags = new Array();
    let genres = new Array();

    $.ajax({
        type: "POST",
        url: "/get_all_comics",
        success: function (data) {
            console.log(data);
        }
    });

    $("#genre_list button").each(function () {
        genres.push($(this).text());
    });

    $("#tag_list").each(function () {
        tags.push($(this).text());
    });

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
        getComicListByTagsAndGenres(tags, genres);
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
        getComicListByTagsAndGenres(tags, genres);
    });
});

function getComicListByTagsAndGenres(tags, genres) {
    $.ajax({
        type: "POST",
        url: "/get_comic_list_by_tags_and_genres",
        data: {
            "tags": tags,
            "genres": genres
        },
        success: function (data) {
            console.log(data);
        }
    });
}