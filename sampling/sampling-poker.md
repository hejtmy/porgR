Sampling demonstration
================
Lukáš Hejtmánek
8 October 2018

Basic descriptors
=================

So in our case we have a mean 5.40625 and a following distribution.

![](sampling-poker_files/figure-markdown_github/unnamed-chunk-1-1.png)

looking at each separately, we get

![](sampling-poker_files/figure-markdown_github/unnamed-chunk-2-1.png)

Sampling
--------

Sampling two poker chips

Let's have a look at the means of those 100 samples of 10 percent of data ![](sampling-poker_files/figure-markdown_github/unnamed-chunk-4-1.png)

| type            |  min|   max|
|:----------------|----:|-----:|
| bias\_extremes  |  1.0|   8.0|
| extremes        |  1.0|  10.0|
| missing         |  3.0|   6.0|
| normal          |  3.5|   6.5|
| normal\_shifted |  5.5|   8.5|

### Sampling 4 poker chips

Let's have a look at the means of those 100 samples of 10 percent of data ![](sampling-poker_files/figure-markdown_github/unnamed-chunk-6-1.png)

| type            |   min|   max|
|:----------------|-----:|-----:|
| bias\_extremes  |  2.75|  6.75|
| extremes        |  2.25|  8.25|
| missing         |  3.00|  6.00|
| normal          |  4.25|  5.75|
| normal\_shifted |  6.25|  7.75|
