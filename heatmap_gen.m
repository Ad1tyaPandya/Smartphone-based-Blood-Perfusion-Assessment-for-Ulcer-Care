clear all;
clc;
%% finger image data extract
grid = [30 30];
biomatrix3 = 'somefile1.avi';
bobybobjoe = '20211014_Wenhan_finger_1.avi';
fakeboba = 'input.avi';
vidObj = VideoWriter(fakeboba);
%disp(vidObj.Duration;)



rd = VideoReader(fakeboba);
bob = ((read(rd)));
fakebob = im2single(bob);
disp(rd.Duration);

disp(size(fakebob));
disp(size(bob));
newarr = fakebob(:,:,1,:);

obj = VideoReader(fakeboba);
disp(size(obj));
disp('hi');

h = floor(linspace(0, obj.Height, grid(1)+1));
h = diff(h);
w = floor(linspace(0, obj.Width, grid(2)+1));
w = diff(w);



 
% bromatrix4 = mean(BIT_Frames(:,:,:,:),3);

biomatrix3 = squeeze(newarr);
nf = size(biomatrix3,3);
 
 
%% heart beat abstract


a = zeros(nf, grid(1), grid(2));
meanall = @(x) mean(x, 'all');
 
for i =1:nf
     temp = mat2cell(biomatrix3(:,:,i), h, w);
     a(i,:,:)= cellfun(meanall, temp);
end
 
a = detrend(a, 8);
a_n = normalize(a(:,:,:),1,'range');
a_n = abs(fft(a_n) ./ nf);
a_n = a_n(1:nf/2+1, :, :);
 
 
 
 
Fs = 24; % Sampling frequency
L = size(biomatrix3,3);
f = Fs*(0:(L/2))/L;

disp(f);
disp("something1");

l_l = find(f==1.2);%Unit in Hz define the lower limit of frequency range
u_l = find(f==2);  %Unit in Hz define the upper limit of frequency range
 
% a_n(2:end-1, :, :) = a_n(2:end-1, :, :)*2;
%%% normalize problem unsolved
%%% ppt
%%% send paper
% a_n = normalize(a(6:30,:,:),1,'range');


disp(l_l);
disp(u_l);
disp("something");
l_l = 1;
u_l = 30;
% a_n = a(6:30,:,:)./max(a(6:30,:,:),[],'all');
intensity = zeros(grid(1), grid(2));
for i = 1:grid(1)
    for j = 1:grid(2)
        
        p = findpeaks(a_n(l_l:u_l,i,j)); % should find peaks in the heart rate frequency range
        % 9:22 coreesponding to 0.833 ~2.187 Hz
        if isempty(p)
            p = 0;
           
             end
           
           
        intensity(i,j) = p(1);
       
    end
end
% intensity(intensity<0.015)=0;
 
figure
imshow(intensity(:,:),[]);
figure
heatmap(intensity);
colormap hot
 
 
figure
imshow(biomatrix3(:,:,1))
level = 0.195;
BW = imbinarize(biomatrix3(:,:,1),level);
h = heatmap(intensity .* BW(1:24:end,1:16:end));
XLabels = 1:30;
% Convert each number in the array into a string
CustomXLabels = string(XLabels);
% Replace all but the fifth elements by spaces
CustomXLabels(mod(XLabels,5) ~= 0) = " ";
% Set the 'XDisplayLabels' property of the heatmap
% object 'h' to the custom x-axis tick labels
h.XDisplayLabels = CustomXLabels;
h.YDisplayLabels = CustomXLabels;
grid off
colormap hot
 
 
Fs = 24; % Sampling frequency
L = size(biomatrix3,3);
f = Fs*(0:(L/2))/L;
figure;
% plot(f,a_n(:,44,48));
plot(a_n(:,18,21));

saveas(figure(1),[pwd '/Figures/figure1.fig']);
saveas(figure(2),[pwd '/Figures/figure2.fig']);
saveas(figure(3),[pwd '/Figures/figure3.fig']);
saveas(figure(4),[pwd '/Figures/figure4.fig']);
 
saveas(figure(1),[pwd '/Images/figure1.png']);
saveas(figure(2),[pwd '/Images/figure2.png']);
saveas(figure(3),[pwd '/Images/figure3.png']);
saveas(figure(4),[pwd '/Images/figure4.png']);
 
 

