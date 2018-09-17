# forms

## fields

* CharField
* IntegerField
* EmailField
* ChoiceField for radio input
* DateField

## properties

* widget
    * forms.HiddenInput()
    * forms.PasswordInput()
* help_text="please input your words:"
* initial=0
* required=False

## form properties

* form
* form.as_p
* form.hidden_fields
* form.visible_fields
* form.errors
* form.help_text
* form.save(commit=True)
