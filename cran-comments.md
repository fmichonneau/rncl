## Test environments
- local Ubuntu 15.04, R 3.2.1
- Ubuntu 12.04 (travis-ci), R 3.2.1
- Windows with win-builder (R-release and R-devel r68706)
- Debian testing with R-devel (r68712) compiled with gcc-5

## R CMD check results

- There were no errors or warnings.

- There were 2 NOTEs:
  * checking CRAN incoming feasibility ... NOTE
	Maintainer: ‘Francois Michonneau <francois.michonneau@gmail.com>’

	License components with restrictions and base license permitting such:
	  BSD_2_clause + file LICENSE
    File 'LICENSE':
	  YEAR: 2015
	  COPYRIGHT HOLDER: Francois Michonneau

	Possibly mis-spelled words in DESCRIPTION:
	 Newick (13:15)
     phylobase's (15:30)
     phylogenetic (13:32, 14:52)

	-- Newick is the name of a file format used in phylogenetics
	-- phylobase is an R package

	* checking installed package size ... NOTE
	  installed size is 21.3Mb
      sub-directories of 1Mb or more:
      libs  21.0Mb

## Downstream dependencies

* None
