"""Модель для чтения, сохранения и сортировки отзывов."""

import json
import os
import re
from datetime import date, datetime


BASE_DIR = os.path.dirname(os.path.abspath(__file__)) # Определение пути к текущей папке проекта
REVIEWS_PATH = os.path.join(BASE_DIR, "data", "reviews.json") # Путь к файлу, в котором хранятся отзывы


def load_reviews():
    """Загружает отзывы из JSON-файла"""

     # Если файла с отзывами нет, возвращаем пустой список
    if not os.path.exists(REVIEWS_PATH):
        return []

    try:
        # Открываем файл с отзывами для чтения
        with open(REVIEWS_PATH, "r", encoding="utf-8") as file:
            raw = file.read().strip()
            # Если файл пустой, возвращаем пустой список
            if not raw:
                return []
            # Преобразуем JSON-строку в Python-объект
            data = json.loads(raw)
            return data if isinstance(data, list) else []
     # При ошибке чтения файла или ошибке JSON возвращаем пустой список
    except (OSError, json.JSONDecodeError):
        return []


def save_reviews(reviews):
    """Сохраняет список отзывов в JSON-файл."""
    # Создаём папку data, если она ещё не существует
    os.makedirs(os.path.dirname(REVIEWS_PATH), exist_ok=True)
    
     # Записываем список отзывов в файл
    with open(REVIEWS_PATH, "w", encoding="utf-8") as file:
        json.dump(reviews, file, ensure_ascii=False, indent=2)


def _normalize_for_compare(value):
    """Нормализует текст для сравнения и поиска дубликатов"""
    # Убираем лишние пробелы, приводим текст к единому регистру
    return re.sub(r"\s+", " ", (value or "").strip()).casefold()


def validate_review(author, review_date, text, existing_reviews=None):
    """Проверяет данные отзыва и возвращает словарь с ошибками"""
    errors = {}

    # Убираем лишние пробелы в начале и конце введённых значений
    author_value = (author or "").strip()
    date_value = (review_date or "").strip()
    text_value = (text or "").strip()

    # Шаблон для проверки имени автора
    author_pattern = r"[А-Яа-яЁё -]+"
    # Шаблон для проверки текста, состоящего только из знаков препинания
    punctuation_only_pattern = r"[!?.,…\s]+"

    # Проверка имени автора
    if not author_value:
        errors["author"] = "Введите имя автора."
    elif len(author_value) < 2:
        errors["author"] = "Имя должно содержать минимум 2 символа."
    elif len(author_value) > 50:
        errors["author"] = "Имя не должно превышать 50 символов."
    elif not re.fullmatch(author_pattern, author_value):
        errors["author"] = "Допустимы только русские буквы, пробел и дефис."

    # Проверка даты посещения
    if not date_value:
        errors["date"] = "Укажите дату посещения кофейни."
    else:
        parsed_date = None
        try:
            parsed_date = datetime.strptime(date_value, "%d.%m.%Y").date()
        except ValueError:
            errors["date"] = "Введите корректную дату посещения."

        if parsed_date is not None:
            if parsed_date < date(2025, 1, 1):
                errors["date"] = "Дата посещения не может быть раньше 2025 года."
            elif parsed_date > date.today():
                errors["date"] = "Дата посещения не может быть позже текущей даты."

    # Проверка текста отзыва
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

    # Проверка на полное дублирование отзыва
    if existing_reviews:
        # Нормализуем введённые пользователем имя и текст
        normalized_author = _normalize_for_compare(author_value)
        normalized_text = _normalize_for_compare(text_value)
        duplicate_review = False

        # Сравниваем новый отзыв с уже существующими отзывами
        for review in existing_reviews:
            existing_author = _normalize_for_compare(review.get("author", ""))
            existing_text = _normalize_for_compare(review.get("text", ""))
            existing_date = (review.get("date", "") or "").strip()

            # Отзыв считается дубликатом только при совпадении имени, даты и текста
            if (
                normalized_author == existing_author
                and date_value == existing_date
                and normalized_text == existing_text
            ):
                duplicate_review = True
                break
        
        # Если такой отзыв уже есть, выводим ошибку
        if duplicate_review:
            errors["text"] = "Вы уже оставляли такой отзыв."

    return errors


def sort_reviews(reviews, sort_order):
    """Сортирует отзывы по дате"""

    def parse_date(item):
        """Преобразует строковую дату в объект datetime для сортировки"""
        value = item.get("date", "")
        
        # Поддерживаем два возможных формата даты
        for fmt in ("%d.%m.%Y", "%Y-%m-%d"):
            try:
                return datetime.strptime(value, fmt)
            except (TypeError, ValueError):
                pass
        # Если дата некорректная, используем минимальное значение
        return datetime.min

    # Если выбран порядок old, сортируем от старых к новым,
    # иначе по умолчанию — от новых к старым
    reverse = sort_order != "old"
    return sorted(reviews, key=parse_date, reverse=reverse)
