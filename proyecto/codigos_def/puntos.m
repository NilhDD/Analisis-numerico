%abrir el archivo
filename = 'Cilindro.asc';
fid = fopen(filename, 'r');

%leer los datos
fgetl(fid);
data = fscanf(fid, '%f', [3 Inf]);
fclose(fid);
data = data';

%crear puntos
x = data(:,1);
y = data(:,2);
z = data(:,3);


%grafica
figure;
scatter3(x, y, z, 40, 'filled');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Diagrama de dispersion');
grid on;
axis equal;
hold off;