let CallEvent;
(function (obj) {
  ue.game = {};
  ue.game.callevent = function (name, ...args) {
    if (typeof name != "string") {
      return;
    }

    if (args.length == 0) {
      obj.callevent(name, "")
    } else {
      let params = []
      for (let i = 0; i < args.length; i++) {
        params[i] = args[i];
      }
      obj.callevent(name, JSON.stringify(params));
    }
  };
  CallEvent = ue.game.callevent;
})(ue.game);


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
$(function() {
  $('#hireEmployeeBtn').on('click', function() {
    var selected = $('#HireEmployee option:selected');
    if (selected.length === 1) {
      CallEvent("BRPC:HirePlayer", selected.val());
    }
  });

  $('#company-app-employees').on('click', '.firePlayerButton', function() {
    let playerId = $(this).attr('data-account-id');
    if (playerId) {
      CallEvent("BRPC:FirePlayer", playerId)
      let playerOption = $(`[data-employee-account-id=${playerId}]`);
      playerOption.remove();
    }
  });

  $('#upgradebtn').on('click', function () {
    var selected = $('#upgrades option:selected');
    if (selected.length === 1) {
      CallEvent("BRPC:PurchaseUpgrade", selected.val())
    }
  });
})

function AddNearPlayerestHireSelect(nearPlayers) {
  $('#HireEmployee').empty();
  nearPlayers.forEach((player) => {
    $('#HireEmployee').append(`
        <option value=${player.id} id='${player.name}'>${player.name}</option>
    `);
  })
}

function RemoveUpgradeFromSelect(upgrade) {
  $(`#${upgrade}`).remove();
}

function AddCompanyUpgradesToSelect(availableUpgrades, companyUpgrades) {
  $('#upgrades').empty()
  companyUpgrades.forEach((upgrade) => {
    if (upgrade.available == "0") {
      $('#upgrades').append(`
        <option value=${upgrade.name} id='${upgrade.name}'>${upgrade.friendly_name}</option>
      `);
      availableUpgrades.push(upgrade.name);
    }
  });
}

function AddCompanyEmployeesToTable(companyEmployees) {
  $('#company-employees-tbody').empty();
  companyEmployees.forEach((employee) => {
    $('#company-employees-tbody').append(`
    <tr data-employee-account-id=${employee.id}>
      <td>${employee.name}</td>
      <td>${Number(employee.earn_percentage) * 100}%</td>
      <td><button type="button" data-account-id="${employee.id}" class="btn btn-danger btn-sm firePlayerButton"><i class="fas fa-times-circle"></i></button></td>
    </tr>
    `);
  });
  if (companyEmployees.length) {
    $('#company-no-employees').hide();
    $('#table-employees').show();
  }
}

function HydrateUI(data) {
  pcdata = data
  const PCData = JSON.parse(data);
  const companyEmployees = PCData.company.employees;
  const companyUpgrades = PCData.company.upgrades;
  const companyOwnerName = PCData.company.owner_name;
  const companyBitcoinBalance = PCData.company.bitcoin_balance;
  const nearPlayers = PCData.near_players;
  const availableUpgrades = [];
  const totalUpgrades = companyUpgrades.length - availableUpgrades.length;

  AddNearPlayerestHireSelect(nearPlayers);
  AddCompanyUpgradesToSelect(availableUpgrades, companyUpgrades);
  AddCompanyEmployeesToTable(companyEmployees);

  $('#company-owner').text(companyOwnerName);
  $('#company-employees').text(companyEmployees.length);
  $('#company-upgrades').text(totalUpgrades);
  $('#company-bitcoin-account-balance').text(`${companyBitcoinBalance} BTC`);

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
