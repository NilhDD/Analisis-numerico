function [K, area_total, volumen_total] = envolvente_convexa(pts)
    %pts:           puntos a trabajar

    %K:             caras triangulares del casco convexo
    %area_total:    area superficial
    %volumen_total: volumen encerrado

    %alcular de la envolvente convexa
    [K, volumen_total] = convhulln(pts);

    %calcular el area superficial (suma de las triangulaciones)
    area_total = 0;
    for i = 1:size(K,1)
        v1 = pts(K(i,2),:) - pts(K(i,1),:);
        v2 = pts(K(i,3),:) - pts(K(i,1),:);
        tri_area = 0.5 * norm(cross(v1, v2));
        area_total = area_total + tri_area;
    end
end
