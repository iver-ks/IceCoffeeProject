% rebase('layout.tpl', title='Статьи', year=year, nav_page=nav_page)

<section class="articles-page">
    <div class="articles-container">
        <h1 class="articles-title">ПОЛЕЗНЫЕ СТАТЬИ</h1>
        <p class="articles-subtitle">Советы, рецепты и интересные факты о кофе</p>

        <div class="articles-layout">
            <div class="articles-list">
                <article class="article-card" data-content="">
                    <img src="/static/images/coffee-cup-about.png" alt="Кофе в чашке" class="article-image">
                    <div class="article-content">
                        <h3 class="article-name">Как выбрать идеальный кофе для себя</h3>
                        <p class="article-description">Разбираемся в сортах, степенях обжарки и способах приготовления, чтобы вы могли найти свой идеальный вкус.</p>
                        <p class="article-meta">24.05.2026 <span class="article-separator">|</span> Автор: Анна Петрова</p>
                    </div>
                </article>

                <article class="article-card" data-content="">
                    <img src="/static/images/latte.png" alt="Латте-арт" class="article-image">
                    <div class="article-content">
                        <h3 class="article-name">Искусство латте-арта: с чего начать</h3>
                        <p class="article-description">Латте-арт — это просто! Делимся базовыми техниками и советами для создания красивых узоров на вашей чашке кофе.</p>
                        <p class="article-meta">20.05.2026 <span class="article-separator">|</span> Автор: Сергей Кузнецов</p>
                    </div>
                </article>

                <article class="article-card" data-content="">
                    <img src="/static/images/americano.png" alt="Айс-кофе" class="article-image">
                    <div class="article-content">
                        <h3 class="article-name">5 рецептов освежающего айс-кофе</h3>
                        <p class="article-description">Подборка лучших рецептов айс-кофе для жарких дней. Готовьте вкусные и освежающие напитки дома!</p>
                        <p class="article-meta">18.05.2026 <span class="article-separator">|</span> Автор: Мария Иванова</p>
                    </div>
                </article>

                <article class="article-card" data-content="">
                    <img src="/static/images/matcha.png" alt="Пуровер" class="article-image">
                    <div class="article-content">
                        <h3 class="article-name">Чем пуровер лучше других способов заваривания?</h3>
                        <p class="article-description">Пуровер раскрывает вкус кофе по-новому. Узнайте, почему этот метод заваривания так популярен среди настоящих ценителей.</p>
                        <p class="article-meta">15.05.2026 <span class="article-separator">|</span> Автор: Даниил Соколов</p>
                    </div>
                </article>
            </div>

            <aside class="article-form-wrap">
                <form class="article-form" action="/articles" method="post">
                    <h2 class="article-form-title">Добавить статью</h2>

                    <label for="article-author">Имя автора *</label>
                    <input id="article-author" type="text" name="author" placeholder="Введите ваше имя" required>

                    <label for="article-title">Название статьи *</label>
                    <input id="article-title" type="text" name="title" placeholder="Введите название статьи" required>

                    <label for="article-text">Описание статьи *</label>
                    <textarea id="article-text" name="text" rows="5" placeholder="Введите описание статьи" required></textarea>

                    <label for="article-content">Основной текст статьи *</label>
                    <textarea id="article-content" name="content" rows="8" placeholder="Введите основной текст статьи" required></textarea>

                    <label for="article-date">Дата публикации *</label>
                    <input id="article-date" type="text" name="date" placeholder="ДД.ММ.ГГГГ" required>

                    <button type="submit" class="article-submit">Разместить статью</button>
                    <p class="article-required-note">* — обязательные поля</p>
                </form>
            </aside>
        </div>
    </div>
</section>
