function [ means ] = kmeans( data, k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
epsilon = .01;
max_iter = 100;
p = randperm(size(data, 1));
means = data(p(1:k),:);
%iteration
for iter = 1:max_iter
    iter
    label_vec = zeros(size(data, 1), 1);
    %all datapoints
    for point = 1:size(data, 1)
        best_d = Inf;
        %all means
        for mean = 1:k
            distance = norm(data(point,:) - means(mean,:));
            if distance < best_d
                best_d = distance;
                best_mean = mean;
            end
        end
        label_vec(point) = best_mean;
    end
    %calculate new means
    converged = true;
    for mean = 1:k
        dis_data = data(label_vec == mean,:);
        dat_mean = sum(dis_data) / size(dis_data, 1);
        if norm(dat_mean - means(mean,:)) > epsilon
            converged = false;
        end
        means(mean,:) = dat_mean;
    end
    if converged
        disp 'converged'
        break;
    end
end
end

