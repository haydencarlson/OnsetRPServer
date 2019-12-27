var updateName = function(text) {
    var element = document.getElementById("playername");
    element.innerHTML = text;
}
var updateHealth = function(text) {
    var element = document.getElementById("health");
    element.innerHTML = text;
}
var updateHunger = function(text) {
    var element = document.getElementById("hunger");
    element.innerHTML = text;
}
var updateArmor = function(text) {
    var element = document.getElementById("armor");
    element.innerHTML = text;
}

var updateThirst = function(text) {
    var element = document.getElementById("thirst");
    element.innerHTML = text;
}

var updateCash = function(text) {
    var element = document.getElementById("cash");
    element.innerHTML = "$" + Number(text).toFixed(2).toString();
}

var updateBank = function(text) {
    var element = document.getElementById("bank");
    element.innerHTML = "$" + Number(text).toFixed(2).toString();
}

var updateJob = function(text) {
    var element = document.getElementById("job");
    element.innerHTML = text;
}
