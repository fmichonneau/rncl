<!-- badges: start -->
[![R-CMD-check](https://github.com/fmichonneau/rncl/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fmichonneau/rncl/actions/workflows/R-CMD-check.yaml)
![](http://cranlogs.r-pkg.org/badges/rncl)
[![Codecov test coverage](https://codecov.io/gh/fmichonneau/rncl/graph/badge.svg)](https://app.codecov.io/gh/fmichonneau/rncl)
<!-- badges: end -->


## An R interface to the NEXUS Class Library

This R package provides an interface to the C++ library
[NCL](https://github.com/mtholder/ncl). It can parse
efficiently common file formats used to store phylogenetic trees, especially
NEXUS and Newick files.

This package is primarily intended to be used by package developers as it
extracts the elements needed to build R objects that represent the content of
the file. For instance, [phylobase](https://github.com/fmichonneau/phylobase)
uses `rncl` to extract trees and/or data stored in NEXUS and Newick files to
create objects of class `phylo4` or `phylo4d`.

The package however provides two functions for users: `read_nexus_phylo()` and
`read_newick_phylo()`. They read NEXUS and Newick files respectively, and return
(a valid) `phylo` or `multiPhylo` object from the package
[ape](https://cran.r-project.org/package=ape). These functions differ from those
found in ape (respectively `read.tree` and `read.nexus`) as `rncl` functions can
read trees with singletons, and missing branch lengths. However, `rncl` adheres
to the NEXUS standards and only accepts tip labels without white spaces and tip
labels cannot be duplicated in the same tree.
