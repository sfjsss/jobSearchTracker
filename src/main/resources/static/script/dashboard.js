$(document).ready(function() {
    console.log("js is working");
    $(".progress").animate({width: "100%"}, 1000);

    console.log($("#modalError").html());
    if ($("#modalError").html()) {
        $('#addApplication').modal('show');
    };
})