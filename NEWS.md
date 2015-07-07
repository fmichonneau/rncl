
## rncl 0.2.4

### New feature

* `rncl` now allows the parsing of tree files that contain some missing edge
  lengths, using the `missing_edge_length` argument in the `read_newick_phylo`
  and `read_nexus_phylo`. By default, if a tree has at least one missing edge
  length, all edge lengths are dropped. Alternatively, the user can provide a
  numeric value that will be used to replace all missing edge lengths. (#33 from
  `rotl`)

### Major change

* Parsing tree files is now quiet, the default output of NCL is
  silenced. Because of the implementation of this output, it's difficult to give
  control to the user over this, but it's probably best to keep it quiet rather
  than having unneeded messages pollute the screen.

## rncl 0.2.2

* change roles in authors to have a single creator (`'cre'`)
* fix typo in documentation

## rncl 0.2.0

* initial release on CRAN
