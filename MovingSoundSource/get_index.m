function out=get_index(az,el)
% clc;
az_temp=az;
el_temp=el;
 if az_temp>80||az_temp<-80
%     error('not proper azimuth')
  if az_temp>80
      az_temp=80;
  else
      az_temp=-80;
  end
end
if el_temp>230.625|el_temp<-45
%     error('not proper elevation')
    if el_temp>230.625
      el_temp=230.625;
    else
      el_temp=-45;
    end
end

az_var=[-80 -65 -55 -45:5:45 55 65 80];
min=90;
for i=1:25
    az_dis(i)=abs(az_var(i)-az_temp);
    if min>=az_dis(i)
        min=az_dis(i);
        az=i;
    end
end
min=235;
el_var=-45:5.625:230.625;
for i=1:50
   el_dis(i)=abs(el_var(i)-el_temp);
    if min>=el_dis(i)
        min=el_dis(i);
        el=i;
    end
end 
out=[az,el];