% rebase('layout.tpl', title='Контакты', year=year)

<!-- Contact Section (раздел "Контакты") -->
<section class="contact-section">
    <!-- Заголовок секции -->
    <h1 class="contact-title">КОНТАКТЫ</h1>
    <!-- Подзаголовок -->
    <div class="contact-subtitle">
        <p>Мы всегда рады вас видеть! Свяжитесь с нами любым удобным способом</p>
    </div>
        
    <!-- Контейнер карточек контактов -->
    <div class="contact-cards">
        <!-- Телефон -->
        <div class="contact-card card-phone">
            <!-- Иконка -->
            <img src="/static/images/icons/phone.png" alt="Телефон" class="contact-icon-img">
            <!-- Основной текст (заголовок) -->
            <h3 class="contact-card-title">+7 (812) 200-07-77</h3>
            <!-- Дополнительная информация -->
            <p class="contact-card-text">
                Звоните нам ежедневно с 8:00 до 22:00<br>
                Мы всегда на связи!
            </p>
        </div>
            
        <!-- Email -->
        <div class="contact-card card-email">
            <img src="/static/images/icons/email.png" alt="Email" class="contact-icon-img">
            <h3 class="contact-card-title">icecoffee@gmail.com</h3>
            <p class="contact-card-text">
                Пишите нам по любым вопросам<br>
                Отвечаем в течение часа
            </p>
        </div>
            
        <!-- Адрес -->
        <div class="contact-card card-location">
            <img src="/static/images/icons/location.png" alt="Адрес" class="contact-icon-img">
            <h3 class="contact-card-title">Санкт-Петербург</h3>
            <p class="contact-card-text">
                м. Проспект Славы<br>
                Бухарестская ул., 49/43
            </p>
        </div>
    </div>
    <!-- Карта и информационный блок -->
<div class="contact-map">
    <!-- Контейнер карты -->
    <div class="map-container">
        <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3A606c80543add0e516b4883f7a6da4c247e3a8c422c58909651dac46c34dfb1ca&amp"
            width="100%"
            height="450">
        </iframe>
    </div>
    
    <!-- Информационный блок -->
    <div class="map-info">
        <!-- Название точки -->
        <h4>ICE Coffee - Санкт-Петербург</h4>
        <!-- Адрес -->
        <div class="info-row">
            <img src="/static/images/icons/mini-location.png" alt="Адрес" class="info-icon">
            <p>Бухарестская ул., 49/43</p>
        </div>
        <!-- Адрес -->
        <div class="info-row">
            <img src="/static/images/icons/clock.png" alt="Время работы" class="info-icon">
            <p>Ежедневно: 8:00 - 22:00</p>
        </div>
        <!-- Рейтинг -->
        <div class="map-rating">
            <span class="stars">★★★★★</span>
            <span class="rating-value">4.9 (2,458 отзывов)</span>
        </div>
    </div>
</div>

</section>
