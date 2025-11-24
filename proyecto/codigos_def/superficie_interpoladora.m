function [Xfun, Yfun, Zfun, u, v] = superficie_interpoladora(P)
% P: nube de puntos Nx3
% Devuelve funciones @(u,v) X, Y, Z con dominio [0,1]x[0,1]
% y las coordenadas parametrizadas u,v para inspección.

    %-----------------------------------------
    % 1. Preparación
    %-----------------------------------------
    X = P(:,1);
    Y = P(:,2);
    Z = P(:,3);

    %-----------------------------------------
    % 2. PCA → para orientar y detectar cerradura
    %-----------------------------------------
    [coeff,score,~] = pca(P);
    P2 = score(:,1:2);     % proyección plana

    ang = atan2(P2(:,2), P2(:,1));     % [-pi,pi]
    [angs, idxAng] = sort(ang);
    dtheta = diff(angs);

    closedU = any(abs(dtheta) > pi);   % criterio simple y útil

    %-----------------------------------------
    % 3. Parametrización
    %-----------------------------------------
    if closedU
        %---- Parametrización angular + altura ----%
        theta = mod(ang, 2*pi);           % [0,2pi]

        % Corregir salto para que tenga continuidad
        [thS, idxS] = sort(theta);
        dd = diff(thS);
        jump = find(abs(dd) > pi, 1);

        if ~isempty(jump)
            theta = circshift(theta, -jump);
            theta = theta - min(theta);
        end

        u = rescale(theta);               % [0,1]
        v = rescale(score(:,3));          % [0,1]

    else
        %---- Superficie abierta → PCA plano ----%
        u = rescale(P2(:,1));             % [0,1]
        v = rescale(P2(:,2));             % [0,1]
    end

    %-----------------------------------------
    % 4. Evitar duplicados antes de interpolar
    %-----------------------------------------
    % Cuantizar (u,v) para eliminar ruido numérico
    uq = round(u*1e6)/1e6;
    vq = round(v*1e6)/1e6;
    
    UV = [uq, vq];

    [UV_unique, ~, ic] = unique(UV, 'rows');

    Xu = accumarray(ic, X, [], @mean);   % promedio si se repiten
    Yu = accumarray(ic, Y, [], @mean);
    Zu = accumarray(ic, Z, [], @mean);

    u2 = UV_unique(:,1);
    v2 = UV_unique(:,2);

    %-----------------------------------------
    % 5. Interpoladores X(u,v), Y(u,v), Z(u,v)
    %-----------------------------------------
    Fx = fit([u2, v2], Xu, "linearinterp",  ...
        ExtrapolationMethod="nearest");

    Fy = fit([u2, v2], Yu, "linearinterp",  ...
        ExtrapolationMethod="nearest");

    Fz = fit([u2, v2], Zu, "linearinterp",  ...
        ExtrapolationMethod="nearest");

    %-----------------------------------------
    % 6. Funciones finales @(u,v)
    %-----------------------------------------
    Xfun = @(U,V) Fx(U,V);
    Yfun = @(U,V) Fy(U,V);
    Zfun = @(U,V) Fz(U,V);

end
