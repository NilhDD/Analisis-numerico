function out = pp_polinomios(pp_array)
    % pp_array puede ser:
    %   - un pp-form único
    %   - un cell array {pp1, pp2, ...}

    % Asegurar formato cell
    if ~iscell(pp_array)
        pp_array = {pp_array};
    end

    out = cell(size(pp_array));

    for k = 1:length(pp_array)
        pp = pp_array{k};

        if ~isstruct(pp) || ~strcmp(pp.form, 'pp')
            error("El elemento %d no es un spline en pp-form.", k);
        end

        breaks = pp.breaks;
        coefs  = pp.coefs;   % cada fila es un polinomio: [a b c d]
        np     = pp.pieces;

        syms x real
        expr_list = cell(np,1);
        intervals = cell(np,1);

        for i = 1:np
            a = coefs(i,1);
            b = coefs(i,2);
            c = coefs(i,3);
            d = coefs(i,4);

            x0 = breaks(i);
            x1 = breaks(i+1);

            % Polinomio simbólico en el intervalo [x0, x1]
            poly_i = a*(x - x0)^3 + b*(x - x0)^2 + c*(x - x0) + d;

            expr_list{i} = simplify(poly_i);
            intervals{i} = [x0, x1];
        end

        % Función evaluable (equivalente a @(u) ppval(pp,u))
        f_handle = @(u) ppval(pp, u);

        
        n = length(expr_list);
        texto = sprintf("__\n");
        for j = 1:n
            texto = texto + sprintf("|%s, x ∈ [%.4f, %.4f]\n", ...
                expr_list{j}, intervals{j}(1), intervals{j}(2));
        end
        texto = texto + sprintf("__");

        % Guardar salida
        out{k}.intervalos = intervals;
        out{k}.polinomios = expr_list;
        out{k}.func       = f_handle;
        out{k}.pp         = pp;
        out{k}.func_texto = texto;
    end
end
