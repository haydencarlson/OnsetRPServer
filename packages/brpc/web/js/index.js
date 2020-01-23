function showCompanyUI() {
  var x = document.getElementById('company-app');
  var y = document.getElementById('taskbar-company');
  var IsInContainer = document.getElementById("taskbar-company").getElementsByClassName("taskbar-container")[0];
  if (x.style.top === '-4000px' | IsInContainer) {
    x.style.top = '40px';
    $("#taskbar-company").appendTo("#taskbar-apps"); 
  } else {
    x.style.top = '-4000px';
    $("#taskbar-company").appendTo("#taskbar-container"); 
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
    $("#taskbar-company").appendTo("#taskbar-container");
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
  const companyName = PCData.company.name;
  const companyNameEmployee = PCData.company.name;
  const companyEmployeeId = PCData.company.employee_id;
  const companyId = PCData.company.company_id;
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
  $('#company-name').text(companyName);
  $('#company-name-employee').text(companyNameEmployee);
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

  if ((PCData.company.employee_id) === (PCData.company.company_id)) {
    $('#company-app-employees').show();
    $('#owner-company-hire').show();
    $('#employees-nav').show();
    $('#hire-employees-nav').show();
      } else {
    $('#company-app-employees').hide();
    $('#owner-company-hire').hide();;
    $('#employees-nav').hide();
    $('#hire-employees-nav').hide();
  }

  if (companyEmployees.length) {
    $('#company-no-employees').hide();
    $('#table-employees').show();
  }
}

function CompanyTaskBar() {
  var x = document.getElementById('company-app');
  if (x.style.top === '40px') {
    x.style.top = '-4000px';
    $("#taskbar-company").appendTo("#taskbar-apps"); 
  } else {
    x.style.top = '40px';
    $("#taskbar-company").appendTo("#taskbar-apps"); 
  }
}

var updateTime = function(text) {
  var element = document.getElementById("time");
  element.innerHTML = text;
}
