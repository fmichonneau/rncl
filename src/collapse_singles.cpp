#include <Rcpp.h>
#include <iostream>
#include <set>
#include <algorithm>
#include <RProgress.h>

std::vector<int> tabulate_tips (Rcpp::IntegerVector ances) {
// tabulates ancestor nodes that are not the root.
    int n = Rcpp::max(ances);
    std::vector<int> ans(n);
    for (int i=0; i < ances.size(); i++) {
        int j = ances[i];
        if (j > 0) {
            ans[j - 1]++;
        }
    }
    return ans;
}

bool is_one(int i) { return ( i == 1 ); }

//[[Rcpp::export]]
int n_singletons (Rcpp::IntegerVector ances) {
    std::vector<int> tab_tips = tabulate_tips(ances);
    int j = count_if (tab_tips.begin(), tab_tips.end(), is_one);
    return j;
}


Rcpp::IntegerVector which_integer(Rcpp::IntegerVector x, Rcpp::IntegerVector yInt) {
  Rcpp::IntegerVector v = Rcpp::seq(0, x.size()-1);
  int y(1);
  y = yInt[0];
  return v[x == y];
}

Rcpp::IntegerVector match_and_substract(Rcpp::IntegerVector x, Rcpp::IntegerVector yInt) {
    int y(1);
    y = yInt[0];
    for (unsigned k=0; k < x.size(); ++k) {
	if (x[k] > y)
	    x[k] = x[k] - 1;
    }
    return x;
}

std::vector<int> match_and_substract (std::vector<int> x, int y) {
    for (unsigned k=0; k < x.size(); ++k) {
 	if (x[k] > y)
 	    x[k] = x[k] - 1;
     }
     return x;
}


//[[Rcpp::export]]
Rcpp::List collapse_single_cpp(
    Rcpp::IntegerVector ances,
    Rcpp::IntegerVector desc,
    Rcpp::NumericVector elen,
    Rcpp::NumericVector nnode,
    Rcpp::LogicalVector show_progress) {

    int n_singles = n_singletons(ances);

    std::vector<int> tab_node = tabulate_tips(ances);
    Rcpp::IntegerVector tab_node_rcpp(tab_node.size());
    tab_node_rcpp = tab_node;
    Rcpp::IntegerVector position_singleton = which_integer(tab_node_rcpp, Rcpp::IntegerVector::create(1));
    Rcpp::IntegerVector position_singleton_orig = position_singleton;

    RProgress::RProgress pb("Progress [:bar] :current/:total (:percent) :eta", (double) n_singles, 60);

    if (show_progress) {
	pb.tick(0);
    }

    while (position_singleton.size() > 0) {
	// Rcpp::Rcout << "tabNode is ";
	//     for (unsigned k = 0; k < tabNode.size(); ++k)
	// 	Rcpp::Rcout << " " << tabNode[k];
	// Rcpp::Rcout << std::endl;
	// Rcpp::Rcout << "position singleton is ";
	// for (unsigned k = 0; k < positionSingleton.size(); ++k)
	//     Rcpp::Rcout << " " << positionSingleton[k];
	// Rcpp::Rcout << std::endl;
	int i = position_singleton[0];
	Rcpp::IntegerVector iV(1);
	iV = i;
	//Rcpp::Rcout << "i is " << i << " and iV is " << iV << std::endl;
	Rcpp::IntegerVector prev_node = which_integer(desc, iV + 1);
	Rcpp::IntegerVector next_node = which_integer(ances, iV + 1);
	//Rcpp::Rcout << "prev_node is " << prev_node << " and next_node is " << next_node << std::endl;
	//Rcpp::Rcout << "before desc:";
	//for (unsigned k = 0; k < desc.size(); ++k)
	//    Rcpp::Rcout << " " << desc[k];
	//Rcpp::Rcout << std::endl;
	desc[prev_node] = desc[next_node];
	//Rcpp::Rcout << "after desc:";
	//for (unsigned k = 0; k < desc.size(); ++k)
	//    Rcpp::Rcout << " " << desc[k];
	//Rcpp::Rcout << std::endl;
	Rcpp::IntegerVector to_rm = which_integer(ances, iV + 1);
	//Rcpp::Rcout << "to_rm is " << to_rm << std::endl;
	desc.erase(to_rm[0]);
	ances.erase(to_rm[0]);
	desc = match_and_substract(desc, iV);
	ances = match_and_substract(ances, iV);
	nnode = nnode - 1;

	if (elen.size() > 0) {
	    elen[prev_node] = elen[prev_node] + elen[next_node];
	    elen.erase(next_node[0]);
	}

	tab_node = tabulate_tips(ances);
	tab_node_rcpp(tab_node.size());
	tab_node_rcpp = tab_node;
	position_singleton = which_integer(tab_node_rcpp, Rcpp::IntegerVector::create(1));

	if (show_progress) {
	    pb.tick();
	}
    }

    Rcpp::List res = Rcpp::List::create(
	Rcpp::Named("ances") = ances,
	Rcpp::Named("desc") = desc,
	Rcpp::Named("Nnode") = nnode,
	Rcpp::Named("edge.length") = elen,
	Rcpp::Named("position_singletons") = position_singleton_orig);

    return res;
}
