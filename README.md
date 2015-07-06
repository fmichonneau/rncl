[![Build Status](https://travis-ci.org/fmichonneau/rncl.svg)](https://travis-ci.org/fmichonneau/rncl.svg)
[![Build status](https://ci.appveyor.com/api/projects/status/bfcjqt83esp0nnak)](https://ci.appveyor.com/project/fmichonneau/rncl)
[![Coverage Status](https://coveralls.io/repos/fmichonneau/rncl/badge.svg)](https://coveralls.io/r/fmichonneau/rncl)

# An R interface to the NEXUS Class Library

This R package provides an interface to the C++ library NCL. It can parse
efficiently NEXUS and Newick file. Currently, the package focuses on retrieving
the phylogenetic trees included in these files. If you are interested in
retrieving other kind of data that NEXUS files may include, check out the
[phylobase](https://github.com/fmichonneau/phylobase) package.

The functions intended for users are: `read_nexus_phylo()` and
`read_newick_phylo()`. These functions read NEXUS and Newick files respectively,
and return (a valid) `phylo` or `multiPhylo` object.

The initial CRAN release for this package is 0.2.0.

# Windows builds

Because this package contains some C++ code, it can be tricky to build if you
are using Windows. You can obtain a version from
[here](https://ci.appveyor.com/project/fmichonneau/rncl/build/artifacts) (unless
the AppVeyor badge on top is gray, in which case you can download an older
version or come back in a few minutes, or red meaning the current version is
broken and you need to get an older version). Once in appveyor, look for the
file named `rncl_X.Y.Z.zip` where `X.Y.Z` represent the version number (e.g.,
`rncl_0.1.1.zip`). Then you can install this compiled version of the package
directly from R.
