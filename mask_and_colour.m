function lot_free = mask_and_colour(im,p,siz,should,thres)

park_mask = zeros([size(im),length(p)]);
%agg = zeros([size(im)]);
lot_free = zeros(length(p),1);

for n = 1:length(p) % for each lot
    park_mask(p(n,2)-siz:p(n,2)+siz,p(n,1)-siz:p(n,1)+siz,n) = 1; % create a mask
    %agg = agg + park_mask(:,:,n);
end

% im_ycbcr = rgb2ycbcr(im_rgb);
% hist = im_ycbcr(:,:,1) - min(min(im_ycbcr(:,:,1)));
% hist = hist * (255/double(max(max(hist))));
% im_ycbcr(:,:,1) = uint8(hist);
% im_rgb = ycbcr2rgb(im_ycbcr);


% subplot(2,1,1)
% imshow(im);
% subplot(2,1,2)
% imshow(im+ agg);

for i = 1:length(p) % for each lot
    temp = abs((im .* park_mask(:,:,i)) - should) < thres; % is the lot areas hue value _should_ +/- _thres_ (green tarmac)?
    lot_free(i) = sum(sum(temp)) > sum(sum(park_mask(:,:,i)))*0.7; % is at least 70% of the lot area green then the lot should be free
end
end

    
