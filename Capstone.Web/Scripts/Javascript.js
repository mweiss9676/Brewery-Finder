$(document).ready(function () {

    $(window).bind("pageshow", function () {

        // Get search from querystring
        let params = (new URL(document.location)).searchParams;

        if (params.has("q")) {
            let query = params.get("q");            
            performSearch(query);
        }

        // Re-run search bar form
        
    });


    $('.ageCheckerContainer').keypress(function (e) {

        let date = new Date($('.ageCheckerForm').val());

        let birthday = Math.abs(date.getTime());

        let today = Date.now();

        let difference = Math.floor((today - birthday) / 31556952000);

        if (e.which == 13) {
            if (difference >= 21) {
                $('.searchBar').focus();
                $('.ageCheckerDiv').css({
                    zIndex: '-10'
                });
                document.cookie = "Over21=true";
            } else {
                alert("You must be 21 years old to view this site.");
            }
        }
    });
    $('.searchBarForm').keypress(function (e) {


        let searchString = $('.searchBar').val();     

        if (e.which == 13 && searchString != "") {
            performSearch(searchString);
        }

    });


    function performSearch(searchString) {
        if (searchString != "") {
            $('.searchBar').addClass('top');
            $('.searchBar').val('');

            var URL = 'http://' + window.location.host + '/Home/GetSearchResultsJson';

            $.when(
                $.get(URL, { searchResult: searchString })

            ).then(function (data) {

                $('.searchResults').empty();
                let dynamicDiv = $('.searchResults');
                let searchResultModel = JSON.parse(data);

                let beers = searchResultModel.Beers;

                let breweries = searchResultModel.Breweries;

                if (beers.length < 1 && breweries.length < 1) {

                    let noResults = document.createElement("div");
                    noResults.className = 'results notFoundResults';

                    let notFound = document.createElement("p");
                    notFound.className = 'notFound';
                    notFound.innerText = 'No Results Were Found';

                    noResults.appendChild(notFound);

                    $('.searchResults').append($(noResults));

                } else {
                    for (let i = 0; i < breweries.length; i++) {

                        let breweryLink = document.createElement("a");
                        let eachLink = 'http://' + window.location.host + '/Home/BreweryInfo/' + breweries[i].BreweryId;
                        breweryLink.setAttribute('href', eachLink);

                        let breweryDiv = document.createElement("div");
                        breweryDiv.className = 'breweryResults results';


                        let breweryImg = document.createElement("img");
                        breweryImg.className = 'breweryImage';
                        breweryImg.src = breweries[i].BreweryProfileImg;


                        let breweryName = document.createElement("p");
                        breweryName.className = 'breweryName';
                        breweryName.innerText = breweries[i].BreweryName;


                        let breweryHistory = document.createElement("p");
                        breweryHistory.className = 'breweryHistory';
                        breweryHistory.innerText = breweries[i].History;

                        breweryLink.appendChild(breweryDiv);
                        breweryDiv.appendChild(breweryImg);
                        breweryDiv.appendChild(breweryName);
                        breweryDiv.appendChild(breweryHistory);

                        $('.searchResults').append(breweryLink);
                        $('.results').animate({ left: '0' }, 'fast');
                    }

                    for (let i = 0; i < beers.length; i++) {

                        let beerLink = document.createElement("a");
                        let eachLink = 'http://' + window.location.host + '/Home/BeerInfo/' + beers[i].BeerId;
                        beerLink.setAttribute('href', eachLink);

                        let beerDiv = document.createElement("div");
                        beerDiv.className = 'beerResults results';

                        
                        let beerImg = document.createElement("img");
                        beerImg.className = 'beerImage';
                        if (beers[i].BeerLabelImg == "NA") {
                            beerImg.src = "../Content/IMGS/genericBeer.png";
                        }
                        else {
                            beerImg.src = beers[i].BeerLabelImg;
                        }

                        let beerName = document.createElement("p");
                        beerName.className = 'beerName';
                        beerName.innerText = beers[i].BeerName;

                        let beerDescription = document.createElement("p");
                        beerDescription.className = 'beerDescription';
                        beerDescription.innerText = beers[i].BeerDescription;

                        beerLink.appendChild(beerDiv)
                        beerDiv.appendChild(beerImg);
                        beerDiv.appendChild(beerName);
                        beerDiv.appendChild(beerDescription);

                        $('.searchResults').append($(beerLink));
                        $('.results').animate({ left: '0' }, 'fast');
                    }
                }

            });

            window.history.pushState(null, '', `?q=${searchString}`);
        }

    };
});
function ActionOne() {
    $('#listActionOne').addClass('focus');
    $('#listActionTwo').removeClass('focus');
    $('#listActionThree').removeClass('focus');
    $('#listActionFour').removeClass('focus');

    $('.viewOne').removeClass('hidden');
    $('.viewTwo').addClass('hidden');
    $('.viewThree').addClass('hidden');
    $('.viewFour').addClass('hidden');
}
function ActionTwo() {
    $('#listActionOne').removeClass('focus');
    $('#listActionTwo').addClass('focus');
    $('#listActionThree').removeClass('focus');
    $('#listActionFour').removeClass('focus');

    $('.viewOne').addClass('hidden');
    $('.viewTwo').removeClass('hidden');
    $('.viewThree').addClass('hidden');
    $('.viewFour').addClass('hidden');
}
function ActionThree() {
    $('#listActionOne').removeClass('focus');
    $('#listActionTwo').removeClass('focus');
    $('#listActionThree').addClass('focus');
    $('#listActionFour').removeClass('focus');

    $('.viewOne').addClass('hidden');
    $('.viewTwo').addClass('hidden');
    $('.viewThree').removeClass('hidden');
    $('.viewFour').addClass('hidden');
}
function ActionFour() {
    $('#listActionOne').removeClass('focus');
    $('#listActionTwo').removeClass('focus');
    $('#listActionThree').removeClass('focus');
    $('#listActionFour').addClass('focus');

    $('.viewOne').addClass('hidden');
    $('.viewTwo').addClass('hidden');
    $('.viewThree').addClass('hidden');
    $('.viewFour').removeClass('hidden');
}