clear;clc;

%% abrir el archivo
filename = '\proyecto\datos\Cilindro.asc';
fid = fopen(filename, 'r');

%leer los datos
fgetl(fid);
data = fscanf(fid, '%f', [3 Inf]);
fclose(fid);
data = data';


%% seleccionar puntos
puntos_trabajar = seleccionar_puntos_shift(data);

disp(puntos_trabajar);
x = puntos_trabajar(:,1);
y = puntos_trabajar(:,2);
z = puntos_trabajar(:,3);

%% pedir que se desea hacer
tipo = upper(input('Curva (C), Superficie (S), Envolvente(E): ', 's'));


%% casos
if tipo == 'C'
    % preguntar cerradura
    cerrada         = upper(input('Cerrado (S/N): ', 's'));
    cerrada_bool    = (cerrada == 'S');

    % interpolacion para curva
    [pps, curva]    = interpolacion_curvas(x, y, z, cerrada_bool);

    x_fun = curva{1};
    y_fun = curva{2};
    z_fun = curva{3};
    
    
    %polinomios explicitos
    out = pp_polinomios(pps);

    %impresion de polinomios    
    for i = 1:3
        fprintf("funcion x%d\n", i);
        disp(out{i}.func_texto);
    end
    
    
    %calculo de longitud
    longitud = calculo_longitud(x_fun, y_fun, z_fun);
    fprintf('La longitud de la curva es: %.4f\n', longitud);
        
    %evaluar
    uu = linspace(0,1,100);
    X = x_fun(uu);
    Y = y_fun(uu);
    Z = z_fun(uu);
    
    %visualizar
    figure;
    hold on;
    plot3(x, y, z,'ro','LineWidth',1.5);
    plot3(X ,Y , Z,'b','LineWidth',2);
    
    grid on; axis equal;
    title("Interpolacion por curva de puntos")
    xlabel('X'), ylabel('Y'), zlabel('Z');
    hold off;



elseif tipo == 'S'
    %interpolacion para superficie
    [pps, superficie] = superficie_interpoladora(x, y, z);

    %evaluar en una malla
    [Uq, Vq] = meshgrid(linspace(0, 1, 50), linspace(0, 1, 50));
    Xq = Xfun(Uq, Vq);
    Yq = Yfun(Uq, Vq);
    Zq = Zfun(Uq, Vq);
    
    %visualizar
    figure;
    surf(Xq, Yq, Zq, 'FaceAlpha', 0.8);
    hold on;
    plot3(puntos_trabajar(:,1), puntos_trabajar(:,2), puntos_trabajar(:,3), ...
          'ro', 'MarkerSize', 8, 'LineWidth', 2);
    shading interp;
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Superficie Interpolada con Puntos Originales');
    colorbar;
    
    %calcular area de superficie
    area = calculo_area_superficie_fast(Xfun, Yfun, Zfun);
    fprintf('Área de la superficie calculada: %.4f unidades cuadradas\n', area);

elseif tipo == 'E'
    [K, A, V] = envolvente_convexa(puntos_trabajar);

    fprintf("Área superficial: %.6f\n", A);
    fprintf("Volumen: %.6f\n", V);
    
    %graficar envolvente convexa
    figure;
    trisurf(K, puntos_trabajar(:,1), puntos_trabajar(:,2), puntos_trabajar(:,3), ...
            'FaceColor','cyan', 'FaceAlpha',0.25, 'EdgeColor','k');
    
    axis equal; grid on;
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Envolvente convexa');
    
    hold on;
    plot3(puntos_trabajar(:,1), puntos_trabajar(:,2), puntos_trabajar(:,3), 'r.', 'MarkerSize', 1);
end

disp("FIN!!");


