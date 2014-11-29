[![Build Status](https://travis-ci.org/fmichonneau/rncl.svg)](https://travis-ci.org/fmichonneau/rncl.svg)
[![Build status](https://ci.appveyor.com/api/projects/status/bfcjqt83esp0nnak)](https://ci.appveyor.com/project/fmichonneau/rncl)

# An R interface to the NEXUS Class Library

# Windows builds

Because this package contains some C++ code, it can be tricky to build if you
are using Windows. You can obtain a version from
[https://ci.appveyor.com/project/fmichonneau/rncl/build/artifacts](here) (unless
the AppVeyor badge on top is gray, in which case you can download an older
version or come back in a few minutes, or red meaning the current version is
broken and you need to get an older version). Once in appveyor, look for the
file named `rncl_X.Y.Z.zip` where `X.Y.Z` represent the version number (e.g.,
`rncl_0.1.1.zip`). Then you can install this compiled version of the package
directly from R.
