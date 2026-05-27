"""
Routes and views for the bottle application.
"""

from bottle import route, view, request
from datetime import datetime

from reviews_model import load_reviews, sort_reviews


@route("/")
@route("/home")
@view("index")
def home():
    """Renders the home page."""
    return dict(
        year=datetime.now().year
    )


@route("/contact")
@view("contact")
def contact():
    """Renders the contact page."""
    return dict(
        title="Contact",
        message="Your contact page.",
        year=datetime.now().year
    )


@route("/about")
@view("about")
def about():
    """Renders the about page."""
    return dict(
        title="About",
        message="Your application description page.",
        year=datetime.now().year
    )


@route("/reviews")
@view("reviews")
def reviews():
    """Renders the reviews page."""
    sort_order = request.query.get("sort_order", "new")
    reviews_data = sort_reviews(load_reviews(), sort_order)

    return dict(
        title="Отзывы",
        year=datetime.now().year,
        reviews=reviews_data,
        sort_order=sort_order,
    )
