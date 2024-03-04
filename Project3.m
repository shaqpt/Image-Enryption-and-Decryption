% Author: Shaqueir Tardif
clear;

% Define encyrption variables
secretKey='5b0efc93842eca9a89eb5d652018d5713d02a5881be9241be29b8e80c9db4a4e';
iv='6a75d6d0bc29918ffe1fc1c1';

% Load image
img1_org = imread("test2.jpeg");
img_new = img1_org;
img_new2 = img1_org;
lefthalf = img1_org(:, 1:end/2, :);
righthalf = img1_org(:, end/2+1:end, :);
imshow(img1_org)

timer = tic();

% Identifies all red pixels where red value far exeeds red and blue value
% and set them to 0
not_redL = and(lefthalf(:, :, 1) - lefthalf(:, :, 2) < 65, (lefthalf(:, :, 1) - lefthalf(:, :, 3) < 65));

% finds all 0 in logical array notred on left side of image
[red_posys, red_posxs] = find(not_redL == 0);
min_red_posy = min(red_posys);
max_red_posy = max(red_posys);
min_red_posx = min(red_posxs);
max_red_posx = max(red_posxs);
mean_red_posy = mean([min_red_posy, max_red_posy]);
mean_red_posx = mean([min_red_posx,max_red_posx]);


% Mark location of red plates
buffer = 5;
offset = max(abs(mean_red_posx - min_red_posx), abs(mean_red_posy - min_red_posy)) + buffer;
img1_cut = img1_org(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset, :);
imshow(img1_cut)

% Identifies all red pixels where red value far exeeds red and blue value
% and set them to 0
not_redR = and(righthalf(:, :, 1) - righthalf(:, :, 2) < 65, (righthalf(:, :, 1) - righthalf(:, :, 3) < 65));

% finds all 0 in logical array notred on right side of image
[red_posys, red_posxs] = find(not_redR == 0);
min_red_posy = min(red_posys);
max_red_posy = max(red_posys);
min_red_posx = min(red_posxs);
max_red_posx = max(red_posxs);
mean_red_posy = mean([min_red_posy, max_red_posy]);
mean_red_posx = mean([min_red_posx,max_red_posx]);

buffer = 5;
offset2 = max(abs(mean_red_posx2 - min_red_posx2), abs(mean_red_posy2 - min_red_posy2)) + buffer;
img2_cut = img1_org(mean_red_posy2 - offset2: mean_red_posy2 + offset2, mean_red_posx2 - offset2: mean_red_posx2 + offset2, :);
imshow(img2_cut)

%Encryption
[img1_cut,authTag]=ImageEncryption(secretKey, iv, img1_cut, 'AES image');
img_new(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset,:) = img1_cut(:, :, :);
toc(timer)
imshow(img_new)

[img2_cut,authTag]=ImageEncryption(secretKey, iv, img2_cut, 'AES image');
img_new2(mean_red_posy2 - offset2: mean_red_posy2 + offset2, mean_red_posx2 - offset2: mean_red_posx2 + offset2,:) = img2_cut(:, :, :);
toc(timer)
imshow(img_new2)

%Combine both half images, forming new full image
toc(timer)
left = img_new2(:, 1:end/2, :);
right = img_new(:, end/2+1:end, :);
imshowpair(left, right, 'Montage')

%Encryption
timer = tic();
[img1_new,authTag2]=ImageEncryption(secretKey, iv, img1_org, 'AES image');
toc(timer)
imshow(img1_new)
=======
% Author: Shaqueir Tardif
clear;

% Define encyrption variables
secretKey='5b0efc93842eca9a89eb5d652018d5713d02a5881be9241be29b8e80c9db4a4e';
iv='6a75d6d0bc29918ffe1fc1c1';

% Load image
img1_org = imread("test2.jpeg");
img_new = img1_org;
img_new2 = img1_org;
lefthalf = img1_org(:, 1:end/2, :);
righthalf = img1_org(:, end/2+1:end, :);
imshow(img1_org)

timer = tic();

% Identifies all red pixels where red value far exeeds red and blue value
% and set them to 0
not_redL = and(lefthalf(:, :, 1) - lefthalf(:, :, 2) < 65, (lefthalf(:, :, 1) - lefthalf(:, :, 3) < 65));

% finds all 0 in logical array notred on left side of image
[red_posys, red_posxs] = find(not_redL == 0);
min_red_posy = min(red_posys);
max_red_posy = max(red_posys);
min_red_posx = min(red_posxs);
max_red_posx = max(red_posxs);
mean_red_posy = mean([min_red_posy, max_red_posy]);
mean_red_posx = mean([min_red_posx,max_red_posx]);


% Mark location of red plates
buffer = 5;
offset = max(abs(mean_red_posx - min_red_posx), abs(mean_red_posy - min_red_posy)) + buffer;
img1_cut = img1_org(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset, :);
imshow(img1_cut)

% Identifies all red pixels where red value far exeeds red and blue value
% and set them to 0
not_redR = and(righthalf(:, :, 1) - righthalf(:, :, 2) < 65, (righthalf(:, :, 1) - righthalf(:, :, 3) < 65));

% finds all 0 in logical array notred on right side of image
[red_posys, red_posxs] = find(not_redR == 0);
min_red_posy = min(red_posys);
max_red_posy = max(red_posys);
min_red_posx = min(red_posxs);
max_red_posx = max(red_posxs);
mean_red_posy = mean([min_red_posy, max_red_posy]);
mean_red_posx = mean([min_red_posx,max_red_posx]);

buffer = 5;
offset2 = max(abs(mean_red_posx2 - min_red_posx2), abs(mean_red_posy2 - min_red_posy2)) + buffer;
img2_cut = img1_org(mean_red_posy2 - offset2: mean_red_posy2 + offset2, mean_red_posx2 - offset2: mean_red_posx2 + offset2, :);
imshow(img2_cut)

%Encryption
[img1_cut,authTag]=ImageEncryption(secretKey, iv, img1_cut, 'AES image');
img_new(mean_red_posy - offset: mean_red_posy + offset, mean_red_posx - offset: mean_red_posx + offset,:) = img1_cut(:, :, :);
toc(timer)
imshow(img_new)

[img2_cut,authTag]=ImageEncryption(secretKey, iv, img2_cut, 'AES image');
img_new2(mean_red_posy2 - offset2: mean_red_posy2 + offset2, mean_red_posx2 - offset2: mean_red_posx2 + offset2,:) = img2_cut(:, :, :);
toc(timer)
imshow(img_new2)

%Combine both half images, forming new full image
toc(timer)
left = img_new2(:, 1:end/2, :);
right = img_new(:, end/2+1:end, :);
imshowpair(left, right, 'Montage')

%Encryption
timer = tic();
[img1_new,authTag2]=ImageEncryption(secretKey, iv, img1_org, 'AES image');
toc(timer)
imshow(img1_new)
