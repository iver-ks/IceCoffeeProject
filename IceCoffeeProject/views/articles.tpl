% rebase('layout.tpl', title='Статьи', year=year, nav_page=nav_page)

<section class="articles-page">
    <div class="articles-container">

        <!-- Заголовок страницы -->
        <h1 class="articles-title">ПОЛЕЗНЫЕ СТАТЬИ</h1>

        <!-- Подзаголовок -->
        <p class="articles-subtitle">
            Советы, рецепты и интересные факты о кофе
        </p>

        <div class="articles-layout">

            <!-- Левая колонка со статьями -->
            <div class="articles-list-column">

                <!-- Панель сортировки -->
                <div class="articles-toolbar">

                    <!-- Кнопка сортировки -->
                    <button class="articles-sort-btn"
                            id="articles-sort-btn"
                            type="button"
                            data-sort="new">

                        <!-- Иконка -->
                        <span class="articles-sort-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24">
                                <path d="M7 14l5 5 5-5"></path>
                                <path d="M12 19V5"></path>
                            </svg>
                        </span>

                        <!-- Текст -->
                        <span class="articles-sort-text">
                            Сначала новые
                        </span>
                    </button>
                </div>

                <!-- Список статей -->
                <div class="articles-list">

                <!-- Перебор статей -->
                % for article in articles:

                <!-- Карточка статьи -->
                <article class="article-card"

                    <!-- Данные статьи для JS -->
                    data-title="{{article['title']}}"
                    data-description="{{article['description']}}"
                    data-author="{{article['author']}}"
                    data-date="{{article['date']}}"
                    data-content="{{article['content']}}"
                    data-image="{{article['image']}}">

                    <!-- Картинка статьи -->
                    <img src="{{article['image']}}"
                         alt="{{article['title']}}"
                         class="article-image">

                    <!-- Контент статьи -->
                    <div class="article-content">

                        <!-- Название -->
                        <h3 class="article-name">
                            {{article['title']}}
                        </h3>

                        <!-- Описание -->
                        <p class="article-description">
                            {{article['description']}}
                        </p>

                        <!-- Дата и автор -->
                        <p class="article-meta">
                            {{article['date']}}
                            <span class="article-separator">|</span>
                            Автор: {{article['author']}}
                        </p>
                    </div>
                </article>

                % end
                </div>
            </div>

            <!-- Правая колонка -->
            <aside class="article-form-wrap">

                <!-- Форма добавления статьи -->
                <form class="article-form"
                      action="/articles"
                      method="post"
                      accept-charset="UTF-8">

                    <!-- Заголовок формы -->
                    <h2 class="article-form-title">
                        Добавить статью
                    </h2>

                    <!-- ===== AUTHOR ===== -->

                    <!-- Имя автора -->
                    <label for="article-author">
                        Имя автора *
                    </label>

                    <!-- Поле автора -->
                    <input id="article-author"
                           type="text"
                           name="author"

                           <!-- Класс ошибки -->
                           class="{{'error' if errors.get('author') else ''}}"

                           <!-- Сохраняем введенное значение -->
                           value="{{values.get('author', '')}}"

                           placeholder="Введите ваше имя"
                           required>

                    <!-- Ошибка автора -->
                    % if errors.get('author'):
                    <div class="article-error">
                        {{errors['author']}}
                    </div>
                    % end

                    <!-- ===== TITLE ===== -->

                    <!-- Название статьи -->
                    <label for="article-title">
                        Название статьи *
                    </label>

                    <!-- Поле названия -->
                    <input id="article-title"
                           type="text"
                           name="title"
                           class="{{'error' if errors.get('title') else ''}}"
                           value="{{values.get('title', '')}}"
                           placeholder="Введите название статьи"
                           required>

                    <!-- Ошибка названия -->
                    % if errors.get('title'):
                    <div class="article-error">
                        {{errors['title']}}
                    </div>
                    % end

                    <!-- ===== DESCRIPTION ===== -->

                    <!-- Описание -->
                    <label for="article-text">
                        Описание статьи *
                    </label>

                    <!-- Поле описания -->
                    <textarea id="article-text"
                              name="description"
                              class="{{'error' if errors.get('description') else ''}}"
                              rows="5"
                              placeholder="Введите описание статьи"
                              required>{{values.get('description', '')}}</textarea>

                    <!-- Ошибка описания -->
                    % if errors.get('description'):
                    <div class="article-error">
                        {{errors['description']}}
                    </div>
                    % end

                    <!-- ===== CONTENT ===== -->

                    <!-- Основной текст -->
                    <label for="article-content">
                        Основной текст статьи *
                    </label>

                    <!-- Поле текста -->
                    <textarea id="article-content"
                              name="content"
                              class="{{'error' if errors.get('content') else ''}}"
                              rows="8"
                              placeholder="Введите основной текст статьи"
                              required>{{values.get('content', '')}}</textarea>

                    <!-- Ошибка текста -->
                    % if errors.get('content'):
                    <div class="article-error">
                        {{errors['content']}}
                    </div>
                    % end

                    <!-- ===== DATE ===== -->

                    <!-- Дата публикации -->
                    <label for="article-date">
                        Дата публикации *
                    </label>

                    <!-- Поле даты -->
                    <input type="text"
                           id="article-date"
                           name="date"

                           <!-- Класс ошибки -->
                           class="{{'error' if errors.get('date') else ''}}"

                           <!-- Формат ДД.ММ.ГГГГ -->
                           maxlength="10"

                           placeholder="ДД.ММ.ГГГГ"
                           autocomplete="off"

                           <!-- Сохраняем введенное значение -->
                           value="{{values.get('date', '')}}"
                           required>

                    <!-- Ошибка даты -->
                    % if errors.get('date'):
                    <div class="article-error">
                        {{errors['date']}}
                    </div>
                    % end

                    <!-- Кнопка отправки -->
                    <button type="submit"
                            class="article-submit">
                        Разместить статью
                    </button>

                    <!-- Подсказка -->
                    <p class="article-required-note">
                        * — обязательные поля
                    </p>
                </form>
            </aside>
        </div>
    </div>
</section>

<!-- Модальное окно статьи -->
<div class="article-modal"
     id="article-modal"
     aria-hidden="true">

    <!-- Контент модального окна -->
    <div class="article-modal-content"
         role="dialog"
         aria-modal="true"
         aria-labelledby="article-modal-title">

        <!-- Кнопка закрытия -->
        <button class="article-modal-close"
                id="article-modal-close"
                type="button"
                aria-label="Закрыть">
            &times;
        </button>

        <!-- Заголовок статьи -->
        <h2 class="article-modal-title"
            id="article-modal-title"></h2>

        <!-- Информация о статье -->
        <div class="article-modal-meta">

            <!-- Дата -->
            <div class="article-modal-meta-item">

                <!-- Иконка календаря -->
                <svg class="article-modal-icon"
                     viewBox="0 0 24 24"
                     aria-hidden="true">

                    <rect x="3"
                          y="5"
                          width="18"
                          height="16"
                          rx="2"></rect>

                    <line x1="3"
                          y1="10"
                          x2="21"
                          y2="10"></line>

                    <line x1="8"
                          y1="3"
                          x2="8"
                          y2="7"></line>

                    <line x1="16"
                          y1="3"
                          x2="16"
                          y2="7"></line>
                </svg>

                <!-- Текст даты -->
                <span class="article-modal-date"></span>
            </div>

            <!-- Разделитель -->
            <span class="article-modal-separator">|</span>

            <!-- Автор -->
            <div class="article-modal-meta-item">

                <!-- Иконка автора -->
                <svg class="article-modal-icon"
                     viewBox="0 0 24 24"
                     aria-hidden="true">

                    <circle cx="12"
                            cy="8"
                            r="4"></circle>

                    <path d="M4 20c0-3.8 3.6-6 8-6s8 2.2 8 6"></path>
                </svg>

                <!-- Имя автора -->
                <span class="article-modal-author"></span>
            </div>
        </div>

        <!-- Картинка статьи -->
        <img class="article-modal-image"
             src=""
             alt="">

        <!-- Полный текст статьи -->
        <div class="article-modal-text"></div>
    </div>
</div>

<!-- Подключение JS -->
<script src="/static/scripts/articles.js"></script>