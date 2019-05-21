$(document).ready(function () {
    $(document).on("click",'#logout_button',function () {
        $.ajax({
            type:"post",
            url: "/logout",
            success : function() {
                console.log("log out");
                location.reload();
            }
        });
    });
});