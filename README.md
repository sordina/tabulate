# \\t\\t\\t tabulate \\t\\t\\t

Tabulate Text

## Binary for OS X 10.7.5
[http://sordina.binaries.s3.amazonaws.com/tabulate](http://sordina.binaries.s3.amazonaws.com/tabulate)

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

## Known Bugs

* All lines should have the same number of delimiters
