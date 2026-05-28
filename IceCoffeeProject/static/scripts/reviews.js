(function () {
    // Получение элементов страницы
    var showMoreButton = document.getElementById('show-more-reviews');
    var sortButton = document.getElementById('reviews-sort-btn');
    var reviewsListBlock = document.getElementById('reviews-list');
    var reviewsGrid = document.getElementById('reviews-grid');
    var reviewDateInput = document.getElementById('review-date');
    var reviewCardsSelector = '.review-card';
    var hiddenSelector = '.review-card--hidden';
    var loadCount = 4; // Количество отзывов, открываемых за один раз

    // Проверяем, существует ли поле даты на странице
    if (reviewDateInput) {
        reviewDateInput.addEventListener('input', function () {
            // Оставляем только цифры и ограничиваем ввод 8 символами
            var digits = reviewDateInput.value.replace(/\D/g, '').slice(0, 8);
            // Если введено 5 и более цифр, формируем полную структуру даты
            if (digits.length >= 5) {
                reviewDateInput.value = digits.slice(0, 2) + '.' + digits.slice(2, 4) + '.' + digits.slice(4);
            // Если введено от 3 до 4 цифр, добавляем точку после дня
            } else if (digits.length >= 3) {
                reviewDateInput.value = digits.slice(0, 2) + '.' + digits.slice(2);
            // Если введено меньше 3 цифр, выводим их без точек
            } else {
                reviewDateInput.value = digits;
            }
        });
    }

    // Функция преобразует строку с датой отзыва в объект Date
    function parseReviewDate(value) {
        var parts = (value || '').split('.'); // Разделяем дату по точкам
        // Если дата состоит не из трёх частей, возвращаем минимальную дату
        if (parts.length !== 3) {
            return new Date(0);
        }
        // Получаем день, месяц и год из строки
        var day = parseInt(parts[0], 10);
        var month = parseInt(parts[1], 10) - 1;
        var year = parseInt(parts[2], 10);
        // Создаём объект даты
        var parsed = new Date(year, month, day);

        // Проверяем, что дата действительно существует
        if (
            parsed.getFullYear() !== year ||
            parsed.getMonth() !== month ||
            parsed.getDate() !== day
        ) {
            return new Date(0);
        }
        // Если дата корректная, возвращаем её
        return parsed;
    }

    // Функция определяет текущий порядок сортировки отзывов
    function getSortDirection() {
        return sortButton && sortButton.getAttribute('data-sort') === 'old' ? 'old' : 'new';
    }

    // Функция обновляет внешний вид и текст кнопки сортировки
    function updateSortButton(direction) {
        // Если кнопка сортировки не найдена, прекращаем выполнение
        if (!sortButton) {
            return;
        }

        // Настройка кнопки для сортировки от старых отзывов к новым
        if (direction === 'old') {
            sortButton.setAttribute('data-sort', 'old');
            sortButton.querySelector('.articles-sort-text').textContent = 'Сначала старые';
            sortButton.querySelector('.articles-sort-icon').innerHTML =
                '<svg viewBox="0 0 24 24"><path d="M7 10l5-5 5 5"></path><path d="M12 5v14"></path></svg>';
        // Настройка кнопки для сортировки от новых отзывов к старым
        } else {
            sortButton.setAttribute('data-sort', 'new');
            sortButton.querySelector('.articles-sort-text').textContent = 'Сначала новые';
            sortButton.querySelector('.articles-sort-icon').innerHTML =
                '<svg viewBox="0 0 24 24"><path d="M7 14l5 5 5-5"></path><path d="M12 19V5"></path></svg>';
        }
    }

    // Функция сортирует карточки отзывов на странице
    function sortReviews(direction) {
        // Если контейнер с отзывами не найден, сортировка не выполняется
        if (!reviewsGrid) {
            return;
        }
        // Получаем все карточки отзывов и преобразуем их в массив
        var cards = Array.prototype.slice.call(reviewsGrid.querySelectorAll(reviewCardsSelector));

        // Сортируем карточки по дате, которая хранится в атрибуте data-date
        cards.sort(function (leftCard, rightCard) {
            var leftDate = parseReviewDate(leftCard.getAttribute('data-date'));
            var rightDate = parseReviewDate(rightCard.getAttribute('data-date'));

            // Если выбран порядок old, сортируем от старых к новым
            // Иначе сортируем от новых к старым
            return direction === 'old' ? leftDate - rightDate : rightDate - leftDate;
        });

        // Добавляем карточки обратно в контейнер уже в новом порядке
        for (var i = 0; i < cards.length; i++) {
            reviewsGrid.appendChild(cards[i]);
        }

        // Считаем количество скрытых карточек
        // Это нужно для работы кнопки "Показать ещё"
        var hiddenCount = 0;
        for (var j = 0; j < cards.length; j++) {
            if (cards[j].classList.contains('review-card--hidden')) {
                hiddenCount++;
            }
        }

        // Если скрытых карточек больше нет, скрываем кнопку "Показать ещё"
        if (hiddenCount === 0 && showMoreButton) {
            showMoreButton.parentElement.style.display = 'none';
        }
    }

    var params = new URLSearchParams(window.location.search); // Получаем параметры из адресной строки

    // Подключаем обработчик к кнопке сортировки
    if (sortButton) {
        // Устанавливаем корректный вид кнопки по текущему значению data-sort
        updateSortButton(getSortDirection());

        // При нажатии на кнопку меняем порядок сортировки на противоположный
        sortButton.addEventListener('click', function () {
            var nextDirection = getSortDirection() === 'new' ? 'old' : 'new';
            updateSortButton(nextDirection);
            sortReviews(nextDirection);
        });
    }

    // Если кнопки "Показать ещё" нет, дальнейшая логика не нужна
    if (!showMoreButton) {
        return;
    }

    // Обработка кнопки "Показать ещё"
    showMoreButton.addEventListener('click', function () {
        // Получаем все скрытые карточки отзывов
        var hiddenCards = document.querySelectorAll(hiddenSelector);
        var revealed = 0;

        // Показываем ограниченное количество карточек за один клик
        for (var i = 0; i < hiddenCards.length && revealed < loadCount; i++) {
            hiddenCards[i].classList.remove('review-card--hidden');
            revealed++;
        }

        // Если после показа скрытых карточек больше не осталось, скрываем кнопку "Показать ещё"
        if (document.querySelectorAll(hiddenSelector).length === 0) {
            showMoreButton.parentElement.style.display = 'none';
        }
    });
})();
