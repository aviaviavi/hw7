load 'mask.mat'
unmasked_pixels = find(mask);
cd 'CelebrityDatabase'
celeb_files = dir('*.jpg')';
celebs = [];
for celeb = celeb_files
    img = imread(celeb.name);
    im_vector = img(unmasked_pixels);
    full_img = zeros(size(mask));
    full_img(unmasked_pixels) = im_vector;
    full_img = rgb2gray(uint8(full_img));
    imshow((full_img))
    im_vector = full_img(unmasked_pixels(1:17317));
    celebs = [celebs; im_vector'];
end
cd '..'

cov_matrix = cov(double(celebs));
disp 'here'
[V, D] = eigs(cov_matrix, 10);




