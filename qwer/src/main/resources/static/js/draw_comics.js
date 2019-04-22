$(document).ready(function(){
    let canvas = new fabric.Canvas('canvas', {preserveObjectStacking: true});
    let ctx = canvas.getContext('2d');
    let jsonPageArray = new Array();
    let currentPageIndex = 0;
    let isRedoing = false;
    let h = [];
    let selectedObject;
    
    canvas.setWidth( 460 );
    canvas.setHeight( 582 );
    canvas.calcOffset();
    // canvas.setDimensions({width: '100%', height: '100%'}, {cssOnly: true});
    jsonPageArray.push(JSON.stringify(canvas));

    $(".nav-tabs").on("click", "a", function (e) {
        e.preventDefault();
        if (!$(this).hasClass('add-page')) {
            saveCanvas();
            currentPageIndex = $(this).parent().index();
            restoreCanvas(currentPageIndex);
            console.log($(this).parent().index());
        }
    })
        .on("click", "button", function () {
            if (currentPageIndex > 0) {
                saveCanvas();
                var anchor = $(this).siblings('a');
                var index = $(this).parent().index();
                $(anchor.attr('href')).remove();
                $(this).parent().remove();
                $(".nav-tabs li").children('a').first().click();
                jsonPageArray.splice(index,1);
                if (currentPageIndex == index) {
                    currentPageIndex -= 1;
                    restoreCanvas(currentPageIndex);
                }
                console.log(currentPageIndex);
            }
        });


    $('.add-page').click(function (e) {
        e.preventDefault();
        let id = $(".nav-tabs").children().length; //think about it ;)
        let tabId = 'page' + id;
        let canvas_num = 'canvas' + id;

        $(this).closest('li').before('<li><a href="#page' + id + '">Page ' + id + '</a> <button> x </button></li>');

        saveCanvas();
        jsonPageArray.push('{"version":"2.4.6","objects":[]}');

        console.log($(".nav-tabs").children().closest('a').attr('id'));

        $('.nav-tabs li:nth-child(' + id + ') a').click();
    });

    canvas.on('object:added',function(){
        if(!isRedoing){
            h = [];
        }
        isRedoing = false;
    });

    canvas.on("object:selected", function (event) {
        console.log(event.target);
        selectedObject = event.target;
    });

    $("#undo").click(function () {
        if(canvas._objects.length>0){
            h.push(canvas._objects.pop());
            canvas.renderAll();
        }
    });
    
    $("#redo").click(function () {
        if(h.length>0){
            isRedoing = true;
            canvas.add(h.pop());
        }
    });

    $('#dropdownMenuButton').click(function(){
        var textbox = new fabric.Textbox('hello world', {
            left: 50,
            top: 50,
            width: 150,
            fontSize: 20,
            textAlign: 'center'
        });

        canvas.add(textbox).setActiveObject(textbox);
    });

    $('html').keyup(function(e){
        if(e.keyCode == 46) {
            var activeObjects = canvas.getActiveObjects();
            activeObjects.forEach(function (object) {
                canvas.remove(object);
            });
            canvas.discardActiveObject();
        }
        if(e.keyCode == 39) {
            console.log("right");
            if (currentPageIndex < jsonPageArray.length-1) {
                saveCanvas();
                currentPageIndex += 1;
                restoreCanvas(currentPageIndex);
            }
        }
        if (e.keyCode == 37) {
            console.log("left");
            if (currentPageIndex > 0) {
                saveCanvas();
                currentPageIndex -= 1;
                restoreCanvas(currentPageIndex);
            }
        }
    });

    $('#dropdownMenuButton3').on("click", function(){
        var line;
        var isDrawing;

        canvas.on('mouse:down', function (o) {
            isDrawing = true;
            var pointer = canvas.getPointer(o.e);
            var points = [pointer.x, pointer.y, pointer.x, pointer.y];

            line = new fabric.Line(points, {
                strokeWidth: 3,
                stroke: 'black'
            });
            canvas.add(line).setActiveObject(line);
        });


        canvas.on('mouse:move', function (o) {
            if (isDrawing) {
                var pointer = canvas.getPointer(o.e);
                line.set({ x2: pointer.x, y2: pointer.y });
                canvas.renderAll();
            }
        });

        canvas.on('mouse:up', function (o) {
            isDrawing = false;
            canvas.off('mouse:move');
            canvas.off('mouse:down');
            canvas.off('mouse:up');
        });


    });

    $('#shapes a').on('click', function () {
        var value = $(this).attr('value');

        switch (value) {
            case "rectangle":
                var rect = new fabric.Rect({
                    width: 60, height: 45, fill: 'orange', left: 100, top: 100
                });
                canvas.add(rect).setActiveObject(rect);
                break;
            case "circle":
                var circle = new fabric.Circle({
                    radius: 40, fill: 'orange', left: 70, top: 200
                });
                canvas.add(circle).setActiveObject(circle);
                break;
            case "triangle":
                var triangle = new fabric.Triangle({
                    radius: 15, fill: 'orange', left: 120, top: 250
                });
                canvas.add(triangle).setActiveObject(triangle);
                break;
        }
    });

    $('#speech_bubbles a').on('click', function () {
        var value = $(this).attr('value');

        switch (value) {
            case "bubble1":
                var circle = new fabric.Circle({
                    radius: 100,
                    fill: '#eef',
                    scaleY: 0.5,
                    originX: 'center',
                    originY: 'center'
                });

                var text = new fabric.Textbox('hello world', {
                    fontSize: 30,
                    originX: 'center',
                    originY: 'center'
                });

                var group = new fabric.Group([ circle, text ], {
                    left: 150,
                    top: 100,
                    angle: -10
                });

                canvas.add(group).setActiveObject(group);
                break;
            case "bubble2":

                canvas.add().setActiveObject();
                break;
            case "bubble3":

                canvas.add().setActiveObject();
                break;
        }
    });

    $('#premade_images a').on('click', function () {
        var value = $(this).attr('value');

        switch (value) {
            case "add_premade1":
                var imageUrl = 'https://www.pinclipart.com/picdir/big/91-910919_mule-clipart-shrek-character-donkey-from-shrek-png.png';
                fabric.Image.fromURL(imageUrl, function(oImg) {
                    oImg.scale(0.5).set('flipX', true);
                    canvas.add(oImg).setActiveObject(oImg);
                });
                break;
            case "add_premade2":
                var imageUrl = 'https://www.pinclipart.com/picdir/big/202-2020508_shrek-face-png-shrek-pixel-art-maker-pixel.png';
                fabric.Image.fromURL(imageUrl, function(oImg) {
                    oImg.scale(0.2).set('flipX', true);
                    canvas.add(oImg).setActiveObject(oImg);
                });
                break;
            case "add_premade3":
                var imageUrl = 'https://www.pinclipart.com/picdir/big/194-1949751_newest-version-of-pixel-art-maker-sans-clipart.png';
                fabric.Image.fromURL(imageUrl, function(oImg) {
                    oImg.scale(0.5).set('flipX', true);
                    canvas.add(oImg).setActiveObject(oImg);
                });
                break;
        }
    });

    $("#addBackgroundButton").click(function () {
        var imageUrl = $('#addBackgroundFromURL').val();

        fabric.Image.fromURL(imageUrl, function(img) {
            canvas.setBackgroundImage(img, canvas.renderAll.bind(canvas), {
                // Needed to position backgroundImage at 0/0
                scaleX: canvas.width / img.width,
                scaleY: canvas.height / img.height
            });
        });
    });

    $("#addImageButton").click(function () {
        var imageUrl = $('#addImageFromURL').val();
        fabric.Image.fromURL(imageUrl, function(oImg) {
            oImg.scale(0.5).set('flipX', true);
            canvas.add(oImg);
        });
    });

    $("#new_page").click(function () {
        saveCanvas();
        jsonPageArray.push('{"version":"2.4.6","objects":[]}');
    });

    $("#delete_page").click(function () {
        if (currentPageIndex > 0) {
            jsonPageArray.splice(currentPageIndex,1);
            currentPageIndex -= 1;
            restoreCanvas(currentPageIndex);
        }
    });

    $("#save_button").click(function () {
        saveCanvas();
        console.log(jsonPageArray.toString());
        var comic_name = $("#dropdownComicListButton").text();
        var chapter = $("#dropdownChapterListButton").text();
        $.ajax({
            type: "POST",
            url: "/save_draft",
            data: {
                "jsonArray" : JSON.stringify(createJSONObjectArray(jsonPageArray)),
                "comic_name" : comic_name,
                "chapter" : chapter
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
            }
        });
    });
    
    $("#free_draw").click(function () {
        if (canvas.isDrawingMode == false) {
            canvas.isDrawingMode = true;
        } else {
            canvas.isDrawingMode = false;
        }
    });

    $("#send_back").click(function () {
        canvas.sendToBack(selectedObject);
    });

    $("#send_front").click(function () {
        canvas.bringToFront(selectedObject);
    });

    $(document).on('click', '#chapter_list a', function () {
        var value = $(this).attr("value");
        value = parseInt(value,10) + 1;
        $(this).parents('.dropdown').find('.dropdown-toggle').html(value);
        var comic_name = $("#dropdownComicListButton").text();
        var chapter = $("#dropdownChapterListButton").text();

        $.ajax({
            type: "POST",
            url: "/load_draft",
            data: {
                "comic_name" : comic_name,
                "chapter" : chapter
            },
            dataType: 'json',
            success: function (array) {
                jsonPageArray.length = 0;
                for (var i = 0; i < array.length; i++) {
                    jsonPageArray.push(array[i]);
                    // add tabs
                    if (i > 0) {
                        var id = $(".nav-tabs").children().length;
                        $(".add-page").closest('li').before('<li><a href="#page' + id + '">Page ' + id + '</a> <button> x </button></li>');
                    }
                }
                restoreCanvas(0);
                currentPageIndex = 0;

                console.log("load pages done");
            }
        });
    });

    function sortPages() {
        var id = $(".nav-tabs").children().length;
        for (var i = 0; i < id; i++) {

        }
    }

    function saveCanvas() {
        jsonPageArray[currentPageIndex] = JSON.stringify(canvas);
    }

    function restoreCanvas(index) {
        canvas.loadFromJSON(jsonPageArray[index]);
    }
    
    function createJSONObjectArray() {
        var jsonObjectArray = new Array();
        for (var i = 0; i <  jsonPageArray.length; i++) {
            var obj = JSON.parse(jsonPageArray[i]);
            jsonObjectArray.push(obj);
        }
        return jsonObjectArray;
    }
});
