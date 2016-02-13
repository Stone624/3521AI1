%IDS, given an instance of the 8 puzzle, will return the sequence
%of actions required to get from the initial state to the solved
%puzzle
function actionSequence = IDSEP(instance)
for i=1:22
%     fprintf('Checking Depth: %i\n',i);
    actionSequence = DFSEPDL(instance,1,i,{});
    if ~isempty(actionSequence)
        return;
    end
end
end

function actionSequence = DFSEPDL(instance,depth,maxDepth,nodes)
% cutoff=10;
actionSequence = [];
possibleMoves = [];
if depth < maxDepth% || maxDepth == cutoff
    movesAndActions = getPossibleMoves(instance.');
    possibleMoves = movesAndActions{1};
    possibleActions = movesAndActions{2};
    nodes{length(nodes)+1} = instance;
end
% if depth == cutoff
%     actionSequence = IDSEP(possibleMoves{randi(length(possibleMoves))});
%     return;
% end
l=length(possibleMoves);
for i=1:l
    if isequal(possibleMoves{i},[1,2,3;4,5,6;7,8,0])
        actionSequence = possibleActions(i);
        return;
    end
end
for i=l:-1:1
    if ~inseen(possibleMoves{i},nodes)
        j=randi(length(possibleMoves));
        actionSequence = [actionSequence DFSEPDL(possibleMoves{j},depth+1,maxDepth,nodes)];
        if ~isempty(actionSequence)
            actionSequence = [possibleActions(j) actionSequence];
            return;
        end
        possibleMoves = {possibleMoves{1:j-1},possibleMoves{j+1:length(possibleMoves)}};
        possibleActions = [possibleActions(1:j-1) possibleActions(j+1:length(possibleActions))];
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

function in = inseen(move,nodes)
in=false;
for i=1:length(nodes)
    if isequal(move,nodes{i})
        in=true;
        return;
    end
end
end