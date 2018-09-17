# django steps for 2.1

this page contains basic steps to create an simple django project.

## references

you can follow these tutorials:

* [Django documentation](https://docs.djangoproject.com/en/2.1/)
* [Getting started with Django](https://www.djangoproject.com/start/)
* [ Avoiding race conditions using F()](https://docs.djangoproject.com/en/2.1/ref/models/expressions/#avoiding-race-conditions-using-f)

## configuration

1. firstly, prepare a django virtual environment:

        create_py_env django

        activate_py_env django

        pip install -U pip

2. install related packages using `pip3 install`:

* `django`
* `django-uuslug`
* `Pillow`
* `psycopg2-binary`

3. create your project, and initiate it:

        django-admin startproject mysite
        python manage.py migrate

4. modify settings in `settings.py`:

        LANGUAGE_CODE = 'zh-Hans'

        TIME_ZONE = 'Asia/Shanghai'

        ALLOWED_HOSTS=["*", ]

        DATABASES =  {
            "default": {
                "ENGINE": "django.db.backends.postgresql",
                "NAME": "django",
                "USER": "django",
                "PASSWORD": "django",
                "HOST": "192.168.111.128",
                "PORT": "5432",
            }
        }

before configure the database, you may have to create the corresponding users, database, schemas:

    create role django login password 'django';
    create database django owner django;
    create schema django authorization django;
    alter role django createdb -- allow to create test database

5. may need to open the port firstly:

        sudo firewall-cmd --permanent --add-port=8000/tcp
        sudo systemctl reload firewalld

6. run the server:

* `python manage.py runserver` - run local listen on 127.0.0.1, with default port 8000
* `python manage.py runserver 8080` - with port 8080
* `python manage.py runserver 0:8000` - `0` is short for `0.0.0.0`, listen on all available public ips


## create an app:

1. add a new app:

        python manage.py startapp polls

2. create a file `urls.py` in the `polls` directory, then include it in the project url file:

        from django.urls import path, include
        path("polls/", include("polls.urls"))

then set an `app_name` value to avoid namespace conflict in the `polls.urls`, and add `urlpatterns`:

    from django.urls import path
    from . import views

    app_name = "polls".

    urlpattern = [
        path("", views.index, name="index"),
        ...
    ]

`path()` has four arguments:

* route
* view
* kwargs
* name

## views

each view returns either an `HttpResponse` object or an `Http404` object:

    from django.http import HttpResponse, Http404, HttpResponseRedirect
    from django.shortcuts import render, get_object_or_404, get_list_or_404
    from django.template import loader
    from django.urls import reverse

    return HttpResponse("hello, world! you're at the polls index...")

    template = loader.get_template("polls/index.html")
    context =  {
        "latest_question_list": latest_question_list,
    }
    return HttpResponse(template.render(context, request))

    return render(request, "polls/detail.html", {"question": question})

    return HttpResponseRedirect(reverse("polls:results", args=(question.id,)))

## models

1. activate models

add the app path `polls.apps.PollsConfig` to the `INSTALLED_APPS` setting in the `settings.py`:

    INSTALLED_APPS = [
        'polls.apps.PollsConfig',
        'django.contrib.admin',
        ...
    ]

2. create migrations:

        python manage.py makemigrations polls

running `makemigrations` tells django to make some changes to the models, and the changes are stored as a `migration`.

3. preview the SQL

        python manage.py sqlmigrate polls 0001

the `sqlmigrate` command takes migration names and returns their SQL. it does not actually run the migration on your database-it just prints it to the screen:

4. check problems:

        python manage.py check 

checking for any problem in your project without making migrations or touching the database.

5. apply changes in the models to the database:

        python manage.py migrate

6. interact with django using:

        python manage.py shell

## django admin

1. create a user:

        python manage.py createsuperuser

2. register your app's model

using in `admin.py`:

    from django.contrib import admin
    from .models import Question

    admin.site.register(Question)

or using:

    @admin.register(Question)
    class QuestionAdmin(admin.ModelAdmin):
        ...

## templates

1. create a directory called `templates` in your `polls` directory. django will look for templates in there. 

2. within the `templates` directory, create another directory called `polls`.

3. detail usage, see `templates.md`

## static files

1. similar to template, first, create a directory called `static` in your polls directory. django will look for static files there. within the `static` directory, 

2. create another directory called `polls`. within this directory, create a stylesheet file `style.css`. you can refer to static file like `polls/style.css`.

3. detail usage, see `templates.md`

4. deploy static files in production

first, set the `STATIC_ROOT` to the directory from which you'd like to serve these files in `settings.py` file:

    STATIC_ROOT = "/data/html/static"

second, set the `STATIC_URL` for url reference, the default is `/static/`:

    STATIC_URL = "/static/"

third, run the `collectstatic` management command. this will copy all files from your static folders into the `STATIC_ROOT` directory:

    python manage.py collectstatic

last, configure your webserver, e.g., for nginx:

    location ^~ /static/ {
        alias /data/html/static/;
        }

## media

1. setting `MEDEA_ROOT` and `MEDIA_URL` in `settings.py`

        MEDIA_URL="/media/"
        MEDIA_ROOT="data/html/media"

2. when using `{{ MEDIA_URL }}`, add `django.template.context_processors.media` in `TEMPLATES.context_processors` in `settings.py` file. then every RequestContext will contain a variable `MEDIA_URL`

3. for development, configure project's url as follows:

        from django.conf import settings
        from django.conf.urls.static import static

        urlpatterns = [
            ...
        ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

4. for production, maybe you have to consider secure problems:

        location ^~ /media/ {
            internal # may need
            alias /data/html/media/;
            }

## test

a conventional place for an application's tests is in the application's `tests.py` file; the testing system will automatically find tests in any file whose name begins with `test`. the method should start with `test` also.

    from django.test import TestCase

    class QuestionModelTests(TestCase):
        def test_was_published_recently_with_future_question(self):
            time = timezone.now() + datetime.timedelta(days=30)
            future_question = Question(pub_date=time)
            self.assertIs(future_question.was_published_recently(), False)

then run the test:

    python manage.py test polls
