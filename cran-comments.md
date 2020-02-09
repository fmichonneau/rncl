## Test environments

- local Ubuntu 18.10, R 3.6.2
- Ubuntu 16.04 (travis-ci), R 3.6.2
- Windows with win-builder using R release (3.6.2) and R-devel
- Ubuntu 18.04 - R Under development (unstable) (2020-02-08 r77786)
- Debian testing with R-devel (2018-07-14 r74963)

## Notes

- This release fixes the WARNINGS on the CRAN check results page.

## R CMD check results

- There were no errors or warnings.
- There is a NOTE about a possibly invalid URL but the link works:

   Found the following (possibly) invalid URLs:
     URL: https://doi.org/10.1093/sysbio/46.4.590
       From: man/rncl.Rd
       Status: Error
       Message: libcurl error code 56:
         	Recv failure: Connection was reset

## Downstream dependencies

- no changes to downstream dependencies
