# \\t\\t\\t tabulate \\t\\t\\t

Tabulate Text

## Usage

     tabulate [delimiter]

* The default delimiter is `\t`

## Example

    > cat | tabulate '='
    asdf = qwer
    whatever = foo
    1= 2
    abc  = def
    ^D

### Output

    asdf     = qwer
    whatever = foo
    1        = 2
    abc      = def
