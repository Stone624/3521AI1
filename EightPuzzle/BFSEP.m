%BFS, given an instance of the 8 puzzle, will return the sequence
%of actions required to get from the initial state to the solved
%puzzle
function actionSequence = BFSEP(instance)
%Init
currentInstance = 1;%Numerical representation of the current node
times = 0;%Count of iterations through the while loop
parent = [];%parent(i) = parent of node i
action = [];%action(i) = action taken from parent(i) to get to node i
Q = [];%Queue of numerical nodes in order to be executed
node = {instance};%node{i} = The physical representation of state of the puzzle for node i
actionSequence = [];%The return value of actions to get to the goal state
found = false;
%loop through the tree until it finds the goal node
while(~found)% && times < 10000)
%     times = times+1;
%     fprintf('evaluating state %i\n', times);
     movesAndActions = getPossibleMoves(node{currentInstance}.');%NOTE: Pruning
%out possible moves/actions here reduces performance SIGNIFICANTLY compared
%to using ~inseen() to check if a potential move has been seen before
     possibleMoves = movesAndActions{1};
     possibleActions = movesAndActions{2};
    %set parents, actions
    for i=1:length(possibleMoves)
        if ~inseen(possibleMoves{i},node)
            l = length(node)+1;
            node{l} = possibleMoves{i};        
            parent(l) = currentInstance;
            action(l) = possibleActions(i);
            if isequal(node{l},[1,2,3;4,5,6;7,8,0])
                found = true;
                Q(1) = l;
                break;
            end
            %Enqueue possible moves
            Q = [Q l];
        end
    end
    
    %Dequeue and set new start
    currentInstance = Q(1);
    Q = Q(2:length(Q));
end

while parent(currentInstance)
    actionSequence = [action(currentInstance) actionSequence];
    currentInstance = parent(currentInstance);
end
% fprintf('BFS Eight Puzzle completed in %d iterations\n',times);
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

function in = inseen(move,nodes)
in=false;
for i=1:length(nodes)
    if isequal(move,nodes{i})
        in=true;
        return;
    end
end
end