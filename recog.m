%Function used to recognise the test
function OutputName = recog(TestImage, m, A, Eigenfaces)

ProjectedImages = [];
Train_Number = size(Eigenfaces,2);
for i = 1 : Train_Number
    temp = Eigenfaces'*A(:,i); 
    ProjectedImages = [ProjectedImages temp]; 
end


%Extracting the PCA features from test image
InputImage = imread(TestImage);
InputImage = rgb2gray(InputImage);
temp = InputImage(:,:,1);
[irow icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
Difference = double(InImage)-m; 
ProjectedTestImage = Eigenfaces'*Difference; 


% Calculating Euclidean distances 
Euc_dist=[];
for i = 1 : Train_Number
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    Euc_dist = [Euc_dist temp];
end

[Euc_dist_min , Recognized_index] = min(Euc_dist);
disp(Euc_dist_min);
OutputName = strcat(int2str(Recognized_index),'.jpg');