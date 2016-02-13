%Creates and returns a set of 100 8-puzzle instances, ranging in
%difficulty by moves of sets of 4 ie: puzzles 1-4 have 1-4 moves
%from the start state, 5-8 have 5-8 moves from the start state,
%and so on.
function puzzles = getPuzzles()
for i=1:100
    puzzles{i} = createPuzzles((ceil(i/4))*4);
end
end

function puzzle = createPuzzles(difficulty)
    puzzle = [1,2,3;4,5,6;7,8,0];
    difficulty = randi([difficulty-3,difficulty]);
    nodes{1} = puzzle;
    retracts=0;
    fprintf('Creating puzzle of difficulty %i\n', difficulty);
    for i=1:difficulty
        movesAndActions = prune(getPossibleMoves(puzzle.'),nodes);
        if ~isempty(movesAndActions)
        move = randi(length(movesAndActions));
        puzzle = movesAndActions{move};
        nodes{length(nodes)+1} = movesAndActions{move};
        else
            retracts = retracts + 1;
            puzzle = nodes{length(nodes)-retracts};
            i=i-1;
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
movesAndActions = movesAndActions{1};
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

function moves = prune(moves, nodes)
    for i=1:length(nodes)
        for j=length(moves):-1:1
            if isequal(moves{j},nodes{i})
                moves = {moves{1:j-1},moves{j+1:length(moves)}};
            end
        end
    end
end