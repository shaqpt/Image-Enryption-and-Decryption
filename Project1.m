% Author: Shaqueir Tardif
clear;

% Define encyrption variables
secretKey='5b0efc93842eca9a89eb5d652018d5713d02a5881be9241be29b8e80c9db4a4e';
iv='6a75d6d0bc29918ffe1fc1c1';

% Load image
img1_org = imread("sample.jpg");
img_new = img1_org;
imshow(img1_org)

timer = tic();

% Identifies all red pixels where red value far exeeds red and blue value
% and set them to 0
not_red = and(img1_org(:, :, 1) - img1_org(:, :, 2) < 65, (img1_org(:, :, 1) - img1_org(:, :, 3) < 65));

% finds all 0 in logical array notred
[red_posys, red_posxs] = find(not_red == 0);
min_red_posy = min(red_posys);
max_red_posy = max(red_posys);
min_red_posx = min(red_posxs);
max_red_posx = max(red_posxs);
mean_red_posy = mean([min_red_posy, max_red_posy]);
mean_red_posx = mean([min_red_posx,max_red_posx]);

% Mark location of red ball
buffer = 5;
offset = max(abs(mean_red_posx - min_red_posx), abs(mean_red_posy - min_red_posy)) + buffer;
img1_cut = img1_org(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset, :);
imshow(img1_cut)

%Encryption - Selective
[img1_cut,authTag]=ImageEncryption(secretKey, iv, img1_cut, 'AES image');
img_new(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset,:) = img1_cut(:, :, :);
toc(timer)
imshow(img_new)

%Encryption - Full-layer
timer = tic();
[img1_new,authTag2]=ImageEncryption(secretKey, iv, img1_org, 'AES image');
toc(timer)
imshow(img1_new)

%Decryption
img1_cut_dec = img1_org(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset, :);
imshow(img1_cut_dec)
[img1_cut_dec,authTagResult]=ImageDecryption(secretKey, iv, img1_cut, 'AES image', authTag);
img_dec(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset,:) = img1_cut_dec(:, :, :);
timer = tic();
toc(timer)
imshow(img_dec)

%Decryption
timer = tic();
[img1_dec,authTag2Result]=ImageDecryption(secretKey, iv, img1_new, 'AES image', authTag2);
toc(timer)
imshow(img1_dec)
