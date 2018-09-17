# models

## operations

* `Category.objects.all()`
* `Category.objects.get()`
    * `.get(pk=1)` - equal to `.get(id=1)`
    * `.get(pub_date__year=current_year)` - equal to `.get(id=1)`
* `Category.objects.create()` - directly create record in the database
* `Category.objects.get_or_create()[0]`
* `Category.objects.filter()`
    * `.filter(id=1)`
    * `.filter(question_text__startswith="what'")`
* `Category.objects.count()`
* `Category.objects.order_by("-likes")[:5]`
* `q.choice_set.all()`
* `q.save()`
* `q.delete()`

## admin

for `admin.ModelAdmin`:

* `list_display=(...)`
* `list_filter=(...)`
* `search_fields`
* `inlines=(...)`
    * `admin.TabularInline`
* `fields`
* `fieldsets`
* `prepopulated_fields`

for example:

    class PageInline(admin.TabularInline):
        model = Page
        extra = 3

    @admin.register(Category)
    class CategoryAdmin(admin.ModelAdmin):
        list_display = (...)
        list_filter = (...)
        inlines = (PageInline, ...)
        prepopulated_fields = {"slug": ("name", )}

        fieldsets = (
            (None, {"fields": ("name", )}),
            ("favorites", {"fields": ("views", "likes")}),
        )

    or admin.site.register(Category, CategoryAdmin)
