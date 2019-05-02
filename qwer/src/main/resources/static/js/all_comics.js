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