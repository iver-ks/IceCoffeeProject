import json
import unittest
from datetime import date, timedelta
from tempfile import TemporaryDirectory
from unittest.mock import patch

import articles_model as model


class TestArticles(unittest.TestCase):

    def setUp(self):
        self.valid_form = {
            "author": "Иван Иванов",
            "title": "Тестовая статья",
            "description": "Описание статьи достаточно длинное",
            "content": "Основной текст статьи " * 10,
            "date": "20.05.2026",
        }

    # ----------------------------
    # Тесты модуля валидации данных
    # ----------------------------

    def test_validate_article_short_author(self):
        form = self.valid_form.copy()
        form["author"] = "И"

        errors, values = model.validate_article_form(form)

        self.assertIn("author", errors)
        self.assertEqual(
            errors["author"],
            "Имя автора должно содержать минимум 2 символов"
        )

    def test_validate_article_future_date(self):
        future_date = (
            date.today() + timedelta(days=1)
        ).strftime("%d.%m.%Y")

        form = self.valid_form.copy()
        form["date"] = future_date

        errors, values = model.validate_article_form(form)

        self.assertIn("date", errors)
        self.assertEqual(
            errors["date"],
            "Дата публикации не может быть из будущего"
        )

    def test_validate_article_invalid_date_format(self):
        form = self.valid_form.copy()
        form["date"] = "2026-05-20"

        errors, values = model.validate_article_form(form)

        self.assertIn("date", errors)
        self.assertEqual(
            errors["date"],
            "Дата должна быть в формате ДД.ММ.ГГГГ"
        )

    def test_validate_article_invalid_author_symbols(self):
        form = self.valid_form.copy()
        form["author"] = "Иван123"

        errors, values = model.validate_article_form(form)

        self.assertIn("author", errors)
        self.assertEqual(
            errors["author"],
            "Имя автора содержит недопустимые символы"
        )

    def test_validate_article_success(self):
        errors, values = model.validate_article_form(
            self.valid_form
        )

        self.assertEqual(errors, {})

    # ----------------------------
    # тест добавления статьи в json-файл
    # ----------------------------

    def test_add_article_creates_json_article(self):
        with TemporaryDirectory() as temp_dir:
            test_path = f"{temp_dir}/articles.json"

            with patch.object(model, "ARTICLES_PATH", test_path):

                model.add_article(self.valid_form)

                with open(test_path, "r", encoding="utf-8") as file:
                    articles = json.load(file)

                self.assertEqual(len(articles), 1)

                self.assertEqual(
                    articles[0]["title"],
                    "Тестовая статья"
                )

                self.assertEqual(
                    articles[0]["author"],
                    "Иван Иванов"
                )

                self.assertEqual(
                    articles[0]["image"],
                    model.DEFAULT_ARTICLE_IMAGE
                )


if __name__ == "__main__":
    unittest.main()