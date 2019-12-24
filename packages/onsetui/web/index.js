
var updateText = function(text) {
    var element = document.getElementById("header");
    element.innerHTML = text;
}

var texttips = ['You can press F2 to', 'You can press F3 to', 'You can press F4 to', 'You can press F5 to'];

textSequence(0);
function textSequence(i) {

    if (texttips.length > i) {
        setTimeout(function() {
            document.getElementById("tips").innerHTML = texttips[i];
            textSequence(++i);
        }, 3000);

    } else if (texttips.length == i) {
        textSequence(0);
    }

}
