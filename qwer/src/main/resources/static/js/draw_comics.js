$(document).ready(function(){
    var canvas = new fabric.Canvas('canvas');
    var ctx = canvas.getContext('2d');

    canvas.setWidth( 460 );
    canvas.setHeight( 582 );
    canvas.calcOffset();
    // canvas.setDimensions({width: '100%', height: '100%'}, {cssOnly: true});

    $('#dropdownMenuButton').click(function(){
        var textbox = new fabric.Textbox('hello world', { left: 50,
            top: 50,
            width: 150,
            fontSize: 20,
            textAlign: 'center'
        });

        canvas.add(textbox).setActiveObject(textbox);
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
            canvas.add(line);
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
                canvas.add(rect);
                break;
            case "circle":
                var circle = new fabric.Circle({
                    radius: 40, fill: 'orange', left: 70, top: 200
                });
                canvas.add(circle);
                break;
            case "triangle":
                var triangle = new fabric.Triangle({
                    radius: 15, fill: 'orange', left: 120, top: 250
                });
                canvas.add(triangle);
                break;
        }
    });

    $('#speech_bubbles a').on('click', function () {
        var value = $(this).attr('value');

        switch (value) {
            case "bubble1":
                drawBubble(ctx, 10,60,220, 90, 20);
                break;
            case "bubble2":

                canvas.add();
                break;
            case "bubble3":

                canvas.add();
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
                    canvas.add(oImg);
                });
                break;
            case "add_premade2":
                var imageUrl = 'https://www.pinclipart.com/picdir/big/202-2020508_shrek-face-png-shrek-pixel-art-maker-pixel.png';
                fabric.Image.fromURL(imageUrl, function(oImg) {
                    oImg.scale(0.2).set('flipX', true);
                    canvas.add(oImg);
                });
                break;
            case "add_premade3":
                var imageUrl = 'https://www.pinclipart.com/picdir/big/194-1949751_newest-version-of-pixel-art-maker-sans-clipart.png';
                fabric.Image.fromURL(imageUrl, function(oImg) {
                    oImg.scale(0.5).set('flipX', true);
                    canvas.add(oImg);
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
});

function drawBubble(ctx, x, y, w, h, radius)
{
    var r = x + w;
    var b = y + h;
    ctx.beginPath();
    ctx.strokeStyle="black";
    ctx.lineWidth="2";
    ctx.moveTo(x+radius, y);
    ctx.lineTo(x+radius/2, y-10);
    ctx.lineTo(x+radius * 2, y);
    ctx.lineTo(r-radius, y);
    ctx.quadraticCurveTo(r, y, r, y+radius);
    ctx.lineTo(r, y+h-radius);
    ctx.quadraticCurveTo(r, b, r-radius, b);
    ctx.lineTo(x+radius, b);
    ctx.quadraticCurveTo(x, b, x, b-radius);
    ctx.lineTo(x, y+radius);
    ctx.quadraticCurveTo(x, y, x+radius, y);
    ctx.stroke();
}