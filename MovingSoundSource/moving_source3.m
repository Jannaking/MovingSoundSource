%% moving source with input az and elevation as an array;
%moving in horizontal direction.
function final= moving_source3(x,az,el)
AZ=[-80 -65 -55 -45:45 55 65 80];
EL=-45:5.625:45;
fs=44100;
% [x,fs]=wavread('audiomono2_test.wav');
x=x';
 n1=length(x);
%load('hrir_final');
load('hrir_final')
n2=200;%length of Impulse response
n=n1+n2-1;
y_r = zeros(1,n);
y_l=y_r;
M=n2;% Block size
N=M+n2-1;

count1=n1/length(az);
count2=n1/length(el);
for i=1:M:n1
    
    flag=0;k=0;
    if i<n1-M
        x1=[x(i:i+M-1) zeros(1,n2-1)];
    else 
        x1=[x(i:end) zeros(1,n2-1)];
        k=length(x(i:end));
        flag=1;
    end
    if flag==0
%         if dir==1
%         j=floor(i/count)+1;
%         else
%             j=25-floor(i/count);
%         end
a=floor(i/count1)+1;
e=floor(i/count2)+1;
dir=findnearestneighbour([az(a) el(e)]);
pos=get_index(dir(1),dir(2));
        r=hrir_r(pos(1),pos(2),:);
        h_r=reshape(r,[1,200]);
        h_r=[h_r(1:200) zeros(1,M-1)];
        H_r=fft(h_r);
        
        l=hrir_l(pos(1),pos(2),:);
        h_l=reshape(l,[1,200]);
        h_l=[h_l(1:200) zeros(1,M-1)];
        H_l=fft(h_l);
    else
        h_r=[h_r(1:200) zeros(1,k-1)];
        H_r=fft(h_r);
        
         h_l=[h_l(1:200) zeros(1,k-1)];
         H_l=fft(h_l);
    end
        x2=fft(x1);
        x3_r = x2.*H_r;
        x4_r = (ifft(x3_r));
        
        x3_l = x2.*H_l;
        x4_l = (ifft(x3_l));
        if i==1
            y_r(1:N)=x4_r(i:N);
             y_l(1:N)=x4_l(i:N);
        elseif flag==0
            y_r(i:i+N-1) = y_r(i:i+N-1)+x4_r(1:N);
             y_l(i:i+N-1) = y_l(i:i+N-1)+x4_l(1:N);
        else
            y_r(i:end)=y_r(i:end)+x4_r(1:end);
            y_l(i:end)=y_l(i:end)+x4_l(1:end);
        end      
end
final(:,1)=y_l';
final(:,2)=y_r';
%  soundsc(final,fs)
end
