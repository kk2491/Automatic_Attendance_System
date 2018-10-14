%main program
clc;

%read the image

img = imread('3.jpg');

%initialize the detector
detector = buildDetector();

%find the face in the photo
[bbox ,bbimg ,bbfaces] = detectFaceParts(detector,img);

%original photo
%figure;
%imshow(bbimg);

%individual photos
for i=1:size(bbfaces,1)
 %figure;
 %imshow(bbfaces{i});
 %saving the individual faces
 %size(bbfaces{i});
 %bbfaces{i}=rgb2gray(bbfaces{i}); 
 bbfaces{i}=imresize(bbfaces{i},[60 60]);
 %size(bbfaces{i});
 %imshow(bbfaces{i});
 imwrite(bbfaces{i},strcat(num2str(i),'.jpg'));
end

disp('number of faces detected=');
disp(size(bbfaces,1));