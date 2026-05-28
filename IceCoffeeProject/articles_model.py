"""Model helpers for reading, validating, and storing articles."""

import json
import os
import re
from datetime import date, datetime

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ARTICLES_PATH = os.path.join(BASE_DIR, "data", "articles.json")
DEFAULT_ARTICLE_IMAGE = "/static/images/coffee-cup-about.png"
AUTHOR_PATTERN = r"[A-Za-zА-Яа-яЁё]+(?:[ -][A-Za-zА-Яа-яЁё]+)*"


def load_articles():
    """Load articles from JSON file and sort them from new to old."""
    if not os.path.exists(ARTICLES_PATH):
        return []

    try:
        with open(ARTICLES_PATH, "r", encoding="utf-8") as file:
            data = json.load(file)
            if not isinstance(data, list):
                return []
    except (OSError, json.JSONDecodeError):
        return []

    return sorted(data, key=_parse_article_date, reverse=True)


def save_articles(articles):
    """Persist articles list to JSON."""
    os.makedirs(os.path.dirname(ARTICLES_PATH), exist_ok=True)
    with open(ARTICLES_PATH, "w", encoding="utf-8") as file:
        json.dump(articles, file, ensure_ascii=False, indent=4)


def validate_article_form(form):
    """Validate article form payload and return errors with cleaned values."""
    values = {
        "author": _safe_text(form, "author"),
        "title": _safe_text(form, "title"),
        "description": _safe_text(form, "description"),
        "content": _safe_text(form, "content"),
        "date": _safe_text(form, "date"),
    }
    errors = {}

    _validate_length(values, errors, "author", 2, 50, "Имя автора")
    _validate_length(values, errors, "title", 5, 100, "Название")
    _validate_length(values, errors, "description", 20, 250, "Описание")
    _validate_length(values, errors, "content", 100, 5000, "Основной текст")
    _validate_author(values, errors)

    if not values["date"]:
        errors["date"] = "Дата публикации обязательна"
    else:
        try:
            parsed_date = datetime.strptime(values["date"], "%d.%m.%Y").date()
            if parsed_date > date.today():
                errors["date"] = "Дата публикации не может быть из будущего"
        except (TypeError, ValueError):
            errors["date"] = "Дата должна быть в формате ДД.ММ.ГГГГ"

    return errors, values


def add_article(article):
    """Append article, sort by date descending, and persist JSON."""
    articles = load_articles()
    articles.append(
        {
            "title": article["title"],
            "description": article["description"],
            "content": article["content"],
            "date": article["date"],
            "author": article["author"],
            "image": DEFAULT_ARTICLE_IMAGE,
        }
    )
    articles = sorted(articles, key=_parse_article_date, reverse=True)
    save_articles(articles)


def _parse_article_date(item):
    try:
        return datetime.strptime(item.get("date", ""), "%d.%m.%Y")
    except (TypeError, ValueError):
        return datetime.min


def _validate_length(values, errors, field, min_len, max_len, label):
    value = values[field]
    if not value:
        errors[field] = f"{label} обязательно"
        return
    if len(value) < min_len:
        errors[field] = f"{label} должно содержать минимум {min_len} символов"
        return
    if len(value) > max_len:
        errors[field] = f"{label} должно содержать максимум {max_len} символов"


def _validate_author(values, errors):
    if "author" in errors:
        return

    author = values.get("author", "")
    if not re.fullmatch(AUTHOR_PATTERN, author):
        errors["author"] = "Имя автора содержит недопустимые символы"


def _safe_getunicode(form, key):
    try:
        getter = getattr(form, "getunicode", None)
        if callable(getter):
            return getter(key) or ""
        return form.get(key) or ""
    except (AttributeError, TypeError, ValueError):
        return ""


def _safe_text(form, key):
    value = _safe_getunicode(form, key)
    if value is None:
        return ""
    if not isinstance(value, str):
        value = str(value)
    return value.strip()
