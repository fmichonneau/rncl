---
title: An R interface to the NEXUS Class Library
---

[![Build Status](https://travis-ci.org/fmichonneau/rncl.svg)](https://travis-ci.org/fmichonneau/rncl)
[![Build status](https://ci.appveyor.com/api/projects/status/bfcjqt83esp0nnak)](https://ci.appveyor.com/project/fmichonneau/rncl)
[![Coverage Status](https://coveralls.io/repos/fmichonneau/rncl/badge.svg)](https://coveralls.io/r/fmichonneau/rncl)
![](http://cranlogs.r-pkg.org/badges/rncl)
[![Research software impact](http://depsy.org/api/package/cran/rncl/badge.svg)](http://depsy.org/package/r/rncl)

## An R interface to the NEXUS Class Library

This R package provides an interface to the C++ library
[NCL](http://phylo.bio.ku.edu/ncldocs/v2.1/funcdocs/index.html). It can parse
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


## Development versions for Windows

Because this package contains some C++ code, it can be tricky to build if you
are using Windows. Unless you need a feature only available on GitHub, install
`rncl` from CRAN.

Otherwise, you can obtain a binary version from
[here](https://ci.appveyor.com/project/fmichonneau/rncl/build/artifacts) (unless
the AppVeyor badge on top is gray, in which case you can download an older
version or come back in a few minutes, or red meaning the current version is
broken and you need to get an older version). Once in appveyor, look for the
file named `rncl_X.Y.Z.zip` where `X.Y.Z` represent the version number (e.g.,
`rncl_0.4.0.zip`). Then you can install this compiled version of the package
directly from R.
