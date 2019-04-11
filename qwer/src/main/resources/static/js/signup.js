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
})