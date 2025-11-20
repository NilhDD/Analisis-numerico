function [pps, curva] = interpolacion_curvas(x, y, z, cerrada)
    %x:         vector columna de valors x de los puntos a interpolar
    %y:         vector columna de valors y de los puntos a interpolar
    %z:         vector columna de valors z de los puntos a interpolar
    %cerrada:   valor booleano si la curva es cerrada o no

    %curva:     array de 3 funciones que definen una curva en 3d
    %alpha(t) = (X(t), Y(t), Z(t))
    
    %matriz de puntos
    P = [x, y, z]';

    %verificacion de cerradura
    if (cerrada) && any(P(:,1) ~= P(:,end))
        P = [P, P(:,1)];
    end
    
    %crear intervalo inicial normalizado en [0,1]
    t = linspace(0,1,size(P,2));
    
    %Spline cubico, periodic con S'(x0)=S'(xn)
    ppx = csape(t, P(1,:), 'periodic');
    ppy = csape(t, P(2,:), 'periodic');
    ppz = csape(t, P(3,:), 'periodic');

    pps = {ppx, ppy, ppz};
    
    %funciones manejables
    x_fun = @(u) ppval(ppx, u);
    y_fun = @(u) ppval(ppy, u);
    z_fun = @(u) ppval(ppz, u);

    curva = {x_fun, y_fun, z_fun}';
end