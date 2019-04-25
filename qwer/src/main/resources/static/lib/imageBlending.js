

var image_set = {base:null, src:null};

function changeImageSet() {
    var base = document.getElementById("_mask");
    var image = document.getElementById("_img");
    console.log(base)
    image_set.base = base.src;
    image_set.src = image.src;
    initializeCanvas();
}
function changeImageSet2() {
    var base = document.getElementById("_hand");
    var image = document.getElementById("_sign");
    image_set.base = base.src;
    image_set.src = image.src;
    initializeCanvas();
}

window.onload = function() {
    base_canvas = document.getElementById("base-canvas");
    src_canvas = document.getElementById("src-canvas");
    mask_canvas = document.getElementById("mask-canvas");
    result_canvas = document.getElementById("result-canvas");

    base_ctx = base_canvas.getContext("2d");
    src_ctx = src_canvas.getContext("2d");
    mask_ctx = mask_canvas.getContext("2d");
    result_ctx = result_canvas.getContext("2d");

    window.onscroll = function(){ calMaskCanvasOffset(); };

    initializeCanvas();
};
