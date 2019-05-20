let selectedObject;
let mouseUpObject;
let canvas;
$(document).ready(function(){
    canvas = new fabric.Canvas('canvas', { backgroundColor : "#fff", preserveObjectStacking: true});
    let ctx = canvas.getContext('2d');
    let jsonPageArray = new Array();
    let currentPageIndex = 0;
    let isRedoing = false;
    let h = [];
    let selectedObject;

    canvas.setWidth( 471 );
    canvas.setHeight( 600 );
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
        .on("click", "span", function () {
            let anchor = $(this).siblings('a');
            console.log(currentPageIndex);
            if (currentPageIndex > 0) {
                jsonPageArray.splice(currentPageIndex,1);
                restoreCanvas(currentPageIndex);
            }
            $(anchor.attr('href')).remove();
            $(this).parent().parent().remove();
            $(".nav-tabs li").children('a').first().click();
            currentPageIndex = $(this).parent().parent().index();
            $(".remove_button").each(function () {
                var parent = $(this).parent();
                parent.text($(this).parent().parent().index()+1);
                parent.append("<span class='remove_button'> x </span>");
            })
        });


    $('.add-page').click(function (e) {
        e.preventDefault();
        let id = $(".nav-tabs").children().length; //think about it ;)
        let tabId = 'page' + id - 1;
        let canvas_num = 'canvas' + id;

        $(this).closest('li').before('<li class="nav-item"><a class="nav-link page-nav-link" data-toggle="tab" role="tab" aria-controls="home" aria-selected="false" href="#page' + id + '"> ' + id + ' <span class="remove_button"> x </span></a></li>');

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

    $("#post_button").click(function () {
        saveCanvas();
        console.log(jsonPageArray.toString());
        let comic_name = $("#dropdownComicListButton").text();
        let chapter = $("#dropdownChapterListButton").text();
        $.ajax({
            type: "POST",
            url: "/post_request",
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

    $("#addToFabric").click(function () {
        let can = document.getElementById('result-canvas');
        let ctx = can.getContext('2d');

        let _Image = new Image();
        _Image.src= can.toDataURL();
        console.log(_Image)

        fabric.Image.fromURL(_Image.src, function(img) {
            img.left = 50;
            img.top = 50;
            canvas.add(img);
            img.bringToFront();
            canvas.renderAll();
        });
        // let imgInstance = new fabric.Image(_Image, {
        //
        // });
        // canvas.add(imgInstance);
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
                var tab = $("#tab").children();

                tab.each(function (index) {
                    if (index >0 && index < tab.length-1) {
                        $(this).remove();
                    }
                });
                if (array.length == 0) {
                    $(".add-page").closest('li').before('<li class="nav-item"><a class="nav-link page-nav-link" data-toggle="tab" role="tab" aria-controls="home" aria-selected="false" href="#page' + 2 + '"> ' + 2 + ' <span class="remove_button"> x </span></a></li>');
                }
                for (var i = 0; i < array.length; i++) {
                    jsonPageArray.push(array[i]);
                    // add tabs
                    if (i > 0) {
                        var id = $(".nav-tabs").children().length;
                        $(".add-page").closest('li').before('<li class="nav-item"><a class="nav-link page-nav-link" data-toggle="tab" role="tab" aria-controls="home" aria-selected="false" href="#page' + id + '"> ' + id + ' <span class="remove_button"> x </span></a></li>');
                    }
                }
                canvas.clear();
                restoreCanvas(0);
                currentPageIndex = 0;

                console.log("load pages done");
            }
        });
    });

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

    function copy() {
        canvas.getActiveObject().clone(function(cloned) {
            _clipboard = cloned;
        });
    }

    function cut() {
        canvas.getActiveObject().clone(function(cloned) {
            _clipboard = cloned;
        });
        canvas.getActiveObjects().forEach(function (object) {
            canvas.remove(object);
        });
    }

    function paste() {
        _clipboard.clone(function(clonedObj) {
            canvas.discardActiveObject();
            clonedObj.set({
                left: clonedObj.left + 10,
                top: clonedObj.top + 10,
                evented: true,
            });
            if (clonedObj.type === 'activeSelection') {
                // active selection needs a reference to the canvas.
                clonedObj.canvas = canvas;
                clonedObj.forEachObject(function(obj) {
                    canvas.add(obj);
                });
                // this should solve the unselectability
                clonedObj.setCoords();
            } else {
                canvas.add(clonedObj);
            }
            _clipboard.top += 10;
            _clipboard.left += 10;
            canvas.setActiveObject(clonedObj);
            canvas.requestRenderAll();
        });
    }

    document.getElementById("copy").addEventListener("click", copy);
    document.getElementById("cut").addEventListener("click", cut);
    document.getElementById("paste").addEventListener("click", paste);
    //ImageEffect
    canvas.on("mouse:up", function (options) {
        mouseUpObject = options;
        console.log("new12")
        if(options.target != undefined){ // if multiple elements are selected, this function executed.
            console.log(options.target._objects);
            if(options.target._objects != undefined){
                let img1 =options.target._objects[0]
                let img2 =options.target._objects[1]

                if(typeof(img1)== "Img" && typeof(img2)){
                    img1._element.crossOrigin = "anonymous"
                    img2._element.crossOrigin = "anonymous"
                }
            }
        }
    });
    document.getElementById('imgLoader').onchange = function handleImage(e) {
        let reader = new FileReader();
        reader.onload = function (event) { console.log('fdsf');
            let imgObj = new Image();
            imgObj.src = event.target.result;
            imgObj.onload = function () {
                // start fabricJS stuff
                let image = new fabric.Image(imgObj);
                // image.set({
                //     padding: 10,
                // });
                canvas.add(image);
            }

        }
        reader.readAsDataURL(e.target.files[0]);
    }


});

//------------------------------- left tab bar--------------------------------
$(document).ready(function(){
    $(".left-tabs-container .left-tabs").click(function(){
        $index = $(this).index();
        $(".left-tabs-container .left-tabs").eq($index).css('backgroundColor', '#f39c12');
        $(".left-tabs-container .left-tabs").eq($index).css('color', '#333333');
        $(".left-list-container .left-list-items").eq($index).show().siblings().hide();
    });

    window.addEventListener('mouseup', function(event){
        var listArray = ['left-list-new', 'left-list-load', 'left-list-save', 'left-list-post'];
        var tabArray = ['left-tabs-new', 'left-tabs-load', 'left-tabs-save', 'left-tabs-post'];
        var except = document.getElementById('exampleModal');

        if(event.target == except || event.target.parentNode == except || event.target.parentNode.parentNode == except || event.target.parentNode.parentNode.parentNode == except || event.target.parentNode.parentNode.parentNode.parentNode == except || event.target.parentNode.parentNode.parentNode.parentNode.parentNode == except){
            console.log(event.target)
        }
        else {
            for(var i=0; i < listArray.length; i++){
                var list = document.getElementById(listArray[i]);
                var tab = document.getElementById(tabArray[i]);
                if(event.target != list && event.target.parentNode != list && event.target.parentNode.parentNode != list && event.target.parentNode.parentNode.parentNode != list && event.target.parentNode.parentNode.parentNode.parentNode != list && event.target.parentNode.parentNode.parentNode.parentNode.parentNode != list){
                    list.style.display = 'none';
                    tab.style.backgroundColor = '#ffc107';
                    tab.style.color = '#eeeeee';
                }
            }
        }


    });
});

//------------------------------- right tab bar--------------------------------
$(document).ready(function(){
    $(".right-tabs-container .right-tabs").click(function(){
        $index = $(this).index();
        $(".right-tabs-container .right-tabs").eq($index).css('backgroundColor', '#f39c12');
        $(".right-tabs-container .right-tabs").eq($index).css('color', '#333333');
        $(".right-list-container .right-list-items").eq($index).show().siblings().hide();
    });

    window.addEventListener('mouseup', function(event){
        var listArray = ['right-list-title', 'right-list-chapter', 'right-list-save', 'right-list-post'];
        var tabArray = ['right-tabs-title', 'right-tabs-chapter', 'right-tabs-save', 'right-tabs-post'];
        for(var i=0; i < listArray.length; i++){
            var list = document.getElementById(listArray[i]);
            var tab = document.getElementById(tabArray[i]);
            if(event.target != list && event.target.parentNode != list && event.target.parentNode.parentNode != list && event.target.parentNode.parentNode.parentNode != list && event.target.parentNode.parentNode.parentNode.parentNode != list && event.target.parentNode.parentNode.parentNode.parentNode.parentNode != list){
                list.style.display = 'none';
                tab.style.backgroundColor = '#ffc107';
                tab.style.color = '#eeeeee';
            }
        }
    });
});