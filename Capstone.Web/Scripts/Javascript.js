$(document).ready(function () {
    $('#ageSubmit').click(function () {

        let date = new Date($('.ageCheckerForm').val());

        let birthday = Math.abs(date.getTime());

        let today = Date.now();

        let difference = Math.floor((today - birthday) / 31556952000);

        if (difference >= 21) {

            $('.searchBar').focus();
            $('.ageCheckerDiv').css({
                zIndex: '-10'
            });
        } else {
            alert("You must be 21 years old to view this site.");
        }
    });
    $('.searchBarForm').keypress(function (e) {

        let searchString = $('.searchBar').val();

        if (e.which == 13 && searchString != "") {
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

                        let beerDiv = document.createElement("div");
                        beerDiv.className = 'beerResults results';

                        let beerImg = document.createElement("img");
                        beerImg.className = 'beerImage';
                        beerImg.src = beers[i].BeerLabelImg;

                        let beerName = document.createElement("p");
                        beerName.className = 'beerName';
                        beerName.innerText = beers[i].BeerName;

                        let beerDescription = document.createElement("p");
                        beerDescription.className = 'beerDescription';
                        beerDescription.innerText = beers[i].BeerDescription;

                        beerDiv.appendChild(beerImg);
                        beerDiv.appendChild(beerName);
                        beerDiv.appendChild(beerDescription);

                        $('.searchResults').append($(beerDiv));
                        $('.results').animate({ left: '0' }, 'fast');
                    }
                }
            });
        }
        
    });
});