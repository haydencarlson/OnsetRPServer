let currentTarget = {
    id: false,
    amount: false,
    requestId: false
};
$(function () {
    $('.hitman-cancel-button').on('click', function() {
        CallEvent("BRPUI:CancelHit");
    });

    $('.hitman-accept-button').on('click', function() {
        CallEvent("BRPUI:AcceptHit", currentTarget.id, currentTarget.amount, currentTarget.requestId);
    });
});

function ShowHitmanAvailableHits() {
    $('#hitman-available-jobs').show();
    $('#hitman-job-container').show();
}
function ShowHitmanRequestedHit(requestName, amount, targetName, targetJob, targetId, requestId) {
    $('#hitman-job-requester').text(`Requested By: ${requestName}`)
    $('#hitman-job-amount').text(`Payment: $${formatMoney(amount)}`)
    $('#hitman-job-target').text(`Target Name: ${targetName}`)
    $('#hitman-job-target-job').text(`Target Job: ${targetJob}`)
    $('#hitman-job-details').css('display', 'flex');
    $('#hitman-job-details').show();
    $('#hitman-job-container').show();
    currentTarget.id = targetId;
    currentTarget.amount = amount;
    currentTarget.requestId = requestId;
}

function formatMoney(number) {
    let decPlaces = 2;
    let decSep = ".";
    let thouSep = ",";
    var sign = number < 0 ? "-" : "";
    var i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(decPlaces)));
    var j = (j = i.length) > 3 ? j % 3 : 0;

    return sign +
        (j ? i.substr(0, j) + thouSep : "") +
        i.substr(j).replace(/(\decSep{3})(?=\decSep)/g, "$1" + thouSep) +
        (decPlaces ? decSep + Math.abs(number - i).toFixed(decPlaces).slice(2) : "");
}