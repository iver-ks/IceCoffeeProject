"""
Routes and views for the bottle application.
"""

from bottle import route, request, view
from datetime import datetime

@route('/')
@route('/home')
@view('index')
def home():
    """Renders the home page."""
    return dict(
        title='Главная',
        nav_page='home',
        year=datetime.now().year
    )

@route('/contact')
@view('contact')
def contact():
    """Renders the contact page."""
    return dict(
        title='Контакты',
        message='Your contact page.',
        nav_page='contact',
        year=datetime.now().year
    )

@route('/about')
@view('about')
def about():
    """Renders the about page."""
    return dict(
        title='О нас',
        message='Your application description page.',
        nav_page='about',
        year=datetime.now().year
    )

@route('/articles', method=['GET', 'POST'])
@view('articles')
def articles():
    """Renders the articles page (design with static form)."""
    if request.method == 'POST':
        # Backend logic will be connected later.
        pass

    return dict(
        title='Статьи',
        nav_page='articles',
        year=datetime.now().year
    )
