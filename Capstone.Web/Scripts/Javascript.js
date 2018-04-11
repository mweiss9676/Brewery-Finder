$(document).ready(function () {
    $('#ageSubmit').click(function () {

        let date = new Date($('.ageCheckerForm').val());

        let birthday = Math.abs(date.getTime());

        let today = Date.now();

        let difference = Math.floor((today - birthday) / 31556952000);

        if (difference >= 21) {
            $('.ageCheckerDiv').css({
                zIndex: '-10'
            });
        } else {
            alert("You must be 21 years old to view this site.");
        }
    });

});