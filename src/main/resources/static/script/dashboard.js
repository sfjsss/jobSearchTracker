$(document).ready(function() {
    console.log("js is working");

    let numOfThisWeekApps = $("#numOfThisWeekApps").html();
    let weeklyGoalForApps = $("#weeklyGoalForApps").html();
    let aProgressBarPercent = numOfThisWeekApps/weeklyGoalForApps*100;
    let aProgressBarPercentInStr = aProgressBarPercent + "%";

    $("#aProgress").animate({width: aProgressBarPercentInStr}, 1000);
    $("#eProgress").animate({width: "80%"}, 1000);

    if ($("#modalError").html()) {
        $('#addApplication').modal('show');
    };

    if ($("#flashError").html()) {
        $('#changeWeeklyGoals').modal('show');
    };

    if ($("#editError").html() != "") {
        let editModalId = $("#editError").html();
        console.log(editModalId);
        $(editModalId).modal('show');
    };

    if ($("#noteError").html() != "") {
        let viewModalId = $("#noteError").html();
        $(viewModalId).modal('show');
    };

    if ($("#reminderError").html() != "") {
        let addReminderModalId = $("#reminderError").html();
        $(addReminderModalId).modal('show');
    };
})