
var updateText = function(text) {
    var element = document.getElementById("header");
    element.innerHTML = text;
}

var texttips = [
    'You can press G to access your GPS', 
    'You can press F1 near a door to purchase a house', 
    'You can get a job near the spawn from the job manager', 
    'Push K to pull out your phone and add contacts'
];

document.getElementById("tips").innerHTML = texttips[0];
textSequence(1);
function textSequence(i) {
    if (i < texttips.length) {
        setTimeout(function() {
            document.getElementById("tips").innerHTML = texttips[i];
            return textSequence(++i);
        }, 3000);

    } else if (texttips.length == i) {
        return textSequence(0);
    }
}
