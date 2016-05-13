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
