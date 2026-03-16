<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Динамический заголовок страницы -->
    <title>{{ title }} - ICE Coffee</title>
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <!-- Подключение Google-шрифта Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
</head>

<body>
    <!-- Навигационная панель сайта-->
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!-- Название бренда (ссылка на главную страницу) -->
                <a href="/" class="navbar-brand">ICECOFFEE</a>
            </div>
            <!-- Основное меню навигации -->
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/">Главная</a></li>
                    <li><a href="/about">О нас</a></li>
                    <!-- Кнопка перехода на страницу контактов -->
                    <li><a href="/contact" class="btn-contact">Контакты</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Основной контейнер страницы -->
    <div class="container body-content">
        {{!base}}
        <!-- Подвал сайта -->
        <footer>
            <p>&copy; {{ year }} - ICE Coffee</p>
        </footer>
    </div>

    <script src="/static/scripts/jquery-1.10.2.js"></script>
    <script src="/static/scripts/bootstrap.js"></script>
    <script src="/static/scripts/respond.js"></script>

</body>
</html>
