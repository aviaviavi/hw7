train_data = load('data/train.mat');
train_small_data = load('data/train_small.mat');
test_data = load('data/test.mat');
train_small = create_sparse_img(double(train_small_data.train{3}.images));
%train = create_sparse_img(double(train_data.train.images));
test_images = create_sparse_img(double(test_data.test.images));

means = kmeans(train_small, 20);