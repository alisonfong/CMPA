Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,200);
I1 = zeros(1,200);
Noise = 0.2*rand(1,200);
I2 = zeros(1,200);

for i = 1:200
   I1(i) = Is*(exp(48*V(i))-1) + Gp*V(i) + Ib*(exp(-48*(V(i)+Vb)));
   I2(i) = Noise(i)*I1(i);

end

figure (1)
plot(V,I1);
grid on;

P1 = polyfit(V,I1,4);
figure (5)
plot(V,polyval(P1,V));
grid on;

P2 = polyfit(V,I1,8);

figure(6)
plot(V,polyval(P2,V));
grid on;

figure(2)
semilogy(I1,V);
grid on;

figure (3)
plot(V,I2);
grid on;

figure(4)
semilogy(I2,V);
grid on;


% fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
% 
% ff = fit(V,I1,fo);
% If = ff(V');

inputs = V.';
targets = I1.';
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







