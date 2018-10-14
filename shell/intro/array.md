# arrays

arrays in `bash` are limited to a single dimension. array support first appeared in `bash` version 2.

## creating an array

array variables are named just like other `bash` variables, and are created automatically when they are accessed, e.g.,:

    a[1]=foo
    echo ${a[1]}

an array can also be created with `declare` command:

    declare -a a

## assignning values to an array

single values may be assigned using:

    name[subscript]=value

where `name` is the name of the array and `subscript` is an integer (or orithmetic expression) greater than or equal to zero. the first element of an array is *zero*, not one. `value` is a string or integer assigned to the array element.

multiple values may be assigned using:

    name=(value1 value2 ...)

    days=(sun mon tue wed thu fri sat)

it is also possible to assign values to a specific element by specifying a subscript for each value:

    days=([0]=sun [1]=mon [2]=tue [3]=wed [4]=thu [5]=fri [6]=sat)

## array operations

`${a[*]}`, `${a[@]}`, `"${a[*]}"`, `"${a[@]}"` all list the entire contents of an array. their difference is same as `$*`, `$@`, `"$*"`, and `"$a"`. so `"${a[@]}"` is preferable.

`${#a[@]}` returns number of items in an array. if `a=(a b c d)`, then `a[100]=e`, `${#a[@]}` will return 5. so in `bash`, while we assign a string to element 100, it will only reports one element in the array. this differs from the behavior of some other languages in which the unused elements of the array (elements 0-99) would be initialized with empty values and  counted.

as `bash` allows arrays to contain *gaps* in the assignment of subscripts, it is sometimes useful to determine which elements actually exist. this can be done with a parameter expansion using the following forms:

    ${!array[*]}
    ${!array[a]}
    "${!array[*]}"
    "${!array[a]}"

the quoted `@` one is preferable. this form will expand into separate words, while quoted `"` one will expand into a single word.

`+=` supports appending values to the end of array:

    foo=(a b c)
    foo+=(d e f)

the shell has no direct way of doing sorting, but you call do it in other ways:

    a=(f e d c b a)
    a_sorted=($(for in "${a[@]}"; do echo $i; done | sort))

`unset` can be used to remove an array, or items in an array. `unset a` deletes the array a, and `unset 'a[100]'` will delete item `a[100]`. notice that the array element must be quoted to prevent the shell from performing pathname expansion.

the assignment of an empty value to an array does not empty its contents. any reference to an array variable without a subscript refers to element zero of the array.

recent versions of `bash` now support *associative arrays*. *associative arrays* use strings rather than integers as array indexes. but *associative arrays* must be created with the `declare` command using the new `-A` option:

    declare -A colors
    colors["red"]="#ff0000"
    echo ${colors["red"]}
