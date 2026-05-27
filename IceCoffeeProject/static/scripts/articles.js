document.addEventListener("DOMContentLoaded", function () {
    var dateInput = document.getElementById("article-date");

    if (!dateInput) {
        // Still allow the modal on pages without the form.
    } else {
        dateInput.addEventListener("input", function () {
            var digits = dateInput.value.replace(/\D/g, "").slice(0, 8);

            if (digits.length >= 5) {
                dateInput.value = digits.slice(0, 2) + "." + digits.slice(2, 4) + "." + digits.slice(4);
            } else if (digits.length >= 3) {
                dateInput.value = digits.slice(0, 2) + "." + digits.slice(2);
            } else {
                dateInput.value = digits;
            }
        });
    }

    var modal = document.getElementById("article-modal");
    var closeBtn = document.getElementById("article-modal-close");

    var sortButton = document.getElementById("articles-sort-btn");
    var listContainer = document.querySelector(".articles-list");

    var modalTitle = modal ? modal.querySelector(".article-modal-title") : null;
    var modalAuthor = modal ? modal.querySelector(".article-modal-author") : null;
    var modalDate = modal ? modal.querySelector(".article-modal-date") : null;
    var modalImage = modal ? modal.querySelector(".article-modal-image") : null;
    var modalText = modal ? modal.querySelector(".article-modal-text") : null;

    function parseArticleDate(value) {
        var parts = (value || "").split(".");
        if (parts.length !== 3) {
            return new Date(0);
        }

        var day = parseInt(parts[0], 10);
        var month = parseInt(parts[1], 10) - 1;
        var year = parseInt(parts[2], 10);
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
        return sortButton && sortButton.getAttribute("data-sort") === "old" ? "old" : "new";
    }

    function updateSortButton(direction) {
        if (!sortButton) {
            return;
        }

        if (direction === "old") {
            sortButton.setAttribute("data-sort", "old");
            sortButton.querySelector(".articles-sort-text").textContent = "Сначала старые";
            sortButton.querySelector(".articles-sort-icon").innerHTML =
                '<svg viewBox="0 0 24 24"><path d="M7 10l5-5 5 5"></path><path d="M12 5v14"></path></svg>';
        } else {
            sortButton.setAttribute("data-sort", "new");
            sortButton.querySelector(".articles-sort-text").textContent = "Сначала новые";
            sortButton.querySelector(".articles-sort-icon").innerHTML =
                '<svg viewBox="0 0 24 24"><path d="M7 14l5 5 5-5"></path><path d="M12 19V5"></path></svg>';
        }
    }

    function sortArticles(direction) {
        if (!listContainer) {
            return;
        }

        var cards = Array.prototype.slice.call(listContainer.querySelectorAll(".article-card"));
        cards.sort(function (leftCard, rightCard) {
            var leftDate = parseArticleDate(leftCard.getAttribute("data-date"));
            var rightDate = parseArticleDate(rightCard.getAttribute("data-date"));

            return direction === "old" ? leftDate - rightDate : rightDate - leftDate;
        });

        for (var i = 0; i < cards.length; i++) {
            listContainer.appendChild(cards[i]);
        }
    }

    function openModal(card) {
        if (!modal || !modalTitle || !modalAuthor || !modalDate || !modalImage || !modalText) {
            return;
        }

        var title = card.getAttribute("data-title") || "";
        var author = card.getAttribute("data-author") || "";
        var date = card.getAttribute("data-date") || "";
        var image = card.getAttribute("data-image") || "";
        var content = card.getAttribute("data-content") || "";

        modalTitle.textContent = title;
        modalAuthor.textContent = author;
        modalDate.textContent = date;
        modalText.textContent = content;
        modalImage.src = image;
        modalImage.alt = title;

        modal.classList.add("active");
        modal.setAttribute("aria-hidden", "false");
        document.body.classList.add("modal-open");
    }

    function closeModal() {
        if (!modal) {
            return;
        }

        modal.classList.remove("active");
        modal.setAttribute("aria-hidden", "true");
        document.body.classList.remove("modal-open");
    }

    if (sortButton) {
        updateSortButton(getSortDirection());
        sortButton.addEventListener("click", function () {
            var nextDirection = getSortDirection() === "new" ? "old" : "new";
            updateSortButton(nextDirection);
            sortArticles(nextDirection);
        });
    }

    var cards = document.querySelectorAll(".article-card");
    for (var i = 0; i < cards.length; i++) {
        cards[i].addEventListener("click", function (evt) {
            openModal(evt.currentTarget);
        });
    }

    if (closeBtn && modal) {
        closeBtn.addEventListener("click", closeModal);

        modal.addEventListener("click", function (evt) {
            if (evt.target === modal) {
                closeModal();
            }
        });
    }

    document.addEventListener("keydown", function (evt) {
        if (evt.key === "Escape" && modal && modal.classList.contains("active")) {
            closeModal();
        }
    });
});
