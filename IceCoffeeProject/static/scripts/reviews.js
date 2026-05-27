(function () {
    var showMoreButton = document.getElementById('show-more-reviews');
    var sortForm = document.querySelector('.reviews-sort');
    var sortSelect = document.getElementById('sort');
    var reviewFormBlock = document.getElementById('review-form-block');
    var reviewsListBlock = document.getElementById('reviews-list');
    var hiddenSelector = '.review-card--hidden';
    var loadCount = 4;

    var scrollToTarget = function (element) {
        if (!element) {
            return;
        }

        setTimeout(function () {
            element.scrollIntoView({ behavior: 'auto', block: 'start' });
        }, 0);
    };

    var params = new URLSearchParams(window.location.search);
    if (params.get('focus') === 'form') {
        scrollToTarget(reviewFormBlock);
    } else if (window.location.hash === '#reviews-list') {
        scrollToTarget(reviewsListBlock);
    }

    if (sortForm && sortSelect) {
        var initialSort = sortSelect.value;

        sortForm.addEventListener('submit', function (event) {
            if (sortSelect.value === initialSort) {
                event.preventDefault();
                return;
            }

            initialSort = sortSelect.value;
        });
    }

    if (!showMoreButton) {
        return;
    }

    showMoreButton.addEventListener('click', function () {
        var hiddenCards = document.querySelectorAll(hiddenSelector);
        var revealed = 0;

        for (var i = 0; i < hiddenCards.length && revealed < loadCount; i++) {
            hiddenCards[i].classList.remove('review-card--hidden');
            revealed++;
        }

        if (document.querySelectorAll(hiddenSelector).length === 0) {
            showMoreButton.parentElement.style.display = 'none';
        }
    });
})();