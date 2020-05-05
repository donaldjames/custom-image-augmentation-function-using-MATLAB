%%%%%%%%%%%%%%%%%%%%%%%
% This matlab custom function takes in a text file of images url along with
% label, a destination folder link and a output text file name
% This function takes in each images of the input text
% 1. Normal image
% 2. Random rotated image
% 3. Random scaled image
% 4. Random reflection image along X axis
% 5. Random reflection image along Y axis
% 6. Grayscale image
%%%%%%%%%%%%%%%%%%%%%%%
function x = custom_augmentation_function(input_text_file, destination_folder, output_text_file)
    x = "Failed";
    file_id = fopen(input_text_file);
    image_list = textscan(file_id, '%s', 'delimiter', '\n');
    file_name_pattern = '\w*.jpg';
    image_label_pattern = ' \d*';

    image_updated_list = {};
    % if the destination folder does not exist create a new folder
    if ~exist(destination_folder, 'dir')
        mkdir(destination_folder)
    end
    % Reading the image one by one and performing the augmentation
    for data_row = 1:length(image_list{1})
        normal_image = image_list{1}{data_row};
        image_url = strtok(string(normal_image), ' ');
        %%image_url = string(regexp(normal_image, image_url_pattern, 'match'));
        image_name = regexp(normal_image, file_name_pattern, 'match');
        image_label = regexp(normal_image, image_label_pattern, 'match');
        image = imread(image_url);
        % Augmenting the original image set
        augmentation1 = imageDataAugmenter('RandRotation', [0, 360]); % Random Rotation
        augmentation2 = imageDataAugmenter('RandScale', [0.5, 1]); % Random Scale
        augmentation3 = imageDataAugmenter('RandXReflection', true); % X Reflection
        augmentation4 = imageDataAugmenter('RandYReflection', true); % Y Reflection
        %%
        % Applying the augment operation on original image
        random_rotation = augment(augmentation1, image);
        random_scale = augment(augmentation2, image);
        random_x_reflection = augment(augmentation3, image);
        random_y_reflection = augment(augmentation4, image);
        augment_image_cell = {image, random_rotation, random_scale, ...
            random_x_reflection, random_y_reflection};
        %%
        % converting the image to greyscale
        grayscale_image = rgb2gray(image);
        augment_image_cell{end+1} = grayscale_image;
        %%
        % Saving the image to new folder car_train_image
        for i = 1:length(augment_image_cell)
            updated_filename = destination_folder + "\" + "augment_" + i + "_" + image_name;
            imwrite(augment_image_cell{i}, updated_filename);
            image_updated_list{end + 1} = updated_filename + " " + image_label;
        end
        %%
    end
    write_file_id = fopen(output_text_file, 'w');
    for row = 1:length(image_updated_list)
        fprintf(write_file_id, '%s\n', image_updated_list{row});
    end
    fclose(write_file_id);
    fclose(file_id);
    x = "Success";
end