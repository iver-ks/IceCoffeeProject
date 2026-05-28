"""
Routes and views for the bottle application.
"""

from bottle import redirect, request, route, view
from datetime import datetime

from articles_model import add_article, load_articles, validate_article_form
from reviews_model import load_reviews, save_reviews, sort_reviews, validate_review


def normalize_text(value):
    """Fix text that may arrive as mojibake from form submission."""
    if not value:
        return ""

    if isinstance(value, bytes):
        for encoding in ("utf-8", "cp1251", "latin1"):
            try:
                return value.decode(encoding)
            except UnicodeDecodeError:
                continue
        return value.decode("utf-8", errors="replace")

    try:
        repaired = value.encode("latin1").decode("utf-8")
        if repaired:
            return repaired
    except (UnicodeEncodeError, UnicodeDecodeError):
        pass

    return value


def normalize_review_date(value):
    """Convert review date input to ISO format for storage and comparison."""
    normalized = normalize_text(value).strip()
    if not normalized:
        return ""

    for fmt in ("%d.%m.%Y", "%Y-%m-%d"):
        try:
            return datetime.strptime(normalized, fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue

    return normalized


def reviews_context(sort_order="new", form_data=None, errors=None, success_message=""):
    """Build the template context for the reviews page."""
    if form_data is None:
        form_data = {"rating": "", "author": "", "date": "", "text": ""}
    if errors is None:
        errors = {}

    reviews_data = sort_reviews(load_reviews(), sort_order)
    return dict(
        title="Отзывы",
        nav_page="reviews",
        year=datetime.now().year,
        reviews=reviews_data,
        sort_order=sort_order,
        form_data=form_data,
        errors=errors,
        success_message=success_message,
    )


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


@route("/reviews", method="GET")
@view("reviews")
def reviews():
    """Renders the reviews page."""
    sort_order = request.query.get("sort", "new")
    context = reviews_context(sort_order=sort_order)
    if request.query.get("saved") == "1":
        context["success_message"] = "Отзыв успешно опубликован."
    return context


@route("/reviews", method="POST")
@view("reviews")
def reviews_post():
    """Handles review submission."""
    sort_order = request.query.get("sort", "new")
    existing_reviews = load_reviews()
    form_data = {
        "rating": normalize_text(request.forms.get("rating", "")).strip(),
        "author": normalize_text(request.forms.get("author", "")).strip(),
        "date": normalize_text(request.forms.get("date", "")).strip(),
        "text": normalize_text(request.forms.get("text", "")).strip(),
    }
    normalized_date = normalize_review_date(form_data["date"])

    errors = {}
    if not form_data["rating"]:
        errors["rating"] = "Выберите рейтинг."
    elif form_data["rating"] not in {"1", "2", "3", "4", "5"}:
        errors["rating"] = "Выберите корректный рейтинг."

    errors.update(
        validate_review(
            form_data["author"],
            normalized_date,
            form_data["text"],
            existing_reviews=existing_reviews,
        )
    )

    if errors:
        return reviews_context(sort_order=sort_order, form_data=form_data, errors=errors)

    new_review = {
        "rating": int(form_data["rating"]),
        "author": form_data["author"],
        "date": normalized_date,
        "text": form_data["text"],
    }
    save_reviews([new_review] + existing_reviews)

    return reviews_context(
        sort_order=sort_order,
        form_data={"rating": "", "author": "", "date": "", "text": ""},
        errors={},
        success_message="Отзыв успешно опубликован.",
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
