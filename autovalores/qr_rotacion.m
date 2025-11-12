function [Q, R, A] = qr_rotacion(A, TOL, N_max)
    %A:     matriz tridiagonal
    %TOL:   tolerancia del metodo
    %N_max: numero de iteraciones max

    %Q: matriz Q
    %R: matriz R
    %A: matriz diagonal 'simetrica' semejante a A

    n       = size(A,1);
    count   = 0;

    As      = cell(n,1);

    while count < N_max
        Q       = eye(n);
        R       = eye(n);
        As{1}   = A;

        for i = 1:n-1
            count   = count + 1;
            P       = eye(n);

            div = (As{i}(i,i)^2 + As{i}(i+1,i)^2)^(1/2);
            c   = As{i}(i,i)/div;
            s   = As{i}(i+1,i)/div;
    
            P(i:i+1,i:i+1) = [c,s;-s,c];

            R       = P*As{i};
            As{i+1} = R;
            Q       = Q*P';
        end
        A = R*Q;
        if norm(diag(A, -1),inf) < TOL
            return
        end
        disp(A);
    end
end