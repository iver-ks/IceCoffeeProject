"""Model helpers for reading, validating and sorting reviews."""

import json
import os
import re
from datetime import date, datetime


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
REVIEWS_PATH = os.path.join(BASE_DIR, "data", "reviews.json")


def load_reviews():
    """Load reviews from the JSON file."""
    if not os.path.exists(REVIEWS_PATH):
        return []

    try:
        with open(REVIEWS_PATH, "r", encoding="utf-8") as file:
            raw = file.read().strip()
            if not raw:
                return []

            data = json.loads(raw)
            return data if isinstance(data, list) else []
    except (OSError, json.JSONDecodeError):
        return []


def save_reviews(reviews):
    """Save reviews to the JSON file."""
    os.makedirs(os.path.dirname(REVIEWS_PATH), exist_ok=True)
    with open(REVIEWS_PATH, "w", encoding="utf-8") as file:
        json.dump(reviews, file, ensure_ascii=False, indent=2)


def _normalize_for_compare(value):
    """Normalize text for duplicate comparisons."""
    return re.sub(r"\s+", " ", (value or "").strip()).casefold()


def validate_review(author, review_date, text, existing_reviews=None):
    """Validate review fields and return a dict of field errors."""
    errors = {}

    author_value = (author or "").strip()
    date_value = (review_date or "").strip()
    text_value = (text or "").strip()

    author_pattern = r"[А-Яа-яЁё -]+"
    punctuation_only_pattern = r"[!?.,…\s]+"

    if not author_value:
        errors["author"] = "Введите имя автора."
    elif len(author_value) < 2:
        errors["author"] = "Имя должно содержать минимум 2 символа."
    elif len(author_value) > 50:
        errors["author"] = "Имя не должно превышать 50 символов."
    elif not re.fullmatch(author_pattern, author_value):
        errors["author"] = "Допустимы только русские буквы, пробел и дефис."

    if not date_value:
        errors["date"] = "Укажите дату посещения кофейни."
    else:
        parsed_date = None
        try:
            parsed_date = datetime.strptime(date_value, "%Y-%m-%d").date()
        except ValueError:
            try:
                parsed_date = datetime.strptime(date_value, "%d.%m.%Y").date()
            except ValueError:
                errors["date"] = "Введите корректную дату посещения."

        if parsed_date is not None and parsed_date > date.today():
            errors["date"] = "Дата посещения не может быть позже текущей даты."

    if not text_value:
        errors["text"] = "Введите текст отзыва."
    elif len(text_value) < 10:
        errors["text"] = "Текст должен содержать минимум 10 символов."
    elif len(text_value) > 500:
        errors["text"] = "Текст не должен превышать 500 символов."
    elif re.fullmatch(punctuation_only_pattern, text_value):
        errors["text"] = "Текст отзыва должен содержать осмысленное сообщение."
    elif re.search(r"(.)\1{5,}", text_value):
        errors["text"] = "Слишком много одинаковых символов подряд."

    if existing_reviews:
        normalized_author = _normalize_for_compare(author_value)
        normalized_text = _normalize_for_compare(text_value)

        duplicate_text = False
        duplicate_date = False

        for review in existing_reviews:
            existing_author = _normalize_for_compare(review.get("author", ""))
            existing_text = _normalize_for_compare(review.get("text", ""))
            existing_date = (review.get("date", "") or "").strip()

            if normalized_author == existing_author and normalized_text == existing_text:
                duplicate_text = True

            if normalized_author == existing_author and date_value == existing_date:
                duplicate_date = True

            if duplicate_text and duplicate_date:
                break

        if duplicate_text:
            errors["text"] = "Вы уже оставляли такой отзыв."

        if duplicate_date:
            errors["date"] = "Вы уже оставляли отзыв за эту дату."

    return errors


def sort_reviews(reviews, sort_order):
    """Sort reviews by date."""

    def parse_date(item):
        value = item.get("date", "")
        for fmt in ("%Y-%m-%d", "%d.%m.%Y"):
            try:
                return datetime.strptime(value, fmt)
            except (TypeError, ValueError):
                pass
        return datetime.min

    reverse = sort_order != "old"
    return sorted(reviews, key=parse_date, reverse=reverse)
