
path = 'data';
pattern = path + "/img*.jpg";
dinfo = dir(fullfile(pattern));


for j = 1 : length(dinfo)
  filename = fullfile(path, dinfo(j).name);
  im_rgb = imread(filename);
  im_hsv = rgb2hsv(im_rgb);
  
  p(1,:) = [517,125];
  p(2,:) = [619,137];
  p(3,:) = [741,144];
  p(4,:) = [873,151];
  p(5,:) = [203,207];
  p(6,:) = [325,221];
  p(7,:) = [449,235];
  p(8,:) = [573,255];
     
  
  free_green = mask_and_colour(im_hsv(:,:,1),p,10,0.3,0.2);
  
  C = textscan(dinfo(j).name,'%s %d','delimiter','-');
  facit = imag(C{2});
  
  if sum(free_green) == facit
      fprintf('mask_and_colour %s OK!\n', filename);
  else
       fprintf('\nERROR!!! mask_and_colour on %s = %i free\n', filename, sum(free_green));
  end
  

      
%   l(1,1,1,:) = [408,548,578,458];
%   l(1,1,2,:) = [260,228,228,270];
%   l(1,2,1,:) = [556,627,627,556];
%   l(1,2,2,:) = [228,230,255,242];
 


  l(1,:) = [509,110];
  l(2,:) = [612,120];
  l(3,:) = [713,131];
  l(4,:) = [844,136];
  l(5,:) = [117,158];
  l(6,:) = [243,219];
  l(7,:) = [354,234];
  l(8,:) = [470,249];
  
  free_line = zeros(length(l),1);
  
  for i = 1:length(l)
      
      free_line(i) = find_lot_lines(im_hsv(:,:,3),l(i,:),73);
      
      %free_u = find_lot_lines(im_hsv(:,:,3),l(i,2,1,:),l(i,2,2,:),-82);
      %free_line(i) = free_l & free_u;
  end
  
  if sum(free_line) == facit
      fprintf('find_lot_lines %s OK!\n', filename);
  else
      fprintf('ERROR!!! find_lot_lines on %s = %i free\n', filename, sum(free_line));
  end
  

%   clear p;
%   
%   p(1,:) = [542,72];
%   p(2,:) = [700,86];
%   p(3,:) = [820,94];
%   p(4,:) = [940,104];
%   
%   r = [1005, 94];
%   
%   reference1 = mean(mean(im_hsv(r(2)-10:r(2)+10,r(1)-10:r(1)+10,3)));
%   
%   free_gray1 = mask_and_colour(im_hsv(:,:,3),p,10,reference1,0.15);
%  
%   p(1,:) = [218,150];
%   p(2,:) = [324,160];
%   p(3,:) = [423,171];
%   p(4,:) = [582,187];
%   
%   r = [716, 216];
%   
%   reference2 = mean(mean(im_hsv(r(2)-10:r(2)+10,r(1)-10:r(1)+10,3)));
%   
%   free_gray2 = mask_and_colour(im_hsv(:,:,3),p,10,reference2,0.15);
%   
%   r = [1010, 90];
%   im_rgb(r(2)-10:r(2)+10,r(1)-10:r(1)+10,1) = 1;
%   
%   free_gray = [free_gray1; free_gray2];
% 
%   
%   disp(sprintf('%s = %i gray', filename, sum(free_gray)));
end
disp(' ');
%todo: temporal change in each slot

%todo: corner detect in parking lot corner

%todo: arc detect of wheel