$(document).ready(function(){
    $("#signup_name").focusout( function() {
        var id = $("#signup_name").val();

        $.ajax({
            type:"get",
            dataType: "json",
            url: "/signup?signup_id="+id,

            success : function(data) {
                console.log("Success!");
                if(data==1) { // success, username is not duplicated
                    $("#signup_btn").removeAttr("disabled");
                }
                else { // failed, username is duplicated
                    $("#signup_name").val("Username already exists");
                    $("#signup_btn").attr("disabled", "disabled");
                }
            }
        })
    });

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