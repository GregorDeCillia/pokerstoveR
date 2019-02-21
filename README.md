
<!-- README.md is generated from README.Rmd. Please edit that file -->
pokerstoveR
===========

An R wrapper around the `ps-eval` executable from pokerstove.

Installation
------------

This package is not on CRAN. You can however install the development version with `install_github`.

``` r
devtools::install_github("GregorDeCillia/pokerstoveR")
```

In order to use the package, `pokerstove` has to be installed and `ps-eval` has to be in the `PATH`.

Preflop equities
----------------

Currently, there is just one useful command in the package which is called `ps_eval`. This command relies on `ps-eval` to calculate equities of NLHE hands.

``` r
library(pokerstoveR)
ps_eval("AcAs", "2h7d")
#>   hand  equity    wins ties
#> 1 AcAs 87.4224 1493820 3118
#> 2 2h7d 12.5776  212248 3118
```

In this case we see the preflop equities of the hands `AcAs` (ace of clubs, ace of spades) versus `2h7d` (two of hearts, seven of diamonds). The aces have 87.4224% equity.

The command `ps_eval` can be called with an arbitrary number of hands. However, the number of hands has to be at least two.

``` r
ps_eval("AcAs", "2h7d", "KsKd", "7h8h")
#>   hand   equity   wins    ties
#> 1 AcAs 58.56780 635560   490.5
#> 2 2h7d  5.14126  43871 11963.5
#> 3 KsKd 16.97710 183882   490.5
#> 4 7h8h 19.31390 197787 11963.5
```

Postflop equities
-----------------

To calculate the postflop equities, a board has to be specified using the `board` parameter of `ps_eval`.

``` r
ps_eval("AcAs", "2h7d", board = "2c2d2s")
#>   hand   equity wins ties
#> 1 AcAs  0.10101    1    0
#> 2 2h7d 99.89900  989    0
```
