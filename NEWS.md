
## rncl 0.4.0.999

## rncl 0.4.0

### New features

* `rncl` now allows the parsing of tree files that contain some missing edge
  lengths, using the `missing_edge_length` argument in the `read_newick_phylo`
  and `read_nexus_phylo`. By default, if a tree has at least one missing edge
  length, all edge lengths are dropped. Alternatively, the user can provide a
  numeric value that will be used to replace all missing edge lengths. (#33 from
  `rotl`)

* If `read_newick_phylo` and `read_nexus_phylo` return a list of trees, the
  elements of the list are named according to the names found in the tree file.

### Major changes

* Parsing tree files is now quiet, the default output of NCL is
  silenced. Because of the implementation of this output, it's difficult to give
  control to the user over this, but it's probably best to keep it quiet rather
  than having unneeded messages pollute the screen.

* The documentation of the function `rncl` is improved.

* The function `make_phylo` is now deprecated and will be removed in the next
  version. Use `read_newick_phylo` or `read_nexus_phylo` instead.

### Minor changes

* The option spacesAsUnderscore now also applies to the slot `taxaNames` and not
  only to the elements of the slot `taxonLabelVector`.

* If the file parsed contains trees that only include a subset of the taxa
  listed in the NEXUS taxa block, the function fails more explicitly.

### Bug fixes

* The slot `treeNames` had duplicated values for each tree name.
* Labels could have been assigned to the incorrect tips in some NEXUS files

## rncl 0.2.2

* change roles in authors to have a single creator (`'cre'`)
* fix typo in documentation

## rncl 0.2.0

* initial release on CRAN
