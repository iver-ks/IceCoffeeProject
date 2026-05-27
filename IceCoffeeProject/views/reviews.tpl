% rebase("layout.tpl", title="Отзывы", year=year)

<!-- Секция отзывов -->
<section class="reviews-section">
    <h1 class="reviews-title">Отзывы наших гостей</h1>
    <p class="reviews-description">
        Мы ценим мнение каждого гостя. Здесь можно прочитать отзывы о наших холодных кофейных напитках,
        атмосфере кофейни и качестве обслуживания.
    </p>

    <!-- Форма добавления отзыва -->
    <div class="review-form-block">
        <h2 class="review-form-title">Оставьте отзыв</h2>
        <form class="review-form" action="#" method="post">
            <div class="review-form-group">
                <div id="rating" class="rating-select" aria-label="Выбор оценки">
                    <input type="radio" id="star5" name="rating" value="5">
                    <label for="star5" class="rating-star" title="5 звезд">★</label>
                    <input type="radio" id="star4" name="rating" value="4">
                    <label for="star4" class="rating-star" title="4 звезды">★</label>
                    <input type="radio" id="star3" name="rating" value="3">
                    <label for="star3" class="rating-star" title="3 звезды">★</label>
                    <input type="radio" id="star2" name="rating" value="2">
                    <label for="star2" class="rating-star" title="2 звезды">★</label>
                    <input type="radio" id="star1" name="rating" value="1">
                    <label for="star1" class="rating-star" title="1 звезда">★</label>
                </div>
                <div class="field-error"></div>
            </div>

            <div class="review-form-group">
                <label class="review-label" for="author_name">Ваше имя</label>
                <input id="author_name" name="author_name" type="text" class="review-input" placeholder="Ваше имя">
                <div class="field-error"></div>
            </div>

            <div class="review-form-group">
                <label class="review-label" for="review_date">Дата</label>
                <input id="review_date" name="review_date" type="date" class="review-input">
                <div class="field-error"></div>
            </div>

            <div class="review-form-group">
                <label class="review-label" for="review_text">Ваш отзыв</label>
                <textarea id="review_text" name="review_text" rows="5" class="review-textarea" placeholder="Опишите ваши впечатления о напитке и обслуживании..."></textarea>
                <div class="field-error"></div>
            </div>

            <button type="submit" class="btn btn-review-submit">Разместить отзыв</button>
        </form>
    </div>

    <!-- Сортировка и список карточек -->
    <div class="reviews-list-block" id="reviews-list">
        <form class="reviews-sort" action="/reviews#reviews-list" method="get">
            <label class="reviews-sort-label" for="sort">Сортировка отзывов</label>
            <div class="reviews-sort-controls">
                <select id="sort" name="sort" class="reviews-sort-select">
                    % if sort_order == "new":
                    <option value="new" selected="selected">Сначала новые</option>
                    % else:
                    <option value="new">Сначала новые</option>
                    % end
                    % if sort_order == "old":
                    <option value="old" selected="selected">Сначала старые</option>
                    % else:
                    <option value="old">Сначала старые</option>
                    % end
                </select>
                <button type="submit" class="btn btn-review-sort">Применить</button>
            </div>
        </form>

        % if reviews:
        <div class="reviews-grid" id="reviews-grid">
            % for index, item in enumerate(reviews):
            <article class="review-card{{ ' review-card--hidden' if index >= 4 else '' }}">
                <div class="review-stars">{{ '★' * item['rating'] }}{{ '☆' * (5 - item['rating']) }}</div>
                <p class="review-meta"><strong>Автор:</strong> {{ item['author'] }}</p>
                <p class="review-meta"><strong>Дата:</strong> {{ item['date'] }}</p>
                <p class="review-text">{{ item['text'] }}</p>
            </article>
            % end
        </div>
        % else:
        <div class="reviews-empty-wrap">
            <p class="reviews-empty">
                Пока отзывов нет. Станьте первым гостем, который поделится впечатлением о нашей кофейне.
            </p>
        </div>
        % end

        % if reviews and len(reviews) > 4:
        <div class="reviews-more-placeholder">
            <button type="button" class="btn btn-review-more" id="show-more-reviews">Показать ещё</button>
        </div>
        % end
    </div>
</section>

<script src="/static/scripts/reviews.js"></script>
