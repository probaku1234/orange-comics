$(document).ready(function(){
    var canvas = new fabric.Canvas('canvas');
    canvas.setWidth( 460 );
    canvas.setHeight( 582 );
    canvas.calcOffset();
    // canvas.setDimensions({width: '100%', height: '100%'}, {cssOnly: true});

    $('#dropdownMenuButton').click(function(){
        var text = new fabric.Text('hello world', { left: 0, top: 0 });
        canvas.add(text);
    });

    $('#drop a').on('click', function () {
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
            case "straight_line":
                canvas.add(new fabric.Line([50, 100, 200, 200], {
                    left: 170,
                    top: 150,
                    stroke: 'orange'
                }));
                break;
        }
    });
})