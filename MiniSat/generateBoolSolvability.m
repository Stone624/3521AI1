%Tyler Stone
%CSE 3521 Programming Assignment 3
%Professor Robert Finn
%7/21/15
%This script will write a MiniSAT formatted input file into
%'kcolorsboolsolvability.txt'. It is assumed that A is an NxN adjacency
%matrix which already exists. This script will create the boolean
%expression for graph A for k colors. Changing k (0<k<N) will create
%different boolean expressions, and running the generated input file in
%MiniSAT (minisat kcolorsboolsolvability.txt output.txt) will output
%whether the expression is satisfiable or unsatisfiable. If the boolean
%expresson is satisfiable, then graph A can be colored with k colors.
fileID = fopen('kcolorsboolsolvability.txt','w');
k = 15;
v = length(A);
fprintf(fileID,'p cnf %i %i\n',k*v,length(find(A))*k+v);
for i=1:v
    for j=1:k
        fprintf(fileID,'%i ',(i-1)*k+j);
    end    
    fprintf(fileID,'0\n');
end
for i=1:v
    for j=1:v
        if A(i,j)
            for z=1:k            
                fprintf(fileID,'-%i -%i 0\n',k*(i-1)+z,k*(j-1)+z);
            end
        end
    end
end
fclose(fileID);