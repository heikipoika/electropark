function lot_free = find_lot_lines(im,l,should)

%mask = roipoly(im,l1,l2);
mask = zeros([size(im)]);
mask(l(2)-10:l(2)+10,l(1)-40:l(1)+40) = 1;
edges = edge(im,'canny');

%subplot(2,1,1)
%imshow(im);
%subplot(2,1,2)
%imshow(edges.*mask)

[H,T,R] = hough(edges.*mask);
peaks = houghpeaks(H,'threshold',15); %perhaps define a numpeaks to be able to determine a big difference?

if(not(isempty(peaks)))
    lot_free = abs(T(peaks(2))-should) < 5;
    %input(sprintf('peak %i',T(peaks(2))));
else
    lot_free = 0;
    %input('no peaks');
end
   
end

