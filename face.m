%Function to calculate the features of the training images
function [m, A, Eigenfaces] = face(T)

m = mean(T,2); 
Train_Number = size(T,2);


%Calculating the deviation of each image from mean image
A = [];  
for i = 1 : Train_Number
    temp = double(T(:,i)) - m; 
    A = [A temp]; 
end


L = A'*A ;
[V D] = eig(L); 


% Sorting and eliminating eigenvalues
L_eig_vec = [];
for i = 1 : size(V,2) 
    if( D(i,i)>1 )
        L_eig_vec = [L_eig_vec V(:,i)];
    end
end


% Calculating the eigenvectors
Eigenfaces = A * L_eig_vec; 