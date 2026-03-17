% rebase('layout.tpl', title='Главная', year=year)

<!-- Hero-секция (первый экран сайта) -->
<section class="hero-section">
    <div class="hero-content">
    <!-- Текстовый блок -->
        <div class="hero-text">
            <!-- Основной слоган бренда -->
            <h1 class="hero-title">Открой для себя превосходный вкус в каждом глотке!</h1>
            <!-- Краткое описание -->
            <p class="hero-description">
                У нас кофе — не просто напиток, а искусство. 
                Приглашаем вас на уникальное кофейное путешествие, 
                где каждый глоток — встреча с идеальным вкусом.
            </p>
            <!-- Переход к выбору продукции -->
            <a href="#products" class="btn btn-hero">Выбрать кофе</a>
        </div>
        <!-- Изображение продукта -->
        <div class="hero-image">
            <img src="/static/images/coffee-hero.png" alt="Coffee" class="img-responsive">
        </div>
    </div>         
</section>


<!-- Секция меню -->
<section class="products-section" id="products">
    <!-- Заголовок секции -->
    <h1 class="products-title">МЕНЮ</h1>
    <!-- Контейнер карточек товаров -->
    <div class="products-grid">
        <!-- Карточка американо -->
        <div class="product-card">
            <!-- Изображение напитка -->
            <div class="product-image">
                <img src="/static/images/americano.png" alt="americano">
            </div>
            <!-- Информация о продукте -->
            <div class="product-info">
                <h3 class="product-name">Американо</h3>
                <p class="product-price">120 ₽</p>
                <!-- Ссылка на подробное описание -->
                <a href="https://www.xleb.ru/catalog/tproduct/690538402-166672586861-ais-amerikano" class="btn-details-full">Подробнее</a>
            </div>
        </div>

        <!-- Карточка латте -->
        <div class="product-card">
            <div class="product-image">
                <img src="/static/images/latte.png" alt="Latte">
            </div>
            <div class="product-info">
                <h3 class="product-name">Латте</h3>
                <p class="product-price">140 ₽</p>
                <a href="https://www.xleb.ru/catalog/tproduct/690538402-171784159271-ais-latte" class="btn-details-full">Подробнее</a>
            </div>
        </div>

        <!-- Карточка матчи -->
        <div class="product-card">
            <div class="product-image">
                <img src="/static/images/matcha.png" alt="Matcha">
            </div>
            <div class="product-info">
                <h3 class="product-name">Матча</h3>
                <p class="product-price">160 ₽</p>
                <a href="https://www.xleb.ru/catalog/tproduct/690538402-757930988241-ais-matcha-zelenaya" class="btn-details-full">Подробнее</a>
            </div>
        </div>
    </div>
</section>
