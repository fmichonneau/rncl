// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// RNCL
Rcpp::List RNCL(SEXP params, SEXP paramsVecR);
RcppExport SEXP _rncl_RNCL(SEXP paramsSEXP, SEXP paramsVecRSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type params(paramsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type paramsVecR(paramsVecRSEXP);
    rcpp_result_gen = Rcpp::wrap(RNCL(params, paramsVecR));
    return rcpp_result_gen;
END_RCPP
}
// n_singletons
int n_singletons(Rcpp::IntegerVector ances);
RcppExport SEXP _rncl_n_singletons(SEXP ancesSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type ances(ancesSEXP);
    rcpp_result_gen = Rcpp::wrap(n_singletons(ances));
    return rcpp_result_gen;
END_RCPP
}
// collapse_single_cpp
Rcpp::List collapse_single_cpp(Rcpp::IntegerVector ances, Rcpp::IntegerVector desc, Rcpp::NumericVector elen, Rcpp::NumericVector nnode, Rcpp::LogicalVector show_progress);
RcppExport SEXP _rncl_collapse_single_cpp(SEXP ancesSEXP, SEXP descSEXP, SEXP elenSEXP, SEXP nnodeSEXP, SEXP show_progressSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type ances(ancesSEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type desc(descSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type elen(elenSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type nnode(nnodeSEXP);
    Rcpp::traits::input_parameter< Rcpp::LogicalVector >::type show_progress(show_progressSEXP);
    rcpp_result_gen = Rcpp::wrap(collapse_single_cpp(ances, desc, elen, nnode, show_progress));
    return rcpp_result_gen;
END_RCPP
}
