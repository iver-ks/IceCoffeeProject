% rebase("layout.tpl", title="Отзывы", year=year)

<!-- Секция отзывов -->
<section class="reviews-section">
    <h1 class="reviews-title">Отзывы наших гостей</h1>
    <p class="reviews-description">
        Мы ценим мнение каждого гостя. Здесь можно прочитать отзывы о наших холодных кофейных напитках,
        атмосфере кофейни и качестве обслуживания.
    </p>

    <div class="reviews-layout">
        <div class="reviews-list-column">
            <div class="review-form-block" id="review-form-block">
                <h2 class="review-form-title">Оставьте отзыв</h2>
                % if success_message:
                <div class="review-success">{{ success_message }}</div>
                % end
                <form class="review-form" action="/reviews?sort={{ sort_order }}" method="post">
                    <div class="review-form-group">
                        <div id="rating" class="rating-select" aria-label="Выбор оценки">
                            <input type="radio" id="star5" name="rating" value="5"{{ ' checked="checked"' if form_data.get('rating') == '5' else '' }}>
                            <label for="star5" class="rating-star" title="5 звезд">★</label>
                            <input type="radio" id="star4" name="rating" value="4"{{ ' checked="checked"' if form_data.get('rating') == '4' else '' }}>
                            <label for="star4" class="rating-star" title="4 звезды">★</label>
                            <input type="radio" id="star3" name="rating" value="3"{{ ' checked="checked"' if form_data.get('rating') == '3' else '' }}>
                            <label for="star3" class="rating-star" title="3 звезды">★</label>
                            <input type="radio" id="star2" name="rating" value="2"{{ ' checked="checked"' if form_data.get('rating') == '2' else '' }}>
                            <label for="star2" class="rating-star" title="2 звезды">★</label>
                            <input type="radio" id="star1" name="rating" value="1"{{ ' checked="checked"' if form_data.get('rating') == '1' else '' }}>
                            <label for="star1" class="rating-star" title="1 звезда">★</label>
                        </div>
                        <div class="field-error">{{ errors.get('rating', '') }}</div>
                    </div>

                    <div class="review-form-group">
                        <label class="review-label" for="author">Ваше имя</label>
                        <input id="author" name="author" type="text" class="review-input" placeholder="Укажите ваше имя" value="{{ form_data.get('author', '') }}">
                        <div class="field-error">{{ errors.get('author', '') }}</div>
                    </div>

                    <div class="review-form-group">
                        <label class="review-label" for="date">Дата посещения</label>
                        <input id="review-date" name="date" type="text" class="review-input" maxlength="10" placeholder="ДД.ММ.ГГГГ" autocomplete="off" value="{{ form_data.get('date', '') }}">
                        <small class="review-hint">Укажите дату, когда вы посещали нашу кофейню.</small>
                        <div class="field-error">{{ errors.get('date', '') }}</div>
                    </div>

                    <div class="review-form-group">
                        <label class="review-label" for="text">Ваш отзыв</label>
                        <textarea id="text" name="text" rows="5" class="review-textarea" placeholder="Опишите ваши впечатления о напитке и обслуживании...">{{ form_data.get('text', '') }}</textarea>
                        <div class="field-error">{{ errors.get('text', '') }}</div>
                    </div>

                    <button type="submit" class="article-submit">Разместить отзыв</button>
                </form>
            </div>
        </div>

        <div class="reviews-list-column">
            <div class="reviews-list-block" id="reviews-list">
                <div class="reviews-list-header">
                    <h2 class="reviews-list-title">Отзывы</h2>
                    <button type="button" class="articles-sort-btn btn-review-sort" id="reviews-sort-btn" data-sort="{{ sort_order }}">
                        <span class="articles-sort-icon" aria-hidden="true">
                            % if sort_order == "old":
                            <svg viewBox="0 0 24 24">
                                <path d="M7 10l5-5 5 5"></path>
                                <path d="M12 5v14"></path>
                            </svg>
                            % else:
                            <svg viewBox="0 0 24 24">
                                <path d="M7 14l5 5 5-5"></path>
                                <path d="M12 19V5"></path>
                            </svg>
                            % end
                        </span>
                        % if sort_order == "old":
                        <span class="articles-sort-text">Сначала старые</span>
                        % else:
                        <span class="articles-sort-text">Сначала новые</span>
                        % end
                    </button>
                </div>

                % if reviews:
                <div class="reviews-grid" id="reviews-grid">
                    % for index, item in enumerate(reviews):
                    <article class="review-card{{ ' review-card--hidden' if index >= 4 else '' }}" data-date="{{ item['date'] }}">
                        <div class="review-stars">{{ '★' * item['rating'] }}{{ '☆' * (5 - item['rating']) }}</div>
                        <p class="review-meta"><strong>Автор:</strong> {{ item['author'] }}</p>
                        <p class="review-meta"><strong>Дата посещения:</strong> {{ item['date'] }}</p>
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
        </div>
    </div>
</section>

<script src="/static/scripts/reviews.js"></script>
