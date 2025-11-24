function selected_pts = seleccionar_puntos_shift(data)
    % data:        matriz Nx3 con puntos reales
    
    % selected_pts: matriz Mx3 de puntos elegidos

    %determinar los valores minimo y maximo de las coordenadas
    minx = min(data(:, 1));
    maxx = max(data(:, 1));
    
    miny = min(data(:, 2));
    maxy = max(data(:, 2));
    
    minz = min(data(:, 3));
    maxz = max(data(:, 3));
    
    control_pts = [
        % --- Vertices ---
        minx, miny, minz;
        maxx, miny, minz;
        minx, maxy, minz;
        minx, miny, maxz;
        maxx, maxy, minz;
        maxx, miny, maxz;
        minx, maxy, maxz;
        maxx, maxy, maxz;
    
        % --- Midpoints de aristas ---
        (minx+maxx)/2,  miny,           minz;
        minx,           (miny+maxy)/2,  minz;
        minx,           miny,           (minz+maxz)/2;
        (minx+maxx)/2,  maxy,           minz;
        maxx,           (miny+maxy)/2,  minz;
        maxx,           miny,           (minz+maxz)/2;
        minx,           maxy,           (minz+maxz)/2;
        (minx+maxx)/2,  miny,           maxz;
        minx,           (miny+maxy)/2,  maxz;
        maxx,           maxy,           (minz+maxz)/2;
        (minx+maxx)/2,  maxy,           maxz;
        maxx,           (miny+maxy)/2,  maxz
    ];

    DATA_N = size(data,1);
    CTRL_N = size(control_pts,1);

    % Puntos combinados para permitir seleccion
    pts = [data ; control_pts];
    N = size(pts,1);

    %marcador de cuales son data y cuáles control
    is_data = [true(DATA_N,1) ; false(CTRL_N,1)];

    % ----------------------------------------
    % Crear figura
    % ----------------------------------------
    fig = figure('Name','Selector 3D');
    ax = axes('Parent',fig); hold on; grid on; axis equal

    % Graficar data (azul) y control (verde)
    scatter3(ax, data(:,1), data(:,2), data(:,3), 40, 'b', 'filled');
    scatter3(ax, control_pts(:,1), control_pts(:,2), control_pts(:,3), ...
             80, 'g', 'filled', 'MarkerEdgeColor','k');

    title(ax, 'SHIFT=seleccionar  |  CTRL=region  |  ENTER=terminar');

    % Para permitir click en el espacio
    set(ax,'PickableParts','all','HitTest','on')
    set(fig,'WindowButtonDownFcn', @clickCallback);

    rot = rotate3d(fig);
    rot.Enable = 'on';

    selected_idx = [];
    selected_pts = [];
    temp_clicks = [];

    % Esperar ENTER
    waitfor(fig,'CurrentCharacter',char(13));

    % Filtrar para que NO entren puntos de control
    selected_pts = selected_pts(is_data(selected_idx), :);

    close(fig)

    % ==========================================
    % CALLBACK DE CLIC
    % ==========================================
    function clickCallback(~,~)
        sel = get(fig,'SelectionType');

        % -----------------------------
        % Click normal → rotar
        % -----------------------------
        if strcmp(sel,'normal')
            rot.Enable = 'on';
            return;
        end

        % ==========================================
        % SHIFT → seleccionar punto cercano al rayo
        % ==========================================
        if strcmp(sel,'extend')
            rot.Enable = 'off';

            cp = get(ax,'CurrentPoint');
            p0 = cp(1,:);
            p1 = cp(2,:);
            ray = (p1 - p0) / norm(p1 - p0);

            diff = pts - p0;
            d = vecnorm(cross(diff, ray .* ones(N,1), 2), 2, 2);

            [~, idx] = min(d);
            click_pt = pts(idx,:);

            % Dibujar marcado (si es control -> amarillo)
            if is_data(idx)
                plot3(ax, click_pt(1), click_pt(2), click_pt(3), ...
                    'ro', 'MarkerSize', 10, 'LineWidth', 2);
            else
                plot3(ax, click_pt(1), click_pt(2), click_pt(3), ...
                    'yo', 'MarkerSize', 12, 'LineWidth', 2);
            end

            % Entra al conjunto solo si es DATA
            if is_data(idx)
                selected_idx(end+1) = idx;
                selected_pts = [selected_pts ; click_pt];
                fprintf('Punto seleccionado (SHIFT)\n');
            else
                fprintf('Punto de control seleccionado (SHIFT) – NO se agrega a selected_pts.\n');
            end
            return;
        end

        % ==========================================
        % CTRL → selección por paralelepípedo
        % ==========================================
        if strcmp(sel,'alt')
            rot.Enable = 'off';

            fprintf('Ctrl+Click detectado\n');

            % Obtener punto más cercano
            cp = get(ax,'CurrentPoint');
            p0 = cp(1,:);
            p1 = cp(2,:);
            ray = (p1 - p0) / norm(p1 - p0);

            diff = pts - p0;
            d = vecnorm(cross(diff, ray .* ones(N,1), 2), 2, 2);
            [~, idx] = min(d);
            click_pt = pts(idx,:);

            % Dibujar clic
            plot3(ax, click_pt(1), click_pt(2), click_pt(3), ...
                  'ko','MarkerSize',11,'LineWidth',2);

            % Verificar duplicado
            if ~isempty(temp_clicks)
                if isequal(click_pt, temp_clicks(end,:))
                    fprintf('Se ignoró un punto duplicado.\n');
                    return;
                end
            end

            temp_clicks = [temp_clicks ; click_pt];

            % Si ya se tienen 2 → seleccionar región
            if size(temp_clicks,1) == 2
                p1 = temp_clicks(1,:);
                p2 = temp_clicks(2,:);

                minp = min([p1; p2],[],1);
                maxp = max([p1; p2],[],1);

                mask = (pts(:,1) >= minp(1) & pts(:,1) <= maxp(1)) & ...
                       (pts(:,2) >= minp(2) & pts(:,2) <= maxp(2)) & ...
                       (pts(:,3) >= minp(3) & pts(:,3) <= maxp(3));

                inside_idx = find(mask);

                % Dibujar todos (pero NO meter a selected_pts los de control)
                for k = inside_idx'
                    if is_data(k)
                        plot3(ax, pts(k,1), pts(k,2), pts(k,3), ...
                              'mo','MarkerSize',8,'LineWidth',1.5);
                    else
                        plot3(ax, pts(k,1), pts(k,2), pts(k,3), ...
                              'co','MarkerSize',10,'LineWidth',2);
                    end
                end

                % Agregar solo los que son de data
                valid = inside_idx(is_data(inside_idx));
                selected_idx = [selected_idx ; valid];
                selected_pts = [selected_pts ; pts(valid,:)];

                fprintf('Seleccionados %d puntos válidos (solo DATA)\n', length(valid));

                temp_clicks = [];
            end

            rot.Enable = 'on';
            return;
        end
    end
end
