<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ title }} - ICE Coffee</title>
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
</head>

<body>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="/" class="navbar-brand">ICECOFFEE</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/" class="{{'nav-active' if nav_page == 'home' else ''}}">Главная</a></li>
                    <li><a href="/about" class="{{'nav-active' if nav_page == 'about' else ''}}">О нас</a></li>
                    <li><a href="/reviews" class="{{'nav-active' if nav_page == 'reviews' else ''}}">Отзывы</a></li>
                    <li><a href="/articles" class="{{'nav-active' if nav_page == 'articles' else ''}}">Статьи</a></li>
                    <li><a href="/contact" class="btn-contact {{'nav-active' if nav_page == 'contact' else ''}}">Контакты</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="container body-content">
        {{!base}}
        <footer>
            <p>&copy; {{ year }} - ICE Coffee</p>
        </footer>
    </div>

    <script src="/static/scripts/jquery-1.10.2.js"></script>
    <script src="/static/scripts/bootstrap.js"></script>
    <script src="/static/scripts/respond.js"></script>

</body>
</html>
