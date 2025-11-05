function simp = simplificar_funcs(funcs)
    %funcs: cell array de funciones anonimas @(x)
    %simp:  cell array de expresiones simbólicas simplificadas

    syms x
    N = numel(funcs);
    simp = cell(N, 1);

    for k = 1:N
        try
            % Evaluar la función sobre una variable simbólica
            f_sym = funcs{k}(x);

            % Simplificar y expandir
            simp{k} = simplify(expand(f_sym));
        catch ME
            warning('No se pudo convertir la función %d: %s', k, ME.message);
            simp{k} = sym('NaN');
        end
    end
end
