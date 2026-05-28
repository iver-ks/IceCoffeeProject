import unittest
from datetime import date, timedelta

from reviews_model import validate_review


class TestReviewValidation(unittest.TestCase):
    """Тесты проверки данных формы отзыва."""

    def test_valid_review_data(self):
        """Корректные данные должны проходить проверку без ошибок."""
        errors = validate_review(
            author="Ксения",
            review_date="20.05.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertEqual(errors, {})

    def test_empty_date(self):
        """Пустая дата посещения должна вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("date", errors)
        self.assertEqual(errors["date"], "Укажите дату посещения кофейни.")

    def test_nonexistent_date(self):
        """Несуществующая календарная дата должна вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="31.02.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("date", errors)
        self.assertEqual(errors["date"], "Введите корректную дату посещения.")

    def test_date_before_2025(self):
        """Дата раньше 2025 года должна вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="31.12.2024",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("date", errors)
        self.assertEqual(errors["date"], "Дата посещения не может быть раньше 2025 года.")

    def test_future_date(self):
        """Дата посещения позже текущей даты должна вызывать ошибку."""

        errors = validate_review(
            author="Ксения",
            review_date="31.12.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("date", errors)
        self.assertEqual(errors["date"], "Дата посещения не может быть позже текущей даты.")

    def test_empty_author(self):
        """Пустое имя автора должно вызывать ошибку."""
        errors = validate_review(
            author="",
            review_date="20.05.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("author", errors)
        self.assertEqual(errors["author"], "Введите имя автора.")

    def test_short_author(self):
        """Имя из одного символа должно вызывать ошибку."""
        errors = validate_review(
            author="А",
            review_date="20.05.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("author", errors)
        self.assertEqual(errors["author"], "Имя должно содержать минимум 2 символа.")

    def test_invalid_author_symbols(self):
        """Имя с цифрами должно вызывать ошибку."""
        errors = validate_review(
            author="Ксения123",
            review_date="20.05.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=[]
        )

        self.assertIn("author", errors)
        self.assertEqual(errors["author"], "Допустимы только русские буквы, пробел и дефис.")

    def test_empty_text(self):
        """Пустой текст отзыва должен вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="20.05.2026",
            text="",
            existing_reviews=[]
        )

        self.assertIn("text", errors)
        self.assertEqual(errors["text"], "Введите текст отзыва.")

    def test_short_text(self):
        """Слишком короткий текст отзыва должен вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="20.05.2026",
            text="Класс",
            existing_reviews=[]
        )

        self.assertIn("text", errors)
        self.assertEqual(errors["text"], "Текст должен содержать минимум 10 символов.")

    def test_punctuation_only_text(self):
        """Текст только из знаков препинания должен вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="20.05.2026",
            text="!!!!!?????.....",
            existing_reviews=[]
        )

        self.assertIn("text", errors)
        self.assertEqual(errors["text"], "Текст отзыва должен содержать осмысленное сообщение.")

    def test_repeated_symbols_text(self):
        """Много одинаковых символов подряд должно вызывать ошибку."""
        errors = validate_review(
            author="Ксения",
            review_date="20.05.2026",
            text="Кофе был ооооооочень вкусный.",
            existing_reviews=[]
        )

        self.assertIn("text", errors)
        self.assertEqual(errors["text"], "Слишком много одинаковых символов подряд.")

    def test_duplicate_review(self):
        """Полностью повторяющийся отзыв должен вызывать ошибку."""
        existing_reviews = [
            {
                "rating": 5,
                "author": "Ксения",
                "date": "20.05.2026",
                "text": "Очень понравился холодный латте и приятное обслуживание."
            }
        ]

        errors = validate_review(
            author="Ксения",
            review_date="20.05.2026",
            text="Очень понравился холодный латте и приятное обслуживание.",
            existing_reviews=existing_reviews
        )

        self.assertIn("text", errors)
        self.assertEqual(errors["text"], "Вы уже оставляли такой отзыв.")

if __name__ == "__main__":
    unittest.main()
