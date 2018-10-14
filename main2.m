%Main program
clear memory
clear all
clc;
close all


TrainDatabasePath = 'F:\workplace\classtrain';
TestDatabasePath = 'F:\workplace\classtest';
prompt = {'Enter test image  :'};
dlg_title = ' Face Recognition System';
num_lines= 1;
def = {'1'};
TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.jpg');

disp(TrainDatabasePath);
%Read test images
im= imread(TestImage);
%Call CreateDatabase  
T = CreateDatabase(TrainDatabasePath);
%Calculating the features of training images 
[m, A, Eigenfaces] = face(T);
%Recognition of the test
OutputName = recog(TestImage, m, A, Eigenfaces);


SelectedImage = strcat(TrainDatabasePath,'\',OutputName);

SelectedImage = imread(SelectedImage);

imshow(im);
title('Image to be tested');
figure,imshow(SelectedImage);
title('Equivalent Image');