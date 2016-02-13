%Creates 100 random puzzles of 25 different difficulties, runs BFS,
%DFS, IDS, and finally ASTAR on all puzzles, takes the average of
%time it took to run all 100 puzzles on an algorithm, and prints the
%results.

% clear;
% puzzles = getPuzzles();

%BFS
% t=cputime;
% for i=1:length(puzzles)
%     fprintf('BFS Solving puzzle %i\n',i);
%     BFSEP(puzzles{i});
% end
% t = cputime-t;
% BFStime=t/length(puzzles);

%DFS
% t=cputime;
% for i=1:length(puzzles)
%     fprintf('DFS Solving puzzle %i\n',i);
%     DFSEP(puzzles{i});
% end
% t = cputime-t;
% DFStime=t/length(puzzles);

%IDS
t=cputime;
for i=1:length(puzzles)
    fprintf('IDS Solving puzzle %i\n',i);
    IDSEP(puzzles{i});
end
t = cputime-t;
IDStime=t/length(puzzles);

%A*
% t=cputime;
% for i=1:length(puzzles)
%     fprintf('A* Solving puzzle %i\n',i);
%     ASTAREP(puzzles{i});
% end
% t = cputime-t;
% ASTARtime=t/length(puzzles);



% fprintf('Average BFS time: %d\n',BFStime);
% fprintf('Average DFS time: %d\n',DFStime);
fprintf('Average IDS time: %d\n',IDStime);
% fprintf('Average A* time: %d\n',ASTARtime);