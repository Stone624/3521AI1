%BFS takes a NxN adjacency matrix and a start node as an argument and 
%returns a cell with distance and predecessors in arrays such that:
%BFSreturn{1}(x) = node x's distance from start node
%BFSreturn{2}(x) = node x's predecessor
function BFSreturn = BFS(matrix, s)
%initialize
info = initialize(matrix);
colors = info{1};
dist = info{2};
pi = info{3};
Q = s;
colors{s} = 'grey';
dist(s) = 0;

%loop through
while ~isempty(Q)
    %set Dequeue, set current node, and get adj list
    currentNode = Q(1);
    Q=Q(2:length(Q));
    adj = find(matrix(currentNode,1:length(matrix)));%getAdjList(matrix,currentNode);
    %go through adjacency list,and if white, change color to grey, assign
    %distance, predecessor, and enqueue.
    for i=1:length(adj)
        if strcmp(colors{adj(i)}, 'white')
            colors{adj(i)} = 'grey';
            dist(adj(i)) = dist(currentNode)+1;
            pi(adj(i)) = currentNode;
            Q = [Q adj(i)];
        end
    end
    colors{currentNode} = 'black';
end
%set return value
BFSreturn = {dist, pi};
end

%initializes all colors to white, dists to inf, and predecessors to -1
function init = initialize(matrix)
for i=1:length(matrix) 
    colors{i}='white';
    dist(i)=inf;
    pi(i)=-1;
end
init = {colors, dist, pi};
end