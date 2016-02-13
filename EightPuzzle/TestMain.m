%Creates an instance, solves the puzzle with one of the de-commented
%algorithms, and prints the sequence of actions (L R U D) needed to
%move the blank from the initial state in order to solve the puzzle.
clear;
instance = [4,1,2;
            7,0,3;
            8,5,6];

% t=cputime;
% seq = BFSEP(instance);
% t = cputime-t;
% fprintf('BFS completed in %d seconds\nThe solution takes %d steps:\n',t,length(seq));

% t=cputime;
% seq = DFSEP(instance,{});
% t = cputime-t;
% fprintf('DFS completed in %d seconds\nThe solution takes %d steps:\n',t,length(seq));

% t=cputime;
% seq = IDSEP(instance);
% t = cputime-t;
% fprintf('IDS completed in %d seconds\nThe solution takes %d steps:\n',t,length(seq));

% t=cputime;
% seq = ASTAREP(instance);
% t = cputime-t;
% fprintf('ASTAR completed in %d seconds\nThe solution takes %d steps:\n',t,length(seq));

for i=1:length(seq)
    switch seq(i)
        case 1
            direction = 'L';
        case 2
            direction = 'U';
        case 3
            direction = 'R';
        case 4
            direction = 'D';
        otherwise
            direction = 'Unknown';
    end
    fprintf('%s\t',direction);
    if ~mod(i,10)
        fprintf('\n');
    end
end
fprintf('\n');