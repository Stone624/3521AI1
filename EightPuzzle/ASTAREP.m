%A*, given an instance of the 8 puzzle, will return the sequence
%of actions required to get from the initial state to the solved
%puzzle
function actionSequence = ASTAREP(instance)
actionSequence = [];
node{1} = instance;
front = 1;
parent = 0;
action = 0;
g(1) = 0;
f(1) = g(1) + heuristic(node{1});

while ~isempty(front)
    current = front(find(ismember(f(front),min(f(front)))));
    if length(current) > 1
        current = current(1);
    end
    if isequal(node{current},[1,2,3;4,5,6;7,8,0])
        while parent(current)
            actionSequence = [action(current) actionSequence];
            current = parent(current);
        end
        return;
    end
    front = [front(1:find(ismember(front,current))-1) front(((find(ismember(front,current)))+1):length(front))];
    movesAndActions = getPossibleMoves(node{current}.');
    possibleMoves = movesAndActions{1};
    possibleActions = movesAndActions{2};
    for neighbor=1:length(possibleMoves)
        if ~inseen(node,possibleMoves{neighbor})
            l=length(node)+1;
            node{l} = possibleMoves{neighbor};
            parent(l) = current;
            action(l) = possibleActions(neighbor);
            g(l) = g(current)+1;
            f(l) = g(l) + heuristic(node{l});
            front = [front l];
        end
    end
end
end

function movesAndActions = getPossibleMoves(currentInstance)
pos = find(~currentInstance);
switch pos
    case 1
        movesAndActions{2} = [3,4];
    case 2        
        movesAndActions{2} = [1,3,4];
    case 3        
        movesAndActions{2} = [1,4];
    case 4        
        movesAndActions{2} = [2,3,4];
    case 5
        movesAndActions{2} = [1,2,3,4];
    case 6
        movesAndActions{2} = [1,2,4];
    case 7
        movesAndActions{2} = [2,3];
    case 8
        movesAndActions{2} = [1,2,3];
    case 9
        movesAndActions{2} = [1,2];
end
for i=1:length(movesAndActions{2})
movesAndActions{1}{i} = getNewState(currentInstance, movesAndActions{2}(i), pos);
end
end

function state = getNewState(currentInstance, i, pos)
    switch i
        case 1%Left
            a=-1;                      
        case 2%Up
            a=-3;
        case 3%Right
            a=1;
        case 4%Down
            a=3;
        otherwise            
    end
    temp = currentInstance(pos+a);
    currentInstance(pos) = temp;
    currentInstance(pos+a) = 0;  
    state = currentInstance.';
end

function hx = heuristic(instance)
hx = 0;
for i=1:8
    actcol = mod(find(ismember(instance.',i))-1,3)+1;
    actrow = mod(find(ismember(instance,i))-1,3)+1;
    desrow = ceil(i/3);
    descol = mod(i-1,3)+1;
    hx = hx + abs(descol-actcol) + abs(desrow-actrow);
end
end

function in = inseen(nodes,move)
in=false;
for i=1:length(nodes)
    if isequal(move,nodes{i})
        in=true;
        return;
    end
end
end