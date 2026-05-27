"""
Routes and views for the bottle application.
"""

from bottle import request, route, view
from datetime import datetime

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
    if request.method == "POST":
        # Backend logic will be connected later.
        pass

    return dict(
        title="Статьи",
        nav_page="articles",
        year=datetime.now().year,
    )
