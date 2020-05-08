# custom_augmentation_function
This is an image augmentation function written for beginners
to do multiple image augmentation operations using MATLAB.

Files
This contains 2 files
1. custom_augmentation_fuction.m : The custom augmentation 
 function for performing the operations
2. test_run.m : A demo of how to use the function

How it works?
1. It takes in images line by line from 'input_text_file'
 text file where the image name is provided in the following 
 pattern 'C:/XXXX/XXX/<file_name.jpg> label' where label is 
 the label of the image you have provided. 
2. The options for image augmentations to be done is as follows
 '1' - Random rotated image
 '2' - Random scaled image
 '3' - Random reflection image along X axis
 '4' - Random reflection image along Y axis
 '5' - Random X shear
 '6' - Random Y shear
 '7' - Random X translation
 '8' - Random Y translation
 '9' - For all the above operations
 If you want to perform Random rotation only provided
 augmentation_list = [1] or if you would like to do more than
 one augmentation for example X shear and Y transaltion along 
 with random scaling then provide [2 5 8]. If you would like
 to do all the operations then provide [9]
3. If you like to do grayscale conversion provide grayscale
 option as '1'. This is an optional argument
4. Provide the destination folder where to save all the 
 augmented images along with the source image to 
 'destination_folder'. Always try to provide the full path.
5. Provide the output text file name as output_text_file.
 Always try to provide the full path.
 
* This function was created for my personal use and like to
 share it with anyone, mainly MATLAB beginners for doing image
 augmentation. 
* I created this function to become familiar with
 matlab function operations, switch, read and write files, 
 image augmentation.
* If you find any error in the function or if you have any 
 suggestions please email to 'donaldjk1109@gmail.com'
* I refered the following mathwork link for 
imagedataaugmenter
uk.mathworks.com/help/deeplearning/ref/imagedataaugmenter.html
switch
uk.mathworks.com/help/matlab/ref/switch.html
file operations
uk.mathworks.com/help/matlab/ref/fopen.html
functions
uk.mathworks.com/help/matlab/matlab_prog/create-functions-in-files.html
