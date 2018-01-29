##' @importFrom progress progress_bar
##' @importFrom Rcpp loadRcppModules
##' @importFrom stats na.omit
collapse_singles <- function(tree, show_progress) {

    if (is.null(tree$edge.length)) {
        elen <- numeric(0)
    } else {
        elen <- tree$edge.length
    }

    res <- collapse_single_cpp(
        ances = tree$edge[, 1],
        desc = tree$edge[, 2],
        elen = elen,
        nnode = tree$Nnode,
        show_progress = show_progress
    )

    new_mat <- matrix(c(res$ances, res$desc), ncol = 2)
    tree$edge <- new_mat

    if (length(res$edge.length) > 1) {
        tree$edge.length <- res$edge.length
    }

    tree$Nnode <- res$Nnode

    if (!is.null(tree$node.label)) {
        idx_nd_lbl <- res$position_singletons + 1  - length(tree$tip.label)

        warning("Dropping singleton nodes with labels: ",
                paste(stats::na.omit(tree$node.label[idx_nd_lbl]), collapse = ", "))

        tree$node.label <- tree$node.label[- idx_nd_lbl]
    }

    tree
}
