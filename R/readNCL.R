##' Returns a list of the elements contained in a Nexus file used to
##' build phylogenetic objects in R
##'
##' The NEXUS class is a common file format used in
##' phylogenetics. This function calls NCL to parse NEXUS, newick or
##' other common phylogenetic file formats.
##' @title readNCL something
##' @param file something
##' @param simplify something
##' @param type something
##' @param char.all something
##' @param polymorphic.convert something
##' @param levels.uniform something
##' @param quiet something
##' @param check.node.labels something
##' @param return.labels something
##' @param file.format something
##' @param check.names something
##' @param ... something else
##' @author Francois Michonneau
##' @return something cool
##' @export
readNCL <- function(file,
                    char.all=FALSE, polymorphic.convert=TRUE,
                    levels.uniform=FALSE, quiet=TRUE,
                    file.format=c("nexus", "newick"),
                    check.names=TRUE,  ...) {

    file <- path.expand(file)
    if (!file.exists(file)) {
        stop(file, " doesn't exist.")
    }

    file.format <- match.arg(file.format)
    if (file.format == "newick") file.format <- "relaxedphyliptree"

    fileName <- list(fileName=file, fileFormat=file.format)
    parameters <- c(char.all, polymorphic.convert, levels.uniform, TRUE, TRUE)

    ## GetNCL returns a list containing:
    ##  $taxaNames: names of the taxa (from taxa block, implied or declared)
    ##  $treeNames: the names of the trees
    ##  $trees: a vector of (untranslated) Newick strings
    ##  $dataTypes: data type for each character block of the nexus file (length = number of chr blocks)
    ##  $nbCharacters: number of characters in each block (length = number of chr blocks)
    ##  $charLabels: the labels for the characters, i.e. the headers of the data frame to be returned
    ##    (length = number of chr blocks * sum of number of characters in each block)
    ##  $nbStates: the number of states of each character (equals 0 for non-standard types, length = number
    ##    of characters)
    ##  $stateLabels: the labels for the states of the characters, i.e. the levels of the factors to be returned
    ##  $dataChr: string that contains the data to be returned

    ncl <- GetNCL(fileName, parameters)

    ## Return Error message
    if (length(ncl) == 1 && names(ncl) == "ErrorMsg") {
        stop(ncl$ErrorMsg)
    }

    ncl
}

make_raw_phylo <- function(ncl) {
    if (length(ncl$trees) > 0) {
        listTrees <- vector("list", length(ncl$trees))

        for (i in 1:length(ncl$trees)) {
            edgeMat <- cbind(ncl$parentVector[[i]], 1:length(ncl$parentVector[[i]]))
            edgeMat <- edgeMat[-which(edgeMat[, 1] == 0), ]
            edgeLgth <- ncl$branchLengthVector[[i]]
            edgeLgth[edgeLgth == -1] <- NA
            ## TODO: code node labels in GetNCL

            nNodes <- length(ncl$parentVector[[i]]) - length(ncl$taxaNames)

            tr <- list(edge=edgeMat, tip.label=ncl$taxaNames, Nnode=nNodes)

            if (!all(is.na(edgeLgth))) {
                tr <- c(tr, edge.length=edgeLgth)
            }

            listTrees[[i]] <- tr
        }

    } else {
        return(NULL)
    }
    listTrees
}

make_phylo <- function(ncl, simplify=TRUE) {
    trees <- make_raw_phylo(ncl)
    trees <- lapply(trees, function(tr) {
        ape::collapse.singles(tr)
    })
    if (length(trees) == 1 || simplify) {
        trees <- trees[[1]]
        class(trees) <- "phylo"
    } else {
        stop("not yet implemented")
    }
    trees
}




##   ## Disclaimer
##     if (!length(grep("\\{", ncl$dataChr)) && return.labels && !polymorphic.convert) {
##         stop("At this stage, it's not possible to use the combination: ",
##              "return.labels=TRUE and polymorphic.convert=FALSE for datasets ",
##              "that contain polymorphic characters.")
##     }

##     if (returnData && length(ncl$dataChr)) {
##         tipData <- vector("list", length(ncl$dataChr))
##         for (iBlock in 1:length(ncl$dataTypes)) {
##             chrCounter <- ifelse(iBlock == 1, 0, sum(ncl$nbCharacters[1:(iBlock-1)]))
##             if (ncl$dataTypes[iBlock] == "Continuous") {
##                 for (iChar in 1:ncl$nbCharacters[iBlock]) {
##                     i <- chrCounter + iChar
##                     tipData[[i]] <- eval(parse(text=ncl$dataChr[i]))
##                     names(tipData)[i] <- ncl$charLabels[i]
##                 }
##             }
##             else {

##                 if (ncl$dataTypes[iBlock] == "Standard") {
##                     iForBlock <- integer(0)
##                     for (iChar in 1:ncl$nbCharacters[iBlock]) {
##                         i <- chrCounter + iChar
##                         iForBlock <- c(iForBlock, i)
##                         lblCounterMin <- ifelse(i == 1, 1, sum(ncl$nbStates[1:(i-1)]) + 1)
##                         lblCounter <- seq(lblCounterMin, length.out=ncl$nbStates[i])
##                         tipData[[i]] <- eval(parse(text=ncl$dataChr[i]))
##                         names(tipData)[i] <- ncl$charLabels[i]
##                         tipData[[i]] <- as.factor(tipData[[i]])

##                         lbl <- ncl$stateLabels[lblCounter]
##                         if (return.labels) {
##                             if (any(nchar(gsub(" ", "", lbl)) == 0)) {
##                                 warning("state labels are missing for \'", ncl$charLabels[i],
##                                         "\', the option return.labels is thus ignored.")
##                             }
##                             else {
##                                 levels(tipData[[i]]) <- lbl
##                             }
##                         }
##                     }
##                     if (levels.uniform) {
##                         allLevels <- character(0)
##                         for (j in iForBlock) {
##                             allLevels <- union(allLevels, levels(tipData[[j]]))
##                         }
##                         for (j in iForBlock) {
##                             levels(tipData[[j]]) <- allLevels
##                         }
##                     }
##                 }
##                 else {
##                     warning("This datatype is not currently supported by phylobase")
##                     next
##                     ## FIXME: different datatypes in a same file isn't going to work
##                 }
##             }
##         }
##         tipData <- data.frame(tipData, check.names=check.names)
##         if (length(ncl$taxaNames) == nrow(tipData)) {
##             rownames(tipData) <- ncl$taxaNames
##         }
##         else stop("phylobase doesn't deal with multiple taxa block at this time.")
##     }
##     else {
##         tipData <- NULL
##     }

##     if (returnTrees && length(ncl$trees) > 0) {
##         listTrees <- vector("list", length(ncl$trees))

##         for (i in 1:length(ncl$trees)) {
##             edgeMat <- cbind(ncl$parentVector[[i]], 1:length(ncl$parentVector[[i]]))
##             edgeLgth <- ncl$branchLengthVector[[i]]
##             edgeLgth[edgeLgth == -1] <- NA
##             if (length(ncl$taxaNames) != min(ncl$parentVector)-1) {
##                 stop("phylobase doesn't deal with multiple taxa block at this time.")
##             }
##             ## TODO: code node labels in GetNCL
##             tr <- list(edge=edgeMat,
##                        edge.length=edgeLgth,
##                        tip.label=ncl$taxaNames,
##                        ...)
##             listTrees[[i]] <- tr
##         }
##         if (length(listTrees) == 1 || simplify) {
##             listTrees <- listTrees[[1]]
##         }
##     }
##     else {
##         listTrees <- NULL
##     }

##     switch(type,
##            "data" = {
##                if (is.null(tipData)) {
##                    toRet <- NULL
##                }
##                else {
##                    toRet <- tipData
##                }
##            },
##            "tree" = {
##                if (is.null(listTrees)) {
##                    toRet <- NULL
##                }
##                else {
##                    toRet <- listTrees
##                }
##            },
##            "all" = {
##                if (is.null(tipData) && is.null(listTrees)) {
##                    toRet <- NULL
##                }
##                else if (is.null(tipData)) {
##                    toRet <- listTrees
##                }
##                else if (is.null(listTrees)) {
##                    toRet <- tipData
##                }
##                else {
##                    if (length(listTrees) > 1) {
##                        toRet <- lapply(listTrees, function(tr)
##                                        addData(tr, tip.data=tipData, ...))
##                    }
##                    else toRet <- addData(listTrees, tip.data=tipData, ...)
##                }
##            })
##     toRet
## }
