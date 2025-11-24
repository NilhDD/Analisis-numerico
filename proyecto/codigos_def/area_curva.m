function val = area_curva(fun_x, fun_y, fun_z)
    %fun_x: funcion en la coordenada x, dominio [0,1]
    %fun_y: funcion en la coordenada y, dominio [0,1]
    %fun_z: funcion en la coordenada z, dominio [0,1]
    %la curva debe ser cerrada

    %val:   area de la curva
    % val = int_{0}^{1}{||alpha'(t)||dt}

    TOL = 1e-8;

    %definir el operador derivada
    derivada = @(f,t) metodo_ridderes(f,t,1e-5,2,5);

    %calcular las derivadas de cada funcion
    dfx = @(t) derivada(fun_x, t);
    dfy = @(t) derivada(fun_y, t);
    dfz = @(t) derivada(fun_z, t);

    %calcular las segundas derivadas de cada funcion
    ddfx = @(t) derivada(dfx, t);
    ddfy = @(t) derivada(dfy, t);
    ddfz = @(t) derivada(dfz, t);

    %calcular las tercera derivadas de cada funcion
    d3fx = @(t) derivada(ddfx, t);
    d3fy = @(t) derivada(ddfy, t);
    d3fz = @(t) derivada(ddfz, t);

    figure;
    ts = 0:1e-5:1;
    % Evaluar la curva y graficar
    plot(ts, fun_x(ts));
    hold on;
    df = zeros(length(ts),1);
    ddf = zeros(length(ts),1);
    for i = 1:length(ts)
        df(i) = dfx(ts(i));
        ddf(i) = ddfx(ts(i));
    end
    plot(ts, df);
    plot(ts, ddf);
    xlabel('X-axis');
    ylabel('Y-axis');
    title('Curva en 3D');
    grid on;

    %calcular curvatura
    tor = @(t) ...
    det([ dfx(t),   dfy(t),   dfz(t) ; ...
          ddfx(t), ddfy(t), ddfz(t) ; ...
          d3fx(t), d3fy(t), d3fz(t) ]) ...
    / ...
    ( norm( cross([dfx(t), dfy(t), dfz(t)], ...
                  [ddfx(t), ddfy(t), ddfz(t)] ), 2 )^2 );



    for i = 0:1e-3:1
        ti = tor(i);
        disp(ti);
        if TOL < abs(ti)
            val = NaN;
            return
        end
    end

    Afx = @(t) fun_y(t) .* dfz(t) - dfy(t) .* fun_z(t);
    Afy = @(t) dfx(t) .* fun_z(t) - fun_x(t) .* dfz(t);
    Afz = @(t) fun_x(t) .* dfy(t) - dfx(t) .* fun_y(t);

    Ax = metodo_simpson(Afx, 0, 1, 1e5);
    Ay = metodo_simpson(Afy, 0, 1, 1e5);
    Az = metodo_simpson(Afz, 0, 1, 1e5);

    val = sqrt(Ax^2 + Ay^2 + Az^2);
end