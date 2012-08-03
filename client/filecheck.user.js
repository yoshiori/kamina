// ==UserScript==
// @name        filecheck userscript !
// @namespace   http://github.com/yoshiori/
// @description http://github.com/yoshiori/ のクライアント側
// @include     http://localhost:*/*
// ==/UserScript==
function loadSocketIo(callback) {
    console.log("loadSocketIo" + document.body);
    socket_io_src = "http://localhost:3002/socket.io/socket.io.js";
    console.log(socket_io_src);
    var socket_io_script = document.createElement("script");
    socket_io_script.setAttribute("src", socket_io_src);
    socket_io_script.addEventListener("load", function(){
        console.log("script loaded")
        var script = document.createElement("script");
        script.textContent = "(" + callback.toString() + ")();";
        document.body.appendChild(script);
    }, false);
    socket_io_script.addEventListener("error", function(){
        console.log("error!!!")
    }, false);
    document.body.appendChild(socket_io_script);
};
console.log("start")
loadSocketIo(
    function(){
        var socket = io.connect('http://localhost:3002/');
        socket.on('change', function() {
            location.reload(true);
        });
    }
);

