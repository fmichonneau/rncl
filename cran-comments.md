## Test environments

- local Ubuntu 16.10, R 3.3.2
- Ubuntu 12.04 (travis-ci), R 3.3.1
- Windows with R-hub using R-devel r71655
- Debian testing with R-devel (r71774)

## R CMD check results

- There were no errors or warnings.

- There were 2 NOTEs:

* checking CRAN incoming feasibility ... NOTE
	Maintainer: ‘Francois Michonneau <francois.michonneau@gmail.com>’

	License components with restrictions and base license permitting such:
		BSD_2_clause + file LICENSE
	File 'LICENSE':
		YEAR: 2016
		COPYRIGHT HOLDER: Francois Michonneau

	Possibly mis-spelled words in DESCRIPTION:
		Newick (13:15)
		phylobase's (15:30)
		phylogenetic (13:32, 14:52)

  * checking installed package size ... NOTE
	installed size is 22.9Mb
	sub-directories of 1Mb or more:
		libs  22.6Mb

## Downstream dependencies

- no changes to downstream dependencies
