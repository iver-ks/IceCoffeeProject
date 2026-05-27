(function () {
    var button = document.getElementById('show-more-reviews');
    var hiddenSelector = '.review-card--hidden';
    var loadCount = 4;

    if (!button) {
        return;
    }

    button.addEventListener('click', function () {
        var hiddenCards = document.querySelectorAll(hiddenSelector);
        var revealed = 0;

        for (var i = 0; i < hiddenCards.length && revealed < loadCount; i++) {
            hiddenCards[i].classList.remove('review-card--hidden');
            revealed++;
        }

        if (document.querySelectorAll(hiddenSelector).length === 0) {
            button.parentElement.style.display = 'none';
        }
    });
})();
