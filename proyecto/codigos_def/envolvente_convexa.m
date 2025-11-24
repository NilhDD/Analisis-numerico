function [K, area_total, volumen_total] = envolvente_convexa(pts)
    % ENVOLVENTE_CONVEXA_CONVEXHULL
    % Calcula el casco convexo de una nube 3D y devuelve:
    %   K -> caras triangulares del casco convexo
    %   area_total -> área superficial
    %   volumen_total -> volumen encerrado

    % Validación
    if size(pts,2) ~= 3
        error('La nube de puntos debe ser Nx3');
    end

    % --- Calcular el casco convexo ---
    [K, volumen_total] = convhulln(pts);

    % --- Calcular el área superficial ---
    area_total = 0;
    for i = 1:size(K,1)
        v1 = pts(K(i,2),:) - pts(K(i,1),:);
        v2 = pts(K(i,3),:) - pts(K(i,1),:);
        tri_area = 0.5 * norm(cross(v1, v2));
        area_total = area_total + tri_area;
    end
end
