# templates

## tags:

* `{{ variable_name }}`
* `{{ variable_name | pluralize }}`
* `{% if ... %} {% elif %} {% else %} {% endif %}`
* `{% for ... in ... %} {% endfor %}` `{{ forloop.counter }}`

## reference

1. url

`polls` is the `app_name` defined in the app `polls'`.`urls.py` file, and `detail` is the url name, and `question.id` is the url's parameter.

    <a href="{% url 'polls:detail' question.id %}">{{ question.question_text }}</a>

2. static

put `{% load static %}` first, just below `<!DOCTYPE html>`. the `{% static %}` template tag generates the absolute URL of the static files:

    <!DOCTYPE html>
    {% load static %}
    <html>
        ...
    </html>

    <link rel="stylesheet" href="{% static "polls/style.css" %}">

3. media

for development, you can use media resources by setting project's url:

    from django.conf import settings
    from django.conf.urls.static import static

    urlpatterns = [
        ...
    ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

when using `{{ MEDIA_URL }}` in template, you have to add `django.template.context_processors.media` in `TEMPLATES.context_processors` in `settings.py` file:

    {{ MEDIA_URL }}images/myimage.png

4. form

        <form action="{% url 'polls:vote' question.id %}" method="post">
        {% csrf_token %}
        <input type="submit" value="vote">
        </form>

5. blocks

        {% extends "base.html" %}

        {% block block_name %}{% endblock %}
