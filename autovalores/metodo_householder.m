function A = metodo_householder(A)
    %A:     matriz simetrica

    %td:    matriz tridiagonal
    n = size(A, 1);

    for k = 1:n-2
        alpha       = -sign(A(k+1,k)) * norm(A(k+1:end,k), 2);
        r           = ((alpha^2 - A(k+1,k)*alpha)/2)^(1/2);

        w           = zeros(n,1);
        w(k+1)      = (A(k+1,k) - alpha)/(2*r);
        w(k+2:end)  = A(k+2:end,k)/(2*r);


        P = eye(n) - 2*(w*w');
        A = P*A*P;
    end
end