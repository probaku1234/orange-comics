$(document).ready(function(){
    $("#login_btn").click(function(){
        var id = $("#login_username").val();
        var pw = $("#login_password").val();

        $.ajax({
            type:"post",
            url: "/login",
            data: {
                login_username: id,
                login_password: pw
            },
            dataType:'json',

            success : function(data) {
                if(data==1){ // valid ID & password
                    $("#login_warning").text("");
                }
                else { // Invalid ID & password
                    $("#login_warning").text('ID or Password is incorrect');
                }
            }
        });
    });
})