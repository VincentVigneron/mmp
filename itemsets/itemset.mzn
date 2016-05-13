include "nvalue.mzn";
include "increasing.mzn";

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

%%%%%%%%%%%%%%
% SYM. BREAK %
%%%%%%%%%%%%%%
constraint forall(j in 1..q)(
	(j > n) -> forall(i in 1..p)(v[i,j] == v[i,n])
);

constraint forall(i in 1..p)(
	(i > m) -> forall(j in 1..q)(v[i,j] == v[m,j])
);

%%%%%%%%%%%%%
% BRANCHING %
%%%%%%%%%%%%%
solve :: seq_search([
		int_search([m], input_order, indomain_median, complete),
		int_search(s1, input_order, indomain_random, complete),
		int_search([n], input_order, indomain_median, complete),
		int_search(s2, input_order, indomain_random, complete)])
	satisfy;

%%%%%%%%%%%
% DISPLAY %
%%%%%%%%%%%
output
	["   | "] ++ [show_int(3,s2[j]) ++ " " | j in 1..q] ++ [" : " ++ show(n) ++ "\n"] ++
	["---+-"] ++ ["----" | j in 1..q] ++ ["\n"] ++
	[if j == 0 then
		show_int(3,s1[i]) ++ "| "
	else
		show_int(3,v[i,j]) ++
		if j == q then "\n" else " " endif
	endif
	| i in 1..p, j in 0..q] ++
	["---+\n"] ++
	[show_int(3,m) ++ "\n"];
