a = 1;
h = 0.01;
t = 0.1;
e = 0.5;
M = round(pi/h);
T = 10;
A = zeros(M+1);

for i = 2:1:M
    A(i,i) = 1/t+2*a*e/(h*h);
    A(i,i-1) = -a*e/(h*h);
    A(i,i+1) = -a*e/(h*h);
end
A(1,1) = -1/h;
A(1,2) = 1/h;
A(M+1,M) = -1/h;
A(M+1,M+1) = 1/h;

f = zeros(M+1,1);
for i = 2:1:M
    f(i,1) = sin(-pi/2+h*(i-1))/t+(a*(1-e)*(sin(-pi/2+h*(i-2))-2*sin(-pi/2+h*(i-1))+sin(-pi/2+h*(i))))/(h*h);
end
u = zeros(M+1,T);
for i = 1:1:M+1
    u(i,1)=sin(-pi/2+h*(i-1));
end


x = A\f;
for i = 2:1:T
    u(:,i) = x;
    for j = 2:1:M
        f(j,1) = u(j,i)/t+a*(1-e)*(u(j-1,i)-2*u(j,i)+u(j+1,i))/(h*h)+3*(i-1)*(i-1)*t*t;
        
    end
    x = A\f;
end
x2=zeros(1,M+1);
y2=zeros(1,M+1);
for i = 1:1:M+1
    x2(1,i) = -pi/2+(i-1)*h;
end

for i = 1:1:M+1
    y2(1,i) = 9*9*9*t*t*t+exp(-t*9)*sin(-pi/2+(i-1)*h);
end
figure
plot(x2,u(:,9));
hold on;
plot(x2, y2,'r');
