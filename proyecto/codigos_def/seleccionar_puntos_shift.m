function selected_pts = seleccionar_puntos_shift(data)
    %data:          matriz Nx3 donde la columna 1 es x, 2 es y, 3 es z

    %selected_pts:  puntos seleccionados
    N = size(data,1);
    pts = data;

    fig = figure('Name','Selector 3D');
    ax = axes('Parent',fig);
    sc = scatter3(ax, pts(:,1), pts(:,2), pts(:,3), 40, 'b', 'filled');
    hold(ax,'on');  grid(ax,'on'); axis(ax,'equal');
    title(ax,'SHIFT+Click = seleccionar   |  Click normal = rotar');

    % Permitir clics en el eje
    set(sc, 'HitTest', 'off');
    set(ax, 'PickableParts','all');
    set(ax, 'HitTest','on');

    % Instalar callback
    set(ax, 'ButtonDownFcn', @clickCallback);

    % rotate3d comienza activado
    rot = rotate3d(fig); 
    rot.Enable = 'on';

    selected_idx = [];
    selected_pts = [];    % <-- aquí guardo los puntos seleccionados

    % esperar ENTER
    waitfor(fig,'CurrentCharacter',char(13));

    % -----------------------------------
    function clickCallback(~,~)
        sel = get(fig,'SelectionType');

        % Click normal: activar rotación
        if strcmp(sel,'normal')
            rot.Enable = 'on';
            return;
        end

        % SHIFT+click → seleccionar punto
        if strcmp(sel,'extend')
            rot.Enable = 'off';

            % Obtener rayo
            cp = get(ax,'CurrentPoint');
            p0 = cp(1,:);
            p1 = cp(2,:);
            ray = (p1 - p0) / norm(p1 - p0);

            diff = pts - p0;
            rayRep = repmat(ray, N, 1);
            d = vecnorm(cross(diff,rayRep,2), 2, 2);

            [~, idx] = min(d);
            selected_idx(end+1) = idx;

            % Guardar punto seleccionado
            selected_pts = [selected_pts; pts(idx,:)];

            % Dibujar punto
            plot3(ax, pts(idx,1), pts(idx,2), pts(idx,3), ...
                  'ro','MarkerSize',10,'LineWidth',2);

            fprintf('Punto seleccionado\n');
        end
    end
end
