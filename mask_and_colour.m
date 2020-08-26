im_rgb = imread('data/6.jpg');

park_mask = zeros([size(im_rgb(:,:,1)),8]);
agg = zeros([size(im_rgb(:,:,1))]);
lot_free = zeros(8,1);

%define the coordinates for a suitable spot in each lot 1 to 8
p(1,:) = [517,125];
p(2,:) = [619,137];
p(3,:) = [741,144];
p(4,:) = [873,151];
p(5,:) = [203,207];
p(6,:) = [325,221];
p(7,:) = [449,235];
p(8,:) = [573,255];


for n = 1:8 % for each lot
    park_mask(p(n,2)-10:p(n,2)+10,p(n,1)-10:p(n,1)+10,n) = 1; % create a mask
    agg = agg + park_mask(:,:,n);
end

im_ycbcr = rgb2ycbcr(im_rgb);
hist = im_ycbcr(:,:,1) - min(min(im_ycbcr(:,:,1)));
val = max(max(hist))
hist = hist * (255/double(max(max(hist))));
max(max(hist))
im_ycbcr(:,:,1) = uint8(hist);
im_rgb = ycbcr2rgb(im_ycbcr);
im_hsv = rgb2hsv(im_rgb);
imshow(im_hsv(:,:,1));
%imshow(im_rgb(:,:,2)+uint8(agg*255));

for i = 1:8 % for each lot
    temp = abs((im_hsv(:,:,1) .* park_mask(:,:,i)) - 0.3) < 0.2; % is the lot areas hue value 0.2 +/- 0.05 (green tarmac)?
    lot_free(i) = sum(sum(temp)) > sum(sum(park_mask(:,:,i)))*0.7; % is at least 50% of the lot area green then the lot should be free
end

disp('Number of free lots')
sum(lot_free)
