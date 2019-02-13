function H=computeH(p1, p2)
    %p1 and p2 are 2xN matrices
    N = size(p1,2);
    A = zeros(2*N, 9);
    for i=1:N
        x = p1(1,i); y = p1(2,i); xp = p2(1,i); yp = p2(2,i);
        A(2*i-1,:) =   [x y 1 0 0 0 -1*x*xp -1*y*xp -1*xp];
        A(2*i,:) = [0 0 0 x y 1 -1*x*yp -1*y*yp -1*yp];
    end
    %solve the system; the solution is given in V, specifically the last vector
    [U,S,V] = svd(A);
    %reshape the vector into our matrix
    H = reshape(V(:,9), 3, 3)';
end

