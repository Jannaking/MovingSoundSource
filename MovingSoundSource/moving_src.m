% -80 azimuth  to 80 azimuth. fixed elevation.
function moving_src
fs=44100;
[x,fs]=wavread('audiomono2_test.wav');
x=x';
load('G:\Internship\10_June\CIPIC_database\subject_003\hrir_final');
n1 = length(x);
n2 = 200;
M=n2;
N = n1+n2-1;
%h1 = [h zeros(1,M-1)]
%n3 = length(h1);
n3=n2+M-1;
y = zeros(1,N+n3-M);
%H = fft(h1);
count=n1/25;
for i = 1:M:n1
if i<=(n1+M-1)
x1 = [x(i:i+n3-M) zeros(1,n3-M)];
else
x1 = [x(i:n1) zeros(1,n3-M)];
end
x2 = fft(x1);
j=floor(i/count)+1;
r=hrir_r(j,9,:);
r=reshape(r,[1,200]);

H=fft(r);
x3 = x2.*H;
x4 = round(ifft(x3));
if (i==1)
    y(1:n3) = x4(1:n3);
else
y(i:i+n3-1) = y(i:i+n3-1)+x4(1:n3);
end
end

end