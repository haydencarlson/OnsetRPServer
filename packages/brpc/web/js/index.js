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

function HydrateUI(data) {
  pcdata = data
  const PCData = JSON.parse(data);
  const companyEmployees = PCData.company.employees;
  const companyUpgrades = PCData.company.upgrades;
  const companyOwnerName = PCData.company.owner_name;
  const companyBitcoinBalance = PCData.company.bitcoin_balance;
  const availableUpgrades = [];
  $('#upgrades').empty()
  $('#company-employees-tbody').empty();
  companyUpgrades.forEach((upgrade) => {
    if (upgrade.available == "0") {
      $('#upgrades').append(`
        <option value=${upgrade.name} id='${upgrade.name}'>${upgrade.friendly_name}</option>
      `);
      availableUpgrades.push(upgrade.name);
    }
  });
  const totalUpgrades = companyUpgrades.length - availableUpgrades.length;
  $('#company-owner').text(companyOwnerName);
  $('#company-employees').text(companyEmployees.length);
  $('#company-upgrades').text(totalUpgrades);
  $('#company-bitcoin-account-balance').text(`${companyBitcoinBalance} BTC`);
  companyEmployees.forEach((employee) => {
    $('#company-employees-tbody').append(`
    <tr>
      <td>${employee.name}</td>
      <td>$5000</td>
      <td><button type="button" class="btn btn-danger btn-sm"><i class="fas fa-times-circle"></i></button></td>
    </tr>
    `);
  });
  if (companyEmployees.length) {
    $('#company-no-employees').hide();
    $('#table-employees').show();
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
