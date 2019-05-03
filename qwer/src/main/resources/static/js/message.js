$(document).ready(function(){
    console.log(msgGroupId)


    // connect_first(jsArray[0])
    connect_first("");

    $("#_msgBtn").click(function(){
        let user2 = $("#_user2").val();
        let message = $("#_contents").val();


        stompClient.send(
            "/app/hello",
            {},
            JSON.stringify({
                'name': $("#user_id").text(),
                'user2': user2,
                'message': message
            }));
    })


    $("#input_msg_btn").click(function(){
        let user2 = $("#id_msg_history").attr('name');
        let message = $("#input_msg_write").val();


        stompClient.send(
            "/app/hello",
            {},
            JSON.stringify({
                'name': $("#user_id").text(),
                'user2': user2,
                'message': message
            }));
    })

    let list = $(".inbox_list_class");
    let list_msgGroupId = $(".msgGroupId");


    for(let i=0;i<list.length;i++){
        list[i].addEventListener('click',function(event){


            $.ajax({
                type: "POST",
                url: "/msgGroupId",
                data: {
                    "msgGroupId" : msgGroupId[i]
                },
                dataType: 'json',
                success: function (messages) {
                    $(".incoming_msg").remove();
                    $(".outgoing_msg").remove();

                    for(let j=0;j<messages.length;j++){
                        if(messages[j].user ==$("#user_id").text()){

                            $('.msg_history').prepend(
                            '<div class="outgoing_msg">'+
                                '<div class="sent_msg">'+
                                '<p>'+messages[j].message+'</p>'+
                            '<span class="time_date">'+messages[j].datePosted+'</span><button style="border:none;" class="msg_remove" name='+messages[j].id+'>x</button></div>'+
                            '</div>'
                                );
                        }else{
                            $("#id_msg_history").attr("name",messages[j].user)
                            $('.msg_history').prepend(
                            '<div class="incoming_msg">'+
                                '<div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>'+
                                '<div class="received_msg">'+
                                '<div class="received_withd_msg">'+
                                '<p>'+messages[j].message+'</p>'+
                                '<span class="time_date">'+messages[j].datePosted+'</span></div>'+ //<button style="border:none;"  class="msg_remove2" name='+messages[j].id+'>x</button>
                                '</div></div>'
                            );

                        }
                    }

                    console.log(messages);
                },
                complete: function () {
                    let rmv_list = $(".msg_remove");
                    for(let i=0;i<rmv_list.length;i++) {
                        rmv_list[i].addEventListener('click', function (event) {
                            let msgId = rmv_list[i].name;
                            rmv_list[i].parentNode.remove()

                            $.ajax({
                                type: "POST",
                                url: "/removeMsg",
                                data: {
                                    "msgId": msgId
                                },
                                dataType: 'json',
                                success: function (messages) {
                                    console.log(messages +"deleted")

                                },fail: function(msg){
                                    console.log(msg)
                                },

                            })

                        })
                    }
                    let rmv_list2 = $(".msg_remove2");
                    for(let i=0;i<rmv_list2.length;i++) {
                        rmv_list2[i].addEventListener('click', function (event) {
                            let msgId2 = rmv_list2[i].name;
                            rmv_list2[i].parentNode.parentNode.remove()

                            $.ajax({
                                type: "POST",
                                url: "/removeMsg",
                                data: {
                                    "msgId": msgId2
                                },
                                dataType: 'json',
                                success: function (messages) {
                                    console.log(messages +"deleted")

                                },fail: function(msg){
                                    console.log(msg)
                                },

                            })
                        })
                    }
                }
            });
        })
    }


})
function showGreeting2(sender,receiver,message) {
    let user = $("#user_id").text();







    if(user == sender || user== receiver){
        // $("#id_msg_history").append("<tr><td>" + message + "</td></tr>");



        if(sender ==$("#user_id").text()){

            $('.msg_history').append(
                '<div class="outgoing_msg">'+
                '<div class="sent_msg">'+
                '<p>'+message+'</p>'+
                '<span class="time_date">'+"now"+'</span> </div>'+
                '</div>'
            );
        }else{
            $('.msg_history').append(
                '<div class="incoming_msg">'+
                '<div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="Jake"> </div>'+
                '<div class="received_msg">'+
                '<div class="received_withd_msg">'+
                '<p>'+message+'</p>'+
                '<span class="time_date">'+"Now"+'</span></div>'+
                '</div></div>'
            );

        }



    }else{

        console.log("this is not for you")
    }

    }

function connect_first(url) {
    console.log("js connect");

    var socket = new SockJS('/gs-guide-websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/greetings/', function (greeting) {
            showGreeting2(JSON.parse(greeting.body).sender,JSON.parse(greeting.body).receiver,JSON.parse(greeting.body).content, );
            // console.log(JSON.parse(greeting.body));


        });
        // stompClient.subscribe('/topic/greetings/position-updates/', function (greeting) {
        //     showGreeting2(JSON.parse(greeting.body).content);
        // });
    });
}

