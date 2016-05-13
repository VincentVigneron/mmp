int: goods;
set of int: GOODS = 1..goods;

int: bids;
set of int: BIDS = 1..bids;

var int: cost;
array[BIDS] of int: costs;
array[BIDS,GOODS] of int: transactions; %% bool

array[BIDS] of var bool: solutions;

constraint forall(good in GOODS)(
	sum(bid in BIDS)(bool2int(solutions[bid])*transactions[bid,good]) <= 1
);

constraint cost == sum(bid in BIDS)(bool2int(solutions[bid])*costs[bid]);

%%%%%%%%%%%%%
% BRANCHING %
%%%%%%%%%%%%%
solve :: int_search(solutions, input_order, indomain_max, complete) maximize cost;

%%%%%%%%%%%
% DISPLAY %
%%%%%%%%%%%
output
	["cost: " ++ show(cost) ++ "\n"] ++
	[show(solutions[i]) ++ " " | i in BIDS] ++ ["\n"];
