##' Returns a list of the elements contained in a NEXUS file used to
##' build phylogenetic objects in R
##'
##' NEXUS is a common file format used in phylogenetics to represent
##' phylogenetic trees, and other types of phylogenetic data. This
##' function uses NCL (the NEXUS Class Library) to parse NEXUS, Newick
##' or other common phylogenetic file formats, and returns the
##' relevant elements as a list. \code{phylo} (from the ape package)
##' or \code{phylo4} (from the phylobase package) can be constructed
##' from the elements contained in this list.
##' @title Get all the elements from a NEXUS (or Newick) file
##' @param file path to a NEXUS or Newick file
##' @param file.format something a character string indicating the
##' type of file to be parsed.
##' @param spacesAsUnderscores In the NEXUS file format white spaces
##' are not allowed in taxa labels and are represented by
##' underscores. Therefore, NCL converts underscores found in taxa
##' labels in the NEXUS file into white spaces (e.g. \code{species_1}
##' will become \code{"species 1"}. If you want to preserve the
##' underscores, set as TRUE, the default).
##' @param ... additional parameters (currently not in use).
##' @author Francois Michonneau
##' @return A list that contains the following:
##' *
##' @export
rncl <- function(file, file.format = c("nexus", "newick"),
                 spacesAsUnderscores = TRUE, ...) {

    file <- path.expand(file)
    if (!file.exists(file)) {
        stop(file, " doesn't exist.")
    }

    file.format <- match.arg(file.format)
    if (file.format == "newick") file.format <- "relaxedphyliptree"

    fileName <- list(fileName=file, fileFormat=file.format)

    ## Order of the logical parameters for GetNCL R (and C++) arguments
    ## - char.all (charall)
    ## - polymorphic.convert (polyconvert)
    ## - levels.uniform (levelsUnif)
    ## - (returnTrees)
    ## - (returnData)
    #parameters <- c(char.all, polymorphic.convert, levels.uniform, TRUE, TRUE)
    parameters <- c(TRUE, TRUE, TRUE, TRUE, FALSE)

    ncl <- RNCL(fileName, parameters)

    if (spacesAsUnderscores) {
        ncl$taxonLabelVector <- lapply(ncl$taxonLabelVector, function(x) {
            gsub("\\s", "_", x)
        })
    }

    ## Return Error message
    if (exists("ErrorMsg", where=ncl)) {
        stop(ncl$ErrorMsg)
    }

    ncl
}

## Returns the edge matrix from the parentVector (the i^th element is
## the descendant element of node i)
get_edge_matrix <- function(parentVector) {
    edgeMat <- cbind(parentVector, 1:length(parentVector))
    rootNd <- edgeMat[which(edgeMat[, 1] == 0), 2]
    edgeMat <- edgeMat[-which(edgeMat[, 1] == 0), ]
    attr(edgeMat, "root") <- rootNd
    edgeMat
}

## Returns the edge lengths (missing are represented by -1)
get_edge_length <- function(branchLengthVector, parentVector) {
    edgeLgth <- branchLengthVector[which(parentVector != 0)]
    edgeLgth[edgeLgth == -1] <- NA
    edgeLgth
}

## Tests whether there are node labels
has_node_labels <- function(nodeLabelsVector) {
    any(nzchar(nodeLabelsVector))
}


## Pieces together the elements needed to build a phylo object, but
## they are not converted as such to allow for singletons (and
## possibly other kinds of trees that phylo doesn't support)
build_raw_phylo <- function(ncl) {
    if (length(ncl$trees) > 0) {
        listTrees <- vector("list", length(ncl$trees))

        for (i in 1:length(ncl$trees)) {
            edgeMat <- get_edge_matrix(ncl$parentVector[[i]])
            rootNd <- attr(edgeMat, "root")
            attr(edgeMat, "root") <- NULL
            attr(edgeMat, "dimnames") <- NULL

            edgeLgth <- get_edge_length(ncl$branchLength[[i]], ncl$parentVector[[i]])

            nNodes <- length(ncl$parentVector[[i]]) - length(ncl$taxaNames)

            tr <- list(edge=edgeMat, tip.label=ncl$taxonLabelVector[[i]],
                       Nnode=nNodes)

            if (!all(is.na(edgeLgth))) {
                if (any(is.na(edgeLgth))) {
                    stop("missing edge lengths are not allowed in phylo class")
                }
                tr <- c(tr, list(edge.length=edgeLgth))
            }

            if (has_node_labels(ncl$nodeLabelsVector[[i]])) {
                ntips <- length(tr$tip.label)
                ndLbl <- ncl$nodeLabelsVector[[i]]
                ndLbl[rootNd] <- ndLbl[1]
                tr <- c(tr, list(node.label=ndLbl[(ntips+1):length(ndLbl)]))
            }

            listTrees[[i]] <- tr
        }

    } else {
        return(NULL)
    }
    listTrees
}

## polishes things up
build_phylo <- function(ncl, simplify=FALSE) {
    trees <- build_raw_phylo(ncl)
    trees <- lapply(trees, function(tr) {
        tr <- ape::collapse.singles(tr)
        class(tr) <- "phylo"
        tr
    })
    if (length(trees) == 1 || simplify) {
        trees <- trees[[1]]
    } else {
        class(trees) <- "multiPhylo"
    }
    trees
}

##' Create phylo objects from NEXUS or Newick files
##'
##' These functions read NEXUS or Newick files and return an object of
##' class phylo/multiPhylo.
##' @title Read phylogenetic trees from files
##' @param file Path of NEXUS or Newick file
##' @param simplify If the file includes more than one tree, returns
##' only the first tree; otherwise, returns a multiPhylo object
##' @param ... additional parameters to be passed to the rncl function
##' @return A phylo or a multiPhyloo object
##' @author Francois Michonneau
##' @seealso rncl, and the
##' @rdname read_nexus_phylo
##' @note make_phylo may become deprecated in the future, use
##' read_nexus_phylo or read_newick_phylo instead.
##' @export
make_phylo <- function(file, simplify=FALSE, ...) {
    ncl <- rncl(file=file, ...)
    build_phylo(ncl, simplify=simplify)
}

##' @rdname read_nexus_phylo
##' @export
read_nexus_phylo <- function(file, simplify=FALSE, ...) {
    make_phylo(file=file, simplify=simplify, file.format="nexus", ...)
}

##' @rdname read_nexus_phylo
##' @export
read_newick_phylo <- function(file, simplify=FALSE, ...) {
    make_phylo(file=file, simplify=simplify, file.format="newick", ...)
}
