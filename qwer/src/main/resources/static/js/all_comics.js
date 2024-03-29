$(document).ready(function () {
    let tags = [];
    let genres = [];

    $.ajax({
        type: "POST",
        url: "/get_all_comics",
        success: function (data) {
            console.log(data);
        }
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

    $(".genre, .tag").on("click",function () {
        var index = $(this).index();
        $("#left-tab a").eq(index).css("background","#f39c12").siblings().css("background","#ffc107");
        $("#left-items div").eq(index).show().siblings().hide();
    })
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
            initailizeShelves();

            chapterList = data.allcomics_chapterList;
            TitleList = data.allcomics_TitleList;
            AuthorList = data.allcomics_AuthorList;
            chapterIds = data.allcomics_chapterIds;

            generateThumbnail();
        }
    });
}

function initailizeShelves() {
    for (var i = 0; i < 12; i++) {
        $("#recommended" + i).removeAttr("src");
        $("#recommended" + i).removeAttr("style");
        $("#comic-title-"+ i).empty();
        $("#comic-author-"+i).empty();
        $('#comic-chapter-'+i).empty();
    }
}