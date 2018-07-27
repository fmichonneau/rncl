#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .Call calls */
extern SEXP _rncl_collapse_single_cpp(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP _rncl_n_singletons(SEXP);
extern SEXP _rncl_RNCL(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_rncl_collapse_single_cpp", (DL_FUNC) &_rncl_collapse_single_cpp, 5},
    {"_rncl_n_singletons",        (DL_FUNC) &_rncl_n_singletons,        1},
    {"_rncl_RNCL",                (DL_FUNC) &_rncl_RNCL,                2},
    {NULL, NULL, 0}
};

void R_init_rncl(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
