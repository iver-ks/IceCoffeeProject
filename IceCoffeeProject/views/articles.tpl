% rebase('layout.tpl', title='Статьи', year=year, nav_page=nav_page)

<section class="articles-page">
    <div class="articles-container">
        <h1 class="articles-title">ПОЛЕЗНЫЕ СТАТЬИ</h1>
        <p class="articles-subtitle">Советы, рецепты и интересные факты о кофе</p>

        <div class="articles-layout">
            <div class="articles-list-column">
                <div class="articles-toolbar">
                    <button class="articles-sort-btn" id="articles-sort-btn" type="button" data-sort="new">
                        <span class="articles-sort-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24">
                                <path d="M7 14l5 5 5-5"></path>
                                <path d="M12 19V5"></path>
                            </svg>
                        </span>
                        <span class="articles-sort-text">Сначала новые</span>
                    </button>
                </div>

                <div class="articles-list">
                % for article in articles:
                <article class="article-card" data-title="{{article['title']}}" data-description="{{article['description']}}" data-author="{{article['author']}}" data-date="{{article['date']}}" data-content="{{article['content']}}" data-image="{{article['image']}}">
                    <img src="{{article['image']}}" alt="{{article['title']}}" class="article-image">
                    <div class="article-content">
                        <h3 class="article-name">{{article['title']}}</h3>
                        <p class="article-description">{{article['description']}}</p>
                        <p class="article-meta">{{article['date']}} <span class="article-separator">|</span> Автор: {{article['author']}}</p>
                    </div>
                </article>
                % end
                </div>
            </div>

            <aside class="article-form-wrap">
                <form class="article-form" action="/articles" method="post" accept-charset="UTF-8">
                    <h2 class="article-form-title">Добавить статью</h2>

                    <label for="article-author">Имя автора *</label>
                    <input id="article-author" type="text" name="author" class="{{'error' if errors.get('author') else ''}}" value="{{values.get('author', '')}}" placeholder="Введите ваше имя" required>
                    % if errors.get('author'):
                    <div class="article-error">{{errors['author']}}</div>
                    % end

                    <label for="article-title">Название статьи *</label>
                    <input id="article-title" type="text" name="title" class="{{'error' if errors.get('title') else ''}}" value="{{values.get('title', '')}}" placeholder="Введите название статьи" required>
                    % if errors.get('title'):
                    <div class="article-error">{{errors['title']}}</div>
                    % end

                    <label for="article-text">Описание статьи *</label>
                    <textarea id="article-text" name="description" class="{{'error' if errors.get('description') else ''}}" rows="5" placeholder="Введите описание статьи" required>{{values.get('description', '')}}</textarea>
                    % if errors.get('description'):
                    <div class="article-error">{{errors['description']}}</div>
                    % end

                    <label for="article-content">Основной текст статьи *</label>
                    <textarea id="article-content" name="content" class="{{'error' if errors.get('content') else ''}}" rows="8" placeholder="Введите основной текст статьи" required>{{values.get('content', '')}}</textarea>
                    % if errors.get('content'):
                    <div class="article-error">{{errors['content']}}</div>
                    % end

                    <label for="article-date">Дата публикации *</label>
                    <input type="text" id="article-date" name="date" class="{{'error' if errors.get('date') else ''}}" maxlength="10" placeholder="ДД.ММ.ГГГГ" autocomplete="off" value="{{values.get('date', '')}}" required>
                    % if errors.get('date'):
                    <div class="article-error">{{errors['date']}}</div>
                    % end

                    <button type="submit" class="article-submit">Разместить статью</button>
                    <p class="article-required-note">* — обязательные поля</p>
                </form>
            </aside>
        </div>
    </div>
</section>

<div class="article-modal" id="article-modal" aria-hidden="true">
    <div class="article-modal-content" role="dialog" aria-modal="true" aria-labelledby="article-modal-title">
        <button class="article-modal-close" id="article-modal-close" type="button" aria-label="Закрыть">
            &times;
        </button>

        <h2 class="article-modal-title" id="article-modal-title"></h2>

        <div class="article-modal-meta">
            <div class="article-modal-meta-item">
                <svg class="article-modal-icon" viewBox="0 0 24 24" aria-hidden="true">
                    <rect x="3" y="5" width="18" height="16" rx="2"></rect>
                    <line x1="3" y1="10" x2="21" y2="10"></line>
                    <line x1="8" y1="3" x2="8" y2="7"></line>
                    <line x1="16" y1="3" x2="16" y2="7"></line>
                </svg>
                <span class="article-modal-date"></span>
            </div>

            <span class="article-modal-separator">|</span>

            <div class="article-modal-meta-item">
                <svg class="article-modal-icon" viewBox="0 0 24 24" aria-hidden="true">
                    <circle cx="12" cy="8" r="4"></circle>
                    <path d="M4 20c0-3.8 3.6-6 8-6s8 2.2 8 6"></path>
                </svg>
                <span class="article-modal-author"></span>
            </div>
        </div>

        <img class="article-modal-image" src="" alt="">
        <div class="article-modal-text"></div>
    </div>
</div>

<script src="/static/scripts/articles.js"></script>
