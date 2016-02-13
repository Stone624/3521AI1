%DFS takes a NxN adjacency matrix as an argument and returns a cell with
%discovery time, finish time, and predecessors in arrays such that
%DFSreturn{1}(x) = node x's discovery time
%DFSreturn{2}(x) = node x's finishing time
%DFSreturn{3}(x) = node x's predecessor
function DFSreturn = DFS(matrix)
%initialize
info = initialize(matrix);
colors = info{1};
disc = info{2};
finish = info{3};
pi = info{4};
stack = [];
time = 0;

%loop through
while ~allBlack(colors)
    %increment time, select new node, and get adj list
    time = time+1;
    if ~isempty(stack) 
        currentNode = stack(length(stack)); 
    else
        possible = find(ismember(colors,'white')); 
        currentNode = possible(1); 
        stack = currentNode;
        colors{currentNode} = 'grey';
        disc(currentNode) = time;
        time=time+1;
    end
    adj = find(matrix(currentNode,1:length(matrix)));
    
    %find possible adjacent nodes, pick one, and update it, OR finish 
    %and backtrack
    possible = find(ismember(colors(adj),'white'));
    if ~isempty(possible)
        stack = [stack adj(possible(1))];
        colors{adj(possible(1))} = 'grey';
        disc(adj(possible(1)))=time;
        pi(adj(possible(1)))=currentNode;
    else
        stack = stack(1:length(stack)-1);
        finish(currentNode) = time;
        colors{currentNode} = 'black';
    end
end
%set return value
DFSreturn = {disc, finish, pi};
end

%initializes all colors to white, desc and finish times to 0, and
%predecessors to -1
function init = initialize(matrix)
for i=1:length(matrix) 
    colors{i}='white';
    disc(i)=0;
    finish(i)=0;
    pi(i)=-1;
end
init = {colors, disc,finish, pi};
end

%true if all colors in the cell array are 'black'
function ret = allBlack(colors)
if ismember(colors,'black');
    ret = true;
else
    ret = false;
end
end