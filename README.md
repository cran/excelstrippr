
<!-- README.md is generated from README.Rmd. Please edit that file -->

# excelstrippr ![excelstrippr sticker](./man/img/sticker-small.png)

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/burch-cm/metastrippr.svg?branch=master)](https://travis-ci.com/burch-cm/metastrippr)
<!-- badges: end -->

The goal of excelstrippr is to provide an easy way to remove the
extraneous metadata, headers, summaries, etc., and extract the useful
tabular data from Excel-based reports.

## The Problem

Excel reports often contain titles, data summaries, line counts, empty
columns, etc., which make importing them into R a troublesome process.
As there is no universal Excel report format, it’s difficult to write a
reusable script to munge and import the data from these reports.

An example Excel report might look like this:  
![Example Excel Report](./man/img/init-excel.png)

Unhiding hidden elements and adjusting empty columns to make them more
clear shows that this report isn’t in any kind of standard tabular
format:  
![Example Excel Report - Unhidden](./man/img/unhidden-excel.png)

When this data is imported into R, the results are not useful without
serious wrangling:

``` r
dat <- readxl::read_excel("./man/example/example-report.xlsx")
#> New names:
#> * `` -> ...2
#> * `` -> ...3
#> * `` -> ...4
#> * `` -> ...5
#> * `` -> ...6
#> * ...
head(dat, 10)
#> # A tibble: 10 x 28
#>    `Transaction De~ ...2  ...3  ...4  ...5  ...6  ...7  ...8  ...9  ...10 ...11
#>    <lgl>            <chr> <chr> <chr> <chr> <chr> <chr> <lgl> <chr> <chr> <chr>
#>  1 NA               <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  NA    <NA>  <NA>  <NA> 
#>  2 NA               <NA>  4120~ <NA>  <NA>  <NA>  <NA>  NA    <NA>  <NA>  <NA> 
#>  3 NA               <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  NA    <NA>  <NA>  <NA> 
#>  4 NA               Regi~ <NA>  LOB   CC    Loc ~ Fac ~ NA    JON/~ Doc # Type 
#>  5 NA               Alas~ <NA>  ATO   40022 APX   EQUIP NA    <NA>  2019~ Add ~
#>  6 NA               Alas~ <NA>  ATO   40046 APX   EQUIP NA    <NA>  2019~ Add ~
#>  7 NA               Alas~ <NA>  ATO   40085 APX   EQUIP NA    <NA>  2019~ Add ~
#>  8 NA               Alas~ <NA>  ATO   40050 APX   ARTCC NA    <NA>  2019~ Add ~
#>  9 NA               Alas~ <NA>  ATO   40009 APX   ARTCC NA    <NA>  2019~ Add ~
#> 10 NA               Alas~ <NA>  ATO   40046 APX   ARTCC NA    <NA>  2019~ Add ~
#> # ... with 17 more variables: ...12 <chr>, ...13 <chr>, ...14 <chr>,
#> #   ...15 <chr>, ...16 <chr>, ...17 <lgl>, ...18 <chr>, ...19 <chr>,
#> #   ...20 <chr>, ...21 <chr>, ...22 <chr>, ...23 <chr>, ...24 <chr>,
#> #   ...25 <chr>, ...26 <chr>, ...27 <chr>, ...28 <chr>
```

## The Solution

excelstrippr will look for the start of a tabular data set in an Excel
file, ignoring titles, summaries, and other meta-data in the report.

``` r
library(excelstrippr)
dat_stripped <- strip_metadata("./man/example/example-report.xlsx")
#> New names:
#> * `` -> ...1
#> * `` -> ...2
#> * `` -> ...3
#> * `` -> ...4
#> * `` -> ...5
#> * ...
head(dat_stripped, 10)
#> # A tibble: 0 x 24
#> # ... with 24 variables: Region <chr>, LOB <chr>, CC <chr>, `Loc ID` <chr>,
#> #   `Fac Type` <chr>, `JON/DPN` <chr>, `Doc #` <chr>, Type <chr>, Status <chr>,
#> #   `Asset Type` <chr>, `Initiated By` <chr>, `Initiate Date` <chr>,
#> #   Custodian <chr>, Barcode <chr>, `NSN/LSN` <chr>, Description <chr>, `Serial
#> #   #` <chr>, `Delphi Asset #` <chr>, Cost <chr>, Qty <chr>, `Rejected
#> #   By` <chr>, `Rej Reason` <chr>, `Rej Date` <chr>, `Test Equip` <chr>
```

The extracted data can then be saved back into another file for future
analysis or can be immediately used in analysis pipeline as any other
data frame object.

## Installation

You can install the released version of excelstrippr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("excelstrippr")
```

The most recent version of excelstrippr can be installed from
[GitHub](https://github.com/burch-cm/excelstrippr) with {devtools}:

``` r
install.packages("devtools")
devtools::install_github("burch-cm/excelstrippr")
```
