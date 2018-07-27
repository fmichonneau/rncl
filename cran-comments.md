## Test environments

- local Ubuntu 18.04, R 3.5.1
- Ubuntu 14.04 (travis-ci), R 3.5.0
- Windows with win-builder using R release (3.5.1) and R-devel r
- Debian testing with R-devel (2018-07-14 r74963)

## Notes

- This release fixes the NOTEs on the CRAN check results page about registering
  native routines and disabling symbol search
- It also addresses a warning detected by the upcoming relase of clang 7 brought
  up by Prof Brian Ripley in an email sent to me on 2018-07-27

## R CMD check results

- There were no errors or warnings.

## Downstream dependencies

- no changes to downstream dependencies
