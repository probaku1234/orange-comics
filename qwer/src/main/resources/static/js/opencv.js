function makePictureGray (src){
    let dst = new cv.Mat();
    // You can try more different parameters
    cv.cvtColor(src, dst, cv.COLOR_RGBA2GRAY, 0);
    cv.imshow('canvasOutput', dst);
    console.log(dst);
    src.delete();
    //return dst;
    dst.delete();
}

function smoothing (src){
    let dst = new cv.Mat();
    cv.cvtColor(src, src, cv.COLOR_RGBA2RGB, 0);
    // You can try more different parameters
    cv.bilateralFilter(src, dst, 9, 75, 75, cv.BORDER_DEFAULT);
    cv.imshow('canvasOutput', dst);
    src.delete();
    //return dst;
    dst.delete();
}
function ImageCanny (src){
    let dst = new cv.Mat();
    // let dst2 = new cv.Mat();
    cv.Canny(src, dst, 50, 100, 3, false);


    let low = new cv.Mat(dst.rows, dst.cols, dst.type(), [0, 0, 0, 0]);
    let high = new cv.Mat(dst.rows, dst.cols, dst.type(), [205, 230, 80, 255]);
    cv.inRange(dst, low, high, dst);

    cv.imshow('canvasOutput', dst);
    src.delete();low.delete();high.delete();
    //return dst;
    dst.delete();
}