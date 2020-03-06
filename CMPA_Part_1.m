Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,200);
I1 = zeros(1,200);
Noise = 1+(0.2*randn(1,200));
I2 = zeros(1,200);

for i = 1:200
   I1(i) = Is*(exp(48*V(i))-1) + Gp*V(i) - Ib*(exp(-48*(V(i)+Vb))-1);
   I2(i) = Noise(i)*I1(i);
end

figure (1)
plot(V,I1);
hold on;
plot(V,I2);
grid on;
hold off;

P1 = polyfit(V,I1,4);
P2 = polyfit(V,I1,8);
figure (2)
plot(V,polyval(P1,V));
hold on;
plot(V,polyval(P2,V));
hold on;
plot(V,I1);
hold off;
grid off;

figure (3)
semilogy(V,abs(polyval(P1,V)));
hold on;
semilogy(V,abs(polyval(P2,V)));
hold on;
semilogy(V,abs(I1));
hold off;
grid on;


figure(4)
semilogy(V,abs(I2));
hold on;
semilogy(V,abs(I1));
grid on;
hold off;








fo1 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
fo2 = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
fo3 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');

ff1 = fit(V',I1',fo1);
If1 = ff1(V');
ff2 = fit(V',I1',fo2);
If2 = ff1(V');
ff3 = fit(V',I1',fo3);
If3 = ff1(V');

figure(7)
semilogy(V',abs(If1),'g');
hold on;
semilogy(V',abs(If2),'c');
hold on;
semilogy(V',abs(If3),'m');
hold off;
grid on;

inputs = V;
targets = I2;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net)
Inn = outputs;

figure(5)
plot(V,Inn);
hold on;
plot(V,I2);
grid on;
hold off;

figure (6)
semilogy(V,abs(I2));
hold on;
semilogy(V,abs(Inn));
hold off;
grid on;




