im_rgb = imread('2.jpg');

park_mask = zeros([size(im_rgb(:,:,1)),8]);
lot_free = zeros(8,1);

%define the mask for each lot 1 to 8
park_mask(370:400,610:650,6) = 1;
park_mask(390:410,760:820,7) = 1;
park_mask(350:390,940:1020,8) = 1;
%note these could all be manually defined when all slots are empty

im_hsv = rgb2hsv(im_rgb);

for i = 1:8 % for each lot
    temp = abs((im_hsv(:,:,1) .* park_mask(:,:,i)) - 0.2) < 0.05; % is the lot areas hue value 0.2 +/- 0.05 (green tarmac)?
    lot_free(i) = sum(sum(temp)) > sum(sum(park_mask(:,:,i)))*0.4; % is at least 50% of the lot area green then the lot should be free
end

disp('Number of free lots')
sum(lot_free)
