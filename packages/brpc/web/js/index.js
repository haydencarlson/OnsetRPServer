let CallEvent;
let companyAppDisplayed = false;
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


function toggleCompanyUI() {
  if (!companyAppDisplayed) {
    $('#taskbar-company').hide();
    $('#company-app').show();
  } else {
    $('#taskbar-company').show();
    $('#company-app').hide();
  }
  companyAppDisplayed = !companyAppDisplayed
}

$(function() {
  let currentOpenElement = "company-app-info";

  $('#company-info-nav').on('click', function() {
    $(`#${currentOpenElement}`).hide();
    $('#company-app-info').show();
    currentOpenElement = "company-app-info";
  })

  $("#upgrades-nav").on('click', function() {
    $(`#${currentOpenElement}`).hide();
    $('#owner-company-upgrades').show();
    currentOpenElement = "owner-company-upgrades";
  })

  $("#employees-nav").on('click', function() {
    $(`#${currentOpenElement}`).hide();
    $('#company-app-employees').show();
    currentOpenElement = "company-app-employees";
  });

  $("#hire-employees-nav").on('click', function() {
    $(`#${currentOpenElement}`).hide();
    $('#owner-company-hire').show();
    currentOpenElement = "owner-company-hire";
  });

  $('#company-app-icon').on('click', function() {
    toggleCompanyUI();
  });

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
}

function HydrateUI(data) {
  pcdata = data
  const PCData = JSON.parse(data);
  const companyEmployees = PCData.company.employees;
  const companyUpgrades = PCData.company.upgrades;
  const companyName = PCData.company.name;
  const companyOwnerName = PCData.company.owner_name;
  const companyBitcoinBalance = PCData.company.bitcoin_balance;
  const nearPlayers = PCData.near_players;
  const availableUpgrades = [];
  const totalUpgrades = companyUpgrades.length - availableUpgrades.length;
  
  // If player is employee
  if (PCData.company.employee_id) {
    $('#employees-nav').hide();
    $('#hire-employees-nav').hide();
    $('#upgrades-nav').hide()
  }

  if (companyEmployees.length) {
    $('#company-no-employees').hide();
    $('#table-employees').show();
  }

  AddNearPlayerestHireSelect(nearPlayers);
  AddCompanyUpgradesToSelect(availableUpgrades, companyUpgrades);
  AddCompanyEmployeesToTable(companyEmployees);

  $('#company-name').text(companyName);
  $('#company-owner').text(companyOwnerName);
  $('#company-employees').text(companyEmployees.length);
  $('#company-upgrades').text(totalUpgrades);
  $('#company-bitcoin-account-balance').text(`${companyBitcoinBalance} BTC`);

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
