function showCompanyUI() {
  var x = document.getElementById('company-app');
  var y = document.getElementById('taskbar-company');
  if (x.style.top === '-4000px' | y.style.top === '50px') {
    x.style.top = '40px';
    y.style.top = '0px'
  } else {
    x.style.top = '-4000px';
    y.style.top = '50px'
  }
}

function TaskbarStart() {
  var x = document.getElementById('company-app');
  var y = document.getElementById('company-app-info');
  var z = document.getElementById('owner-company-upgrades');
  var w = document.getElementById('taskbar-company');
  var v = document.getElementById('company-app-employees');
  var u = document.getElementById('owner-company-hire');
  if (x.style.top === '40px') {
    x.style.top = '-4000px';
    y.style.top = '-4000px';
    z.style.top = '4000px';
    w.style.top = '50px';
    v.style.top = '-4000px';
    u.style.top = '4000px';
  }
}
function CompanyInfo() {
var x = document.getElementById('company-app-info');
var y = document.getElementById('owner-company-upgrades');
var z = document.getElementById('company-app-employees');
var v = document.getElementById('owner-company-hire');
if (x.style.top === '-4000px' | y.style.top === "-65px" | z.style.top === "-65px" | v.style.top === '-65px') {
  x.style.top = '-65px';
  y.style.top = '4000px';
  z.style.top = '-4000px';
  v.style.top = '4000px';
} else {
  x.style.top = '-65px';
  y.style.top = '4000px';
  z.style.top = '-4000px';
  v.style.top = '4000px';
  }
}

function CompanyUpgrades() {
  var y = document.getElementById('owner-company-upgrades');
  var x = document.getElementById('company-app-info');
  var z = document.getElementById('company-app-employees');
  var v = document.getElementById('owner-company-hire');
  if (x.style.top === '-65px' | y.style.top === "4000px" | z.style.top === "-65px" | v.style.top === '-65px') {
    x.style.top = '-4000px';
    y.style.top = '-65px';
    z.style.top = '-4000px';
    v.style.top = '4000px';
  } else {
    x.style.top = '-4000px';
    y.style.top = '-65px';
    z.style.top = '-4000px';
    v.style.top = '4000px';
  }
}

function CompanyEmployees() {
  var y = document.getElementById('owner-company-upgrades');
  var x = document.getElementById('company-app-info');
  var z = document.getElementById('company-app-employees');
  var v = document.getElementById('owner-company-hire');
  if (x.style.top === '-65px' | y.style.top === "-65px" | z.style.top === "-4000px" | v.style.top === '-65px') {
    x.style.top = '-4000px';
    y.style.top = '4000px';
    v.style.top = '4000px';
    z.style.top = '-65px';
  } else {
    x.style.top = '-4000px';
    y.style.top = '4000px';
    v.style.top = '4000px';
    z.style.top = '-65px';
  }
}
function HireEmployees() {
  var v = document.getElementById('owner-company-hire');
  var y = document.getElementById('owner-company-upgrades');
  var x = document.getElementById('company-app-info');
  var z = document.getElementById('company-app-employees');
  if (x.style.top === '-65px' | y.style.top === '-65px' | z.style.top === '-65px' | v.style.top === '4000px') {
    x.style.top = '-4000px';
    y.style.top = '4000px';
    z.style.top = '-4000px';
    v.style.top = '-65px';
  } else {
    x.style.top = '-4000px';
    y.style.top = '4000px';
    z.style.top = '-4000px';
    v.style.top = '-65px';
  }
}

function CompanyTaskBar() {
  var x = document.getElementById('company-app');
  if (x.style.top === '40px') {
    x.style.top = '-4000px';
  } else {
    x.style.top = '40px';
  }
}

var updateTime = function(text) {
  var element = document.getElementById("time");
  element.innerHTML = text;
}
