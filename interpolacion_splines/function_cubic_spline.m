function splineFunc = function_cubic_spline(x, y)
    %coeficientes del spline cubico
    [a, b, c, d] = cubic_spline(x, y);
    
    %devolder una funcion handle que evalúa el spline en un punto x
    splineFunc = @(xx) evalCubicSpline(xx, x, a, b, c, d);
end

function val = evalCubicSpline(xx, xs, as, bs, cs, ds)
    %inicializar el valor de salida
    val = zeros(size(xx));
    
    %para el punto xx, determina el subintervalo del punto y evalua el spline
    for i = 1:length(xx)
        %determinar el intervalo j
        j = find(xs(1:end-1) <= xx(i) & xs(2:end) >= xx(i), 1, 'last');
        if isempty(j)  % Si xx(i) esta fuera del rango de xs
            if xx(i) < xs(1)
                j = 1;
            elseif xx(i) > xs(end)
                j = length(xs) - 1;
            end
        end
        
        %verificar que j este dentro de los límites
        j = min(j, length(as));
        
        %diferencia x - x_j
        dx = xx(i) - xs(j);
        
        %evalua el polinomio
        val(i) = as(j) + bs(j)*dx + cs(j)*dx.^2 + ds(j)*dx.^3;
    end
end

