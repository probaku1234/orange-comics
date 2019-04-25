<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title></title>
    <script type="text/javascript" src="lib/imageBlending.js"></script>
    <script type="text/javascript" src="lib/blendings.js"></script>
    <link rel="stylesheet" href="/css/blending.css">
    <script src="jquery/jquery-3.3.1.min.js"></script>

    <script async src="https://docs.opencv.org/master/opencv.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/opencv.js"></script>
</head>
<%--<body>--%>
<div id="wrapper">
    <div>
        <div class="inputoutput">
            <img id="imageSrc" alt="No Image" />
            <div class="caption">imageSrc
                <input type="file" id="fileInput" name="file" />
            </div>
        </div>


        <div class="inputoutput">
            <canvas id="canvasOutput" ></canvas>
            <div class="caption">canvasOutput</div>
        </div>
    </div>
    <div>
        <button id="gray">Effect1</button>
        <button id="bilateralFilter">Effect2</button>
        <button id="ImageCanny">Effect3</button>
        <button>Effect4</button>
        <button>Effect5</button>
    </div>

    <div id="aaa" class="clearfix">
        <div>
            <img id="_mask" src="/images/mask.jpg" height="200" width="200" alt="mask">
            <img id="_img" src="/images/air.jpg" height="200" width="200" alt="butterfly">
            <img id="_hand" src="/images/handd.png" height="200" width="200" alt="hand">
            <img id="_sign" src="/images/signn.png" height="200" width="200" alt="sign">
        </div>

        <div>
            <button onclick="changeImageSet()">Image Setting</button>
            <button onclick="changeImageSet2()">Image Setting</button>
        </div>
    </div>
    <div id="steps" class="clearfix">
        <div>
            <span class="strong">Base Image</span><br />
            <canvas id="base-canvas" height="200" width="200"></canvas>
        </div>
        <div>
            <span class="strong">Blend Source Image</span><br />
            <canvas id="src-canvas" height="200" width="200"></canvas>
        </div>
    </div>
    <div>
        <div>
            <h3>Step1</h3>
            &#8595; Draw mask area. <br />
            <canvas id="mask-canvas" height="200" width="200"></canvas><br />
            <button name="adjustBtn" onclick="adjustBlendPosition()">HERE</button>
            <h3>Step2</h3>
            <canvas id="result-canvas" height="200" width="200"></canvas><br />
            Adjust blend position:
            <button name="directionBtn" onclick="moveBlendPosition('up')">&#8593;</button>
            <button name="directionBtn" onclick="moveBlendPosition('right')">&#8594;</button>
            <button name="directionBtn" onclick="moveBlendPosition('down')">&#8595;</button>
            <button name="directionBtn" onclick="moveBlendPosition('left')">&#8592;</button>
            <br />
            <button name="blendBtn" onclick="blendImages()">Blending</button>
        </div>
    </div>
    <div id="footer">
        <button name="resetBtn" onclick="initializeCanvas()">Reset all Canvas</button><br />
    </div>
</div>


<script>
    let imgElement = document.getElementById('imageSrc');
    let inputElement = document.getElementById('fileInput');
    inputElement.addEventListener('change', (e) => {
        imgElement.src = URL.createObjectURL(e.target.files[0]);
    }, false);

</script>
</body>

</html>
