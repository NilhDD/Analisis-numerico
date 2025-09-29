function wts = sistemas_rk4(F, alpha, a, b, n)
    %F es un array de de funciones fi(t,[y1,y2,...,ym])
    %alpha vector de m condiciones iniciales
    %a, b extremos del intervalo
    %n numero de paso
    
    % wts: matriz de soluciones con la primera columna como los t

    h = (b-a)/n;
    m = length(alpha);
    wts = zeros(n+1, m+1);
    wts(1, 2:m+1) = alpha;
    wts(1,1) = a;

    k1 = zeros(1,m);
    k2 = zeros(1,m);
    k3 = zeros(1,m);
    k4 = zeros(1,m);

    for i=2:n+1
        ti = wts(i-1, 1);
        wts(i, 1) = ti+h;
        wi = wts(i-1, 2:m+1);

        %calculo de k1j
        for j = 1:m
            f = F{j};
            k1(j) = h.*f(ti, wi);
        end

        %calculo de k2j
        for j = 1:m
            f = F{j};
            k2(j) = h.*f(ti+h/2, wi+1/2.*k1);
        end

        %calculo de k3j
        for j = 1:m
            f = F{j};
            k3(j) = h.*f(ti+h/2, wi+1/2.*k2);
        end

        %calculo de k4j
        for j = 1:m
            f = F{j};
            k4(j) = h.*f(ti+h, wi+k3);
        end
        wts(i, 2:m+1) = wi + 1/6.*(k1 + 2.*k2 + 2.*k3 + k4);
    end
end

