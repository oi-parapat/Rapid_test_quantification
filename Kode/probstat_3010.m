a1 = 1;
a2 = 2;
a3 = 4;

b0 = 1;
b1 = 2;
b2 = 3;
b3 = 4;
b4 = 5;
b5 = 6;

x = 0:0.1:30;

f0= 1/b0 * exp(-x/b0);
f1= 1/b1 * exp(-x/b1);
f2= 1/b2 * exp(-x/b2); 
f3= 1/b3 * exp(-x/b3); 
f4= 1/b4 * exp(-x/b4); 
f5= 1/b5 * exp(-x/b5); 

figure(1); plot(x, f0);
hold on; plot(x, f1);
hold on; plot(x, f2);
hold on; plot(x, f3);
hold on; plot(x, f4);
hold on; plot(x, f5);

legend("beta 1", "beta 2","beta 3","beta 4","beta 5","beta 6");
hold off;

c2 = 1/(2^(a2)*factorial(a2 - 1))*x^(a2 - 1)*exp(-x/2);
% c3 = 1/(2^(a3/2) * factorial(a3/2)) * x^((a3/2) - 1) * exp(-x/2);

figure(2); plot(x, c2);
% hold on; plot(x, c3);
% hold off;

