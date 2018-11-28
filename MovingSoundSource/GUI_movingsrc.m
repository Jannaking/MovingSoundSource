function GUI_movingsrc
global az1 az2  el1 el2 sig1 final p fs ax2 
f= figure('units','pixels',...
    'position',[5 50 1355 640],...
              'menubar','none',...
              'name','Source_Localization',...
              'numbertitle','off');
               
          set(gcf,'Color',[1,0.6,0.5])

   pb1 = uicontrol(f,'Style','pushbutton','String','Start_Az',... 
'Position',[170 590 90  50],'BackgroundColor','red',...
'Callback',@(hObject,eventdata)azimuth1(f)); 
  pb2 = uicontrol(f,'Style','pushbutton','String','End_Az',... 
'Position',[260 590 90  50],'BackgroundColor','green',...
'Callback',@(hObject,eventdata)azimuth2(f));

pb3 = uicontrol(f,'Style','pushbutton','String','Start_El.',... 
'Position',[650 590 90  50],'BackgroundColor','red',...
'Callback',@(hObject,eventdata)elevation1(f)); 

pb4 = uicontrol(f,'Style','pushbutton','String','End_El.',... 
'Position',[740 590 90  50],'BackgroundColor','green',...
'Callback',@(hObject,eventdata)elevation2(f)); 

pb3 = uicontrol(f,'Style','pushbutton','String','Song',... 
'Position',[1000 590 90  50],'BackgroundColor','blue',...
'Callback',@(hObject,eventdata)song(f)); 

pb4 = uicontrol(f,'Style','pushbutton','String','PLAY',... 
'Position',[1100 590 90  50],'BackgroundColor','yellow',...
'Callback',@(hObject,eventdata)play(f)); 

    
end

function play(f,hObject,eventdata)
global sig fs az1 el1 az2 el2 p
% hrir=get_ir_cipic(radtodeg(az),radtodeg(el));
% final=auralize(hrir,sig);
% % p=audioplayer(final,fs)
% soundsc(final,fs)
if az1<az2
 az=radtodeg(az1):5:radtodeg(az2);
else
    az=radtodeg(az1):-5:radtodeg(az2);
end

if el1<el2
 el=radtodeg(el1):5:radtodeg(el2);
else
    el=radtodeg(el1):-5:radtodeg(el2);
end

y=moving_source3(sig,az,el);
soundsc(y,fs)
end

function song(f,hObject,eventdata)
global sig fs 
[FileName,FilePath ]= uigetfile('.wav');
ExPath = fullfile(FilePath, FileName);
[sig,fs]=wavread(ExPath);
end


function azimuth1(f,hObject,eventdata)
im=imread('top_view.jpg');
ax=axes('Parent',f,'Position',[.025 .05 .30 .30],...
        'visible','off');
    imshow(im)
global az1 ax2
  az1=pi/2+pi/4;
    ax2=axes('Parent',f,'Position',[.025 .45 .30 .30],...
        'visible','off');
    theta=0:.01:2*pi;
    hplot1=plot(ax2,cos(theta),sin(theta));
      axis([-2 2 -2 2])
    grid on
    title('Horizontal plane')
                 xlabel('x-axis')
                 ylabel('y-axis')
                 
    hold on
    hplot2=plot(ax2,cos(az1-pi/2),sin(az1-pi/2),'r*'); 
    
 s1= uicontrol(f,'Style','slider',...
        'Min',-80,'Max',80,'Value',0,...
        'SliderStep',[5/360 1/36],'units','pixel',...
        'Position',[50 550 300 15],...
        'Callback',@(hObject,eventdata)s1_call(hplot2,hObject,eventdata));
end
function azimuth2(f,hObject,eventdata)
global az2 ax2
az2=pi/2+ pi/4.5;
  hplot5=plot(ax2,cos(az2-pi/2),sin(az2-pi/2),'g*'); 
  
   s3= uicontrol(f,'Style','slider',...
        'Min',-80,'Max',80,'Value',0,...
        'SliderStep',[5/360 1/36],'units','pixel',...
        'Position',[50 550 300 15],...
        'Callback',@(hObject,eventdata)s11_call(hplot5,hObject,eventdata));
end
function s1_call(hplot2,hObject,eventdata)
tt=get(hObject,'value');
global az1
az1=tt*pi/180;
set(hplot2,'xdata',cos(-az1+pi/2))
set(hplot2,'ydata',sin(-az1+pi/2))
end
function s11_call(hplot5,hObject,eventdata)
tt=get(hObject,'value');
global az2
az2=tt*pi/180;
set(hplot5,'xdata',cos(-az2+pi/2))
set(hplot5,'ydata',sin(-az2+pi/2))
end
   
function elevation1(f,hObject,eventdata)
im=imread('side_view.jpg');
ax=axes('Parent',f,'Position',[.41 .05 .30 .30],...
        'visible','off');
    imshow(im)

global el1 ax3
  el1=pi/2+pi/4;
    ax3=axes('Parent',f,'Position',[.41 .45 .30 .30],...
        'visible','off');
    theta=0:.01:2*pi;
    hplot3=plot(ax3,cos(theta),sin(theta));
      axis([-2 2 -2 2])
    grid on
    title('Frontal plane')
                 xlabel('x-axis')
                 ylabel('z-axis')
                 
    hold on
    hplot4=plot(ax3,cos(el1-pi/2),sin(el1-pi/2),'r*'); 
    
      s2= uicontrol(f,'Style','slider',...
        'Min',-45,'Max',230,'Value',110,...
        'SliderStep',[5/360 1/36],'units','pixel',...
        'Position',[550 550 300 15],...
        'Callback',@(hObject,eventdata)s2_call(hplot4,hObject,eventdata));
end
   
function elevation2(f,hObject,eventdata)
global el2 ax3
  el2=pi/2+pi/4;
   
    hplot6=plot(ax3,cos(el2-pi/2),sin(el2-pi/2),'g*'); 
    
      s2= uicontrol(f,'Style','slider',...
        'Min',-45,'Max',230,'Value',110,...
        'SliderStep',[5/360 1/36],'units','pixel',...
        'Position',[550 550 300 15],...
        'Callback',@(hObject,eventdata)s21_call(hplot6,hObject,eventdata));
   end


function s2_call(hplot4,hObject,eventdata)
tt=get(hObject,'value');
global el1
el1=tt*pi/180;
set(hplot4,'xdata',cos(-el1+pi))
set(hplot4,'ydata',sin(-el1+pi))
end
function s21_call(hplot6,hObject,eventdata)
tt=get(hObject,'value');
global el2
el2=tt*pi/180;
set(hplot6,'xdata',cos(-el2+pi))
set(hplot6,'ydata',sin(-el2+pi))
end

          