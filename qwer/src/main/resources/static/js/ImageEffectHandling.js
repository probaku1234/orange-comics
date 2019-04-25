window.onload = function() {
    // base_canvas = document.getElementById("base-canvas");
    // src_canvas = document.getElementById("src-canvas");
    // mask_canvas = document.getElementById("mask-canvas");
    // result_canvas = document.getElementById("result-canvas");

    // base_ctx = base_canvas.getContext("2d");
    // src_ctx = src_canvas.getContext("2d");
    // mask_ctx = mask_canvas.getContext("2d");
    // result_ctx = result_canvas.getContext("2d");

    window.onscroll = function(){ calMaskCanvasOffset(); };

    initializeCanvas();
};
var image_set = {base:null, src:null};
$(document).ready(function(){

    $("#cartoonize").click(function(){

        console.log(mouseUpObject);

        let img1 =mouseUpObject.target._objects[0]._originalElement
        let img2 =mouseUpObject.target._objects[1]._originalElement




        mouseUpObject.target._objects[0]._originalElement.setAttribute('crossOrigin','Anonymous');
        // mouseUpObject.target._objects[0]._element.src = mouseUpObject.target._objects[0]._element.src + '?' + new Date().getTime();
        mouseUpObject.target._objects[1]._originalElement.setAttribute('crossOrigin','Anonymous');
        // mouseUpObject.target._objects[1]._element.src = mouseUpObject.target._objects[0]._element.src + '?' + new Date().getTime();
        image_set.base = img1.src;
        image_set.src = img2.src;


        base_canvas = document.getElementById("base-canvas");
        src_canvas = document.getElementById("src-canvas");
        mask_canvas = document.getElementById("mask-canvas");
        result_canvas = document.getElementById("result-canvas");

        base_ctx = base_canvas.getContext("2d");
        src_ctx = src_canvas.getContext("2d");
        mask_ctx = mask_canvas.getContext("2d");
        result_ctx = result_canvas.getContext("2d");
        console.log(base_ctx);
        console.log(src_ctx);
        console.log(mask_ctx);
        console.log(result_ctx);
        window.onscroll = function(){ calMaskCanvasOffset(); };
        initializeCanvas();
    });

});
