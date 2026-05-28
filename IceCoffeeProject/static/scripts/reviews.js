(function () {
    var showMoreButton = document.getElementById('show-more-reviews');
    var sortButton = document.getElementById('reviews-sort-btn');
    var reviewsListBlock = document.getElementById('reviews-list');
    var reviewsGrid = document.getElementById('reviews-grid');
    var reviewDateInput = document.getElementById('review-date');
    var reviewCardsSelector = '.review-card';
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

    if (reviewDateInput) {
        reviewDateInput.addEventListener('input', function () {
            var digits = reviewDateInput.value.replace(/\D/g, '').slice(0, 8);

            if (digits.length >= 5) {
                reviewDateInput.value = digits.slice(0, 2) + '.' + digits.slice(2, 4) + '.' + digits.slice(4);
            } else if (digits.length >= 3) {
                reviewDateInput.value = digits.slice(0, 2) + '.' + digits.slice(2);
            } else {
                reviewDateInput.value = digits;
            }
        });
    }

    function parseReviewDate(value) {
        var parts = (value || '').split('-');
        if (parts.length !== 3) {
            return new Date(0);
        }

        var year = parseInt(parts[0], 10);
        var month = parseInt(parts[1], 10) - 1;
        var day = parseInt(parts[2], 10);
        var parsed = new Date(year, month, day);

        if (
            parsed.getFullYear() !== year ||
            parsed.getMonth() !== month ||
            parsed.getDate() !== day
        ) {
            return new Date(0);
        }

        return parsed;
    }

    function getSortDirection() {
        return sortButton && sortButton.getAttribute('data-sort') === 'old' ? 'old' : 'new';
    }

    function updateSortButton(direction) {
        if (!sortButton) {
            return;
        }

        if (direction === 'old') {
            sortButton.setAttribute('data-sort', 'old');
            sortButton.querySelector('.articles-sort-text').textContent = 'Сначала старые';
            sortButton.querySelector('.articles-sort-icon').innerHTML =
                '<svg viewBox="0 0 24 24"><path d="M7 10l5-5 5 5"></path><path d="M12 5v14"></path></svg>';
        } else {
            sortButton.setAttribute('data-sort', 'new');
            sortButton.querySelector('.articles-sort-text').textContent = 'Сначала новые';
            sortButton.querySelector('.articles-sort-icon').innerHTML =
                '<svg viewBox="0 0 24 24"><path d="M7 14l5 5 5-5"></path><path d="M12 19V5"></path></svg>';
        }
    }

    function sortReviews(direction) {
        if (!reviewsGrid) {
            return;
        }

        var cards = Array.prototype.slice.call(reviewsGrid.querySelectorAll(reviewCardsSelector));
        cards.sort(function (leftCard, rightCard) {
            var leftDate = parseReviewDate(leftCard.getAttribute('data-date'));
            var rightDate = parseReviewDate(rightCard.getAttribute('data-date'));

            return direction === 'old' ? leftDate - rightDate : rightDate - leftDate;
        });

        for (var i = 0; i < cards.length; i++) {
            reviewsGrid.appendChild(cards[i]);
        }

        var hiddenCount = 0;
        for (var j = 0; j < cards.length; j++) {
            if (cards[j].classList.contains('review-card--hidden')) {
                hiddenCount++;
            }
        }

        if (hiddenCount === 0 && showMoreButton) {
            showMoreButton.parentElement.style.display = 'none';
        }
    }

    var params = new URLSearchParams(window.location.search);
    if (window.location.hash === '#reviews-list') {
        scrollToTarget(reviewsListBlock);
    }

    if (sortButton) {
        updateSortButton(getSortDirection());
        sortButton.addEventListener('click', function () {
            var nextDirection = getSortDirection() === 'new' ? 'old' : 'new';
            updateSortButton(nextDirection);
            sortReviews(nextDirection);
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
