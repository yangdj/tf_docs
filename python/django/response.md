## response

each view returns either an `HttpResponse` object or an `Http404` object:

these method all come from `django.http`:

* `HttpResponse()`
* `Http404()`
* `HttpResponseRedirect()` - Always return an HttpResponseRedirect after successfully dealing with POST data. This prevents data from being posted twice if a user hits the Back button

        return HttpResponse("hello, world! you're at the polls index...")
        return HttpResponseRedirect(reverse("polls:results", args=(question.id,)))

you can also use generic view, and define your own `model`, `template_name`, `context_object_name` names from `django.views`

* `generic.ListView`
* `generic.DetailView`

        from django.views import generic

        class IndexView(generic.ListView):
            template_name = "polls/index.html"
            context_object_name = "latest_question_list"

            def get_queryset(self):
                return Question.objects.order_by("-pub_date")[:5]

        class DetailView(generic.DetailView):
            model = Question
            template_name = "polls/details.html"
