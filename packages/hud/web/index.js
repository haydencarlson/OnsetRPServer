var updateName = function(text) {
    var element = document.getElementById("playername");
    element.innerHTML = text;
}

var updateHunger = function(text) {
    var element = document.getElementById("hunger");
    element.innerHTML = text;
}

var updateThirst = function(text) {
    var element = document.getElementById("thirst");
    element.innerHTML = text;
}

var updateCash = function(text) {
    var element = document.getElementById("cash");
    element.innerHTML = "$" + Number(text).toFixed(2);
}

var updateBank = function(text) {
    var element = document.getElementById("bank");
    element.innerHTML = "$" + Number(text).toFixed(2);
}

var updateJob = function(text) {
    var element = document.getElementById("job");
    if (text.length) {
        element.innerHTML = text.charAt(0).toUpperCase() + text.slice(1);
    }
}
