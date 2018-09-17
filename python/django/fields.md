# fields

## property

* `unique=True`
* `blank=True`
* `null=True`
* `help_text="..."`
* `default=0|True`
* `max_length=200`
* `on_delete` - required value for OneToOneField, ForeignKey since 2.0, before, the value is `models.CASCADE` default
    * `models.CASCADE`
    * `models.PROTECT`
    * `models.SET_NULL`
    * `models.SET_DEFAULT`
    * `models.SET(func)`
* `auto_now_add=True` - auto update time
* `auto_now=True` - auto add create time
* `editable=False` - not show the field, and cannot be edited

## fields

* CharField
    * `max_length=200`

* IntegerField
    * `default=0`

* URLField
    * `max_length=200`

* ImageField - need `Pillow` package support
    * upload_to

* OneToOneField
    * `on_delete=models.CASCADE`

* ForeignKey
    * `on_delete=models.CASCADE`

* DateField

* DateTimeField - datetime.date object
    * `auto_now_add=True`
    * `auto_now=True`

for `DatetimeField`, you can using the methods django provides:

    from django.util import timezone
    timezone.now() # a datetime with tzinfo instead of datetime.datetime.now()

## class Meta

* `unique_together = ("app", "model_code")`
* `verbose_name_plural = "categories"`
