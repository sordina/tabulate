# \\t\\t\\t tabulate \\t\\t\\t

![A Table](http://i.imgur.com/Ub328Ag.png)

Tabulate Text

## Usage

     tabulate [-h|--help] [--] [delimiter] [joiner]

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

## Binaries

* <http://sordina.binaries.s3.amazonaws.com/tabulate-0.3.0.0-MacOSX-10.9.5-13F34.zip>
* <http://sordina.binaries.s3.amazonaws.com/tabulate-0.2.0.0-MacOSX-10.9.5-13F34.zip>
* <http://sordina.binaries.s3.amazonaws.com/tabulate>
