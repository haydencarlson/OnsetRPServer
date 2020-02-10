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

let jobArray = [];

$(function () {
    var selectedJob = false;
    $('body').on('click', '.job-selection-job-item', function () {
        let jobName = $(this).data('job');
        let job = jobArray.find(job => job.jobName === jobName);
        $('.job-selection-job-item').removeClass('selected');
        $(this).addClass('selected');
        $('#job-selection-select-a-job').hide();
        $('#job-selection-job-select').show();
        $('#job-selection-description').show();
        $('#job-selection-title').show();
        $('#job-selection-description').text(job.jobDescription);
        $('#job-selection-title').text(job.jobName.charAt(0).toUpperCase() + job.jobName.slice(1));
        selectedJob = job.jobName;
    });

    $('#job-selection-job-select').on('click', function () {
        let job = jobArray.find(job => job.jobName === selectedJob);
        $('#job-selection-job-items').hide();
        $('#job-info-container').show();
        $('#job-selection-job-select').hide();
        $('#job-selection-continue').show();
        $('#job-selection-description').hide();
        $('#job-info-information').text(job.jobDescription);
        if (job.commands.length) {
            $('#job-info-flex').prepend(`
            <h3 id="job-info-job-commands-text">
            Job Commands
            </h3>
            `);
            job.commands.forEach((command) => {
                $('#job-info-commands').append(`
                <div class="job-info-command">
                ${command}
                </div>
                `);
            });
        }
    });
    
    $('#job-selection-continue').on('click', function() {
        $('#job-selection-job-items').show();
        $('#job-info-container').hide();
        $('#job-selection-continue').hide();
        $('#job-selection-title').hide();
        $('#job-selection-select-a-job').show();
        $('#job-info-job-commands-text').remove();
        $('#job-info-commands').empty();
        CallEvent("SelectJob", selectedJob)
        CallEvent("Hide:BRPUI")
    });
});
function ShowJobSelection() {
    $('#job-selection-ui').show();
}

function AddJobToSelection(jobJson) {
    let job = JSON.parse(jobJson)
    $('#job-selection-job-items').append(`
        <div data-job="${job.jobName}" class="job-selection-job-item">
            <span id="job-selection-job-name">${job.jobName.charAt(0).toUpperCase() + job.jobName.slice(1)}</span>
            <span id="job-selection-job-players">${job.jobCurrentPlayers} / ${!job.jobLimit ? "&infin;" : job.jobLimit}</span>
        </div>
    `);
    jobArray.push(job);
}

function JobSelectSetup() {
    $('#job-selection-job-items').empty();
}

function HideJobSelection() {
    $('#job-selection-ui').hide();
}