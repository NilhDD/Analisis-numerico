function [a, b, c, d] = cubic_spline(x, a)
    n = length(x) - 1; %numero de intervalos
    h = diff(x); % calculo de h_i = x_{i+1} - x_i
    
    %calcular los valores de alpha
    alpha = zeros(n-1, 1);
    for i = 2:n
        alpha(i-1) = (3/h(i))*(a(i+1) - a(i)) - (3/h(i-1))*(a(i) - a(i-1));
    end
    
    %resolver el sistema tridiagonal para encontrar c
    l = zeros(n+1, 1);
    mu = zeros(n+1, 1);
    z = zeros(n+1, 1);
    
    l(1) = 1;
    for i = 2:n
        l(i) = 2*(x(i+1) - x(i-1)) - h(i-1)*mu(i-1);
        mu(i) = h(i)/l(i);
        z(i) = (alpha(i-1) - h(i-1)*z(i-1))/l(i);
    end
    
    c = zeros(n+1, 1);
    b = zeros(n, 1);
    d = zeros(n, 1);
    
    %calcular b, c, d hacia atrás
    for j = n:-1:1
        c(j) = z(j) - mu(j)*c(j+1);
        b(j) = (a(j+1) - a(j))/h(j) - h(j)*(c(j+1) + 2*c(j))/3;
        d(j) = (c(j+1) - c(j))/(3*h(j));
    end
    
    a = a(1:n); %ajusta el tamaño de a para que coincida con b, c, d
end