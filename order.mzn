include "nvalue.mzn";
include "increasing.mzn";
include "among.mzn";

%%%%%%%%
% ROWS %
%%%%%%%%
int: p;

var 1..p: m;
array[1..p] of var 1..p: s1;

constraint nvalue(m,s1);
constraint increasing(s1);
constraint s1[p] == s1[m];

%%%%%%%%
% COLS %
%%%%%%%%
int: q;

var 1..q: n;
array[1..q] of var 1..q: s2;

constraint nvalue(n,s2);
constraint increasing(s2);
constraint s2[q] == s2[n];

%%%%%%%
% MAT %
%%%%%%%
set of int: D;
array[1..p,1..q] of set of D: DB;

array[1..p,1..q] of var D: v;

constraint forall(i in 1..p, j in 1..q)(
	v[i,j] in DB[s1[i],s2[j]]
);

%%%%%%%%%
% ORDER %
%%%%%%%%%
constraint forall(j in 1..q)(
	(j == n) -> forall(i in 1..p)(
		(i <= m) -> increasing([v[i,l] | l in 1..j])
	)
);

%%%%%%%%%%%%%%
% POS. COVER %
%%%%%%%%%%%%%%
%set of int: pos;

%constraint forall(i in 1..p)(
%	(i == m) -> among(card(pos),[s1[k] | k in 1..i],pos)
%);

%%%%%%%%%%%%%
% BRANCHING %
%%%%%%%%%%%%%
solve :: seq_search([
		int_search([m], input_order, indomain_max, complete),
		int_search(s1, input_order, indomain_min, complete),
		int_search([n], input_order, indomain_max, complete),
		int_search(s2, input_order, indomain_min, complete)])
	maximize p*m+n; % maximize cover then maximize cardinality

%%%%%%%%%%%
% DISPLAY %
%%%%%%%%%%%
output
	["s1 : "] ++ [show_int(3,s1[i]) ++ " " | i in 1..p] ++ ["\n"] ++
	["s2 : "] ++ [show_int(3,s2[j]) ++ " " | j in 1..q] ++ ["\n"] ++
	[show(m) ++ "x" ++ show(n) ++ "\n"] ++
	[show_int(3,v[i,j]) ++ if j == q then "\n" else " " endif | i in 1..p, j in 1..q];
