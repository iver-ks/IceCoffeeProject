"""
Routes and views for the bottle application.
"""

from bottle import redirect, request, route, view
from datetime import datetime

from articles_model import add_article, load_articles, validate_article_form
from reviews_model import load_reviews, sort_reviews


@route("/")
@route("/home")
@view("index")
def home():
    """Renders the home page."""
    return dict(
        title="Главная",
        nav_page="home",
        year=datetime.now().year,
    )


@route("/contact")
@view("contact")
def contact():
    """Renders the contact page."""
    return dict(
        title="Контакты",
        message="Your contact page.",
        nav_page="contact",
        year=datetime.now().year,
    )


@route("/about")
@view("about")
def about():
    """Renders the about page."""
    return dict(
        title="О нас",
        message="Your application description page.",
        nav_page="about",
        year=datetime.now().year,
    )


@route("/reviews")
@view("reviews")
def reviews():
    """Renders the reviews page."""
    sort_order = request.query.get("sort_order", "new")
    reviews_data = sort_reviews(load_reviews(), sort_order)

    return dict(
        title="Отзывы",
        nav_page="reviews",
        year=datetime.now().year,
        reviews=reviews_data,
        sort_order=sort_order,
    )


@route("/articles", method=["GET", "POST"])
@view("articles")
def articles():
    """Renders the articles page."""
    empty_values = {
        "author": "",
        "title": "",
        "description": "",
        "content": "",
        "date": "",
    }

    if request.method == "POST":
        errors, values = validate_article_form(request.forms)
        if errors:
            return dict(
                title="Статьи",
                nav_page="articles",
                year=datetime.now().year,
                articles=load_articles(),
                errors=errors,
                values=values,
            )

        add_article(values)
        return redirect("/articles")

    return dict(
        title="Статьи",
        nav_page="articles",
        year=datetime.now().year,
        articles=load_articles(),
        errors={},
        values=empty_values,
    )
