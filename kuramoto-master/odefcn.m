function dydt = odefcn(t, y, C, alpha, A)
N = size(A,1);
w0 = 2 * pi * 60;
w = normrnd(w0,1,1,N);
dydt = zeros(N, 1);
for i = 1 : N
    g = 0;
    for j = 1 : N
        g = g + A(i,j) * sin(y(j) - y(i) - alpha);
    end   
    dydt(i) = w(i) + C * g;
     
end
%dydt=[dydt dydt1(i)];
end