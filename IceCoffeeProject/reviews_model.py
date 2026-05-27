"""Model helpers for reading and sorting reviews."""

import json
import os
from datetime import datetime

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
REVIEWS_PATH = os.path.join(BASE_DIR, "data", "reviews.json")


def load_reviews():
    """Load reviews from JSON file.

    Returns an empty list if file does not exist, is empty,
    or contains invalid JSON.
    """
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
    """Save reviews to JSON file."""
    os.makedirs(os.path.dirname(REVIEWS_PATH), exist_ok=True)
    with open(REVIEWS_PATH, "w", encoding="utf-8") as file:
        json.dump(reviews, file, ensure_ascii=False, indent=2)


def sort_reviews(reviews, sort_order):
    """Sort reviews by date in YYYY-MM-DD format."""

    def parse_date(item):
        try:
            return datetime.strptime(item.get("date", ""), "%Y-%m-%d")
        except (TypeError, ValueError):
            return datetime.min

    reverse = sort_order != "old"
    return sorted(reviews, key=parse_date, reverse=reverse)
