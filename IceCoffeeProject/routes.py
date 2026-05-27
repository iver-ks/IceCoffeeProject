"""
Routes and views for the bottle application.
"""

from bottle import route, view
from datetime import datetime

@route('/')
@route('/home')
@view('index')
def home():
    """Renders the home page."""
    return dict(
        year=datetime.now().year
    )

@route('/contact')
@view('contact')
def contact():
    """Renders the contact page."""
    return dict(
        title='Contact',
        message='Your contact page.',
        year=datetime.now().year
    )

@route('/about')
@view('about')
def about():
    """Renders the about page."""
    return dict(
        title='About',
        message='Your application description page.',
        year=datetime.now().year
    )

@route('/reviews')
@view('reviews')
def reviews():
    """Renders the reviews page."""
    return dict(
        title='Отзывы',
        year=datetime.now().year,
        reviews=[
            {
                'rating': 5,
                'author': 'Алина',
                'date': '2026-05-20',
                'text': 'Очень понравился холодный латте. Напиток нежный, не слишком сладкий, а подача выглядит аккуратно и стильно.'
            },
            {
                'rating': 4,
                'author': 'Мария',
                'date': '2026-05-18',
                'text': 'Брала айс-капучино и десерт. Всё свежее, вкусное, быстро приготовили. В кофейне приятная атмосфера.'
            },
            {
                'rating': 5,
                'author': 'Ксения',
                'date': '2026-05-15',
                'text': 'Понравилось обслуживание и спокойная музыка. Отличное место, чтобы взять кофе навынос и немного отдохнуть.'
            }
        ]
    )