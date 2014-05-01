load 'mask.mat'
mask = mask(:,:,1);
unmasked_pixels = find(mask);
celeb_files = dir('CelebrityDatabase/*.jpg')';
student_files = dir('StudentDatabase/*.jpg')';
celebs = [];
students = [];
k = 20;
%process celebrity pictures
for celeb = celeb_files
    img = rgb2gray(uint8(imread(sprintf('CelebrityDatabase/%s', celeb.name))));
    im_vector = img(unmasked_pixels);
    full_img = zeros(size(mask));
    full_img(unmasked_pixels) = im_vector;
    full_img = uint8(full_img);
    imshow((full_img))
    %im_vector = full_img(unmasked_pixels);
    celebs = [celebs; im_vector'];
end
%process student pictures
for student = student_files
    img = rgb2gray(uint8(imread(sprintf('StudentDatabase/%s', student.name))));
    im_vector = img(unmasked_pixels);
    full_img = zeros(size(mask));
    full_img(unmasked_pixels) = im_vector;
    full_img = uint8(full_img);
    imshow((full_img))
    %im_vector = full_img(unmasked_pixels);
    students = [students; im_vector'];
end

cov_matrix = cov(double(celebs));
disp 'here'
[V, D] = eigs(cov_matrix, k);


% for i = 1:10
%    figure;
%    V(:,i) = 255*(V(:,i) / max(V(:,i)));
%    eig = V(:,i);
%    
%    
%    fullimg = zeros(330,280);
%    fullimg(unmasked_pixels) = eig;
%    imgtosave = imshow(uint8(fullimg));
%    saveas(imgtosave, sprintf('eigenface_%d', i), 'png');
% end

rec_students = [1 2 3 4 5];
for face = rec_students
    original = zeros(330, 280);
    reconstructed = zeros(330, 280);
    x = V \ double(students(face,:)');
    new_face = V * x;
    original(unmasked_pixels) = students(face,:);
    reconstructed(unmasked_pixels) = new_face;
    figure;
    subplot(1, 2, 1), imshow(uint8(original));
    subplot(1, 2, 2), imshow(uint8((reconstructed)));
end

total_error = [];
for num_eigs = 1:k
    error = 0;
    for i = 1:size(students, 1)
        x = V(:,1:num_eigs) \ double(students(i,:))';
        new_face = V(:,1:num_eigs) * x;
        error = error + norm(new_face' - double(students(i,:)));
    end
    error = error / size(students, 1);
    total_error = [total_error, error];
end
figure;
plot([1:k], total_error)
title('Average L2 error vs Number of Eigenfaces (students)');












