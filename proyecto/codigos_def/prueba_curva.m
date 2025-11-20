clear;clc;
%puntos iniciales
x = [1,2,4,3,2,1]';
y = [4,0.5,1,2,3,4]';
z = [3,2,0.3,0.5,0,0]';

%interpolacion de curvas
[pps, curva] = interpolacion_curvas(x, y, z, true);

x_fun = curva{1};
y_fun = curva{2};
z_fun = curva{3};


%polinomios explicitos
out = pp_polinomios(pps);

for i = 1:3
    fprintf("funcion x%d\n", i);
    disp(out{i}.func_texto);
end



%calculo de longitud
longitud = calculo_longitud(x_fun, y_fun, z_fun);
fprintf('La longitud de la curva es: %.4f\n', longitud);



%visualizar
uu = linspace(0,1,100);
X = x_fun(uu);
Y = y_fun(uu);
Z = z_fun(uu);


figure;
hold on;
plot3(x, y, z,'ro','LineWidth',1.5);
plot3(X ,Y , Z,'b','LineWidth',2);

grid on; axis equal;
title("Interpolacion por curva de puntos")
xlabel('X'), ylabel('Y'), zlabel('Z');
hold off;