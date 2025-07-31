function bin = bin_ieee(n)
    %signo
    if n == 0
        bin = repmat('0', 1, 64);
        return;
    end

    sig = '';

    if n < 0
        sig = '1';
        n = -n;
    else
        sig = '0';
    end

    % Parte entera
    int = floor(n);

    % Parte decimal
    dec = n - int;
    
    % Convertir la parte entera a binario
    int_bin = '';
    while int > 0
        int_bin = [num2str(mod(int, 2)), int_bin];
        int = floor(int / 2);
    end
    
    if isempty(int_bin)
        int_bin = '0';
    end
    
    % Convertir la parte decimal a binario
    dec_bin = '';
    for i = 1:52
        dec = dec * 2;
        bit = floor(dec);
        dec_bin = [dec_bin, num2str(bit)];
        dec = dec - bit;
        if dec == 0
            break;
        end
    end
    
    bin_total = [int_bin, dec_bin];

    % Normalizar el número (mover el punto binario)
    int = floor(n);
    if int == 0
        exponent_shift = find(bin_total(2:end) == '1', 1);
        bin_total = bin_total(3 + exponent_shift:end);
        exponent = -exponent_shift;
    else
        exponent = length(int_bin) - 1;
    end

    %exponente sesgado
    exponent_biased = exponent + 1023;
    exp_bin = dec2bin(exponent_biased, 11);

    %mantisa
    mantisa_bin = bin_total(2:min(54, end));
    
    %mantisa de 52 bits
    mantisa_bin = [mantisa_bin, repmat('0', 1, 52 - length(mantisa_bin))];
    bin = sig + " " + exp_bin + " " + mantisa_bin;
end
