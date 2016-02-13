clear
%initialize
%-------------------------------------------------------------------------
% % Randomized matrix of size size with percent percent chance of an edge
% existing
% size = 10;
% matrix(size,size)=0;
% n=50;
% for i=1:size
%     for j=1:size
%         if randi(100)<n 
%             num=1; 
%         else
%             num=0; 
%         end
%         matrix(i,j)=num;
%     end
% end
%-------------------------------------------------------------------------
matrix = [0,1,1;
0,0,1;
0,0,0];%<----- Edit matrix for initial input
startNode = 1;%randi(size);%<---- Start node for BFS

%run BFS
info = BFS(matrix,startNode);
dist = info{1};
pi = info{2};

%print and format
fprintf('BFS: ')
fprintf('\n\nNode:\t');
fprintf('%i\t',1:length(dist))
fprintf('\n\nDIST:\t');
fprintf('%d\t',dist);
fprintf('\n\nPI:\t');
fprintf('%d\t',pi);
fprintf('\n');

%run DFS
infoDFS = DFS(matrix);
disc = infoDFS{1};
finish = infoDFS{2};
piDFS = infoDFS{3};

%print and format
fprintf('\n\n\nDFS: ');
fprintf('\n\nNode:\t');
fprintf('%i\t',1:length(disc))
fprintf('\n\nDISC:\t');
fprintf('%d\t',disc);
fprintf('\n\nFINISH:\t');
fprintf('%d\t',finish);
fprintf('\n\nPI:\t');
fprintf('%d\t',piDFS);
fprintf('\n');