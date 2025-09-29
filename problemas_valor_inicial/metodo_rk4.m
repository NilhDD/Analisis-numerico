function [ts,yts] = metodo_rk4(f, alpha, a, b, n)
    %se usa para las ecuaciones diferenciales de la forma
    % y'=f(t,y), y(a)=alpha
    %se debe de cumplir que f cumpla la condicion de Lipschitz

    %f es una funcion de dos parametros t, y
    %alpha es el valor inicial de a
    %a, b son los extremos del intervalo
    %n es el numero de partes en las que se divide el intervalo

    h = (b-a)/n;
    ts = zeros(1,n+1);
    yts = zeros(1, n+1);

    ts(1) = a;
    yts(1) = alpha;

    for i = 2:n+1
        ti = a + (i-2)*h;
        wi = yts(i-1);
        ts(i) = ti+h;

        k1 = h*f(ti,wi);
        k2 = h*f(ti+h/2, wi+1/2*k1);
        k3 = h*f(ti+h/2, wi+1/2*k2);
        k4 = h*f(ti+h, wi+k3);

        yts(i) = wi + 1/6 * (k1+2*k2+2*k3+k4);
    end
end