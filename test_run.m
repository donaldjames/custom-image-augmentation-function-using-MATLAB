%%
% The arguments to be passed are (update it and uncomment if you would like
% to run the code using test_run.m else refer it for your ease of operation
% input_text_file = ''; %% The .txt file with images names and label. Try
%                       %% to provide full path for hussle free operation
% destination_folder = ''; %% The destination folder where to save the 
%                          %% images. Try to provide full path.  
% output_text_file = '';%% The .txt file name to which you would like 
%                       %% to save the images. Try to provide full path 
%                       %% for hussle free operation
% augmentation_list = ''; %% for eg [1 5 8] or [9] for all
% grayscale = ''; %% optional argument. provide '1'  if you wan't grayscale
%                 %% conversion
%%
x = custom_augmentation_function(input_text_file, destination_folder, output_text_file, augmentation_list, grayscale);