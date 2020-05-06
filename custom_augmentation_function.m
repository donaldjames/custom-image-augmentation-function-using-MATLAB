%%%%%%%%%%%%%%%%%%%%%%%
% This matlab custom function takes in a text file of images url along with
% label, a destination folder link and a output text file name
% This function takes in each images of the input text gives out
% 1. Normal image
% 2. Random rotated image
% 3. Random scaled image
% 4. Random reflection image along X axis
% 5. Random reflection image along Y axis
% 6. Random X shear
% 7. Random Y shear
% 8. Random X translation
% 9. Random Y translation
% 10. Grayscale image
%%%%%%%%%%%%%%%%%%%%%%%
function x = custom_augmentation_function(input_text_file, destination_folder, output_text_file, augmentation_list, grayscale)
    if length(augmentation_list) > 1
       if ismember(9, augmentation_list)
           disp("Provide [9] if you want to do all the augmentation else provide the list with values between 0 and 8");
           return;
       end
    end
    if ~exist(grayscale)
        grayscale_con = 0;
    end
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
        disp(image_url);
        % Augmenting the original image set
        augment_image_cell = {};
        for aug_method in augmentation_list
            switch augmentation_list
                case 1
                    augmentation1 = imageDataAugmenter('RandRotation', [0, 360]); % Random Rotation
                    random_rotation = augment(augmentation1, image);
                    augment_image_cell{end+1} = [random_rotation, 'random_rotation'];
                case 2
                    augmentation2 = imageDataAugmenter('RandScale', [0.5, 1]); % Random Scale
                    random_scale = augment(augmentation2, image);
                    augment_image_cell{end+1} = [random_scale, 'random_scale'];
                case 3
                    augmentation3 = imageDataAugmenter('RandXReflection', true); % X Reflection
                    random_x_reflection = augment(augmentation3, image);
                    augment_image_cell{end+1} = [random_x_reflection, 'random_x_reflection'];
                case 4
                    augmentation4 = imageDataAugmenter('RandYReflection', true); % Y Reflection
                    random_y_reflection = augment(augmentation4, image);
                    augment_image_cell{end+1} = [random_y_reflection, 'random_y_reflection'];
                case 5
                    augmentation5 = imageDataAugmenter('RandXShear', [0, 45]); % Random X shear
                    random_x_shear = augment(augmentation5, image);
                    augment_image_cell{end+1} = [random_x_shear, 'random_x_shear'];
                case 6
                    augmentation6 = imageDataAugmenter('RandYShear', [0, 45]); % Random Y shear
                    random_y_shear = augment(augmentation6, image);
                    augment_image_cell{end+1} = [random_y_shear, 'random_y_shear'];
                case 7
                    augmentation7 = imageDataAugmenter('RandXTranslation', [0 45]); % Random X translation
                    random_x_translation = augment(augmentation7, image);
                    augment_image_cell{end+1} = [random_x_translation, 'random_x_translation'];
                case 8
                    augmentation8 = imageDataAugmenter('RandYTranslation', [0 45]); % Random Y translation
                    random_y_translation = augment(augmentation8, image);
                    augment_image_cell{end+1} = [random_y_translation, 'random_y_translation'];
                case 9
                    augmentation1 = imageDataAugmenter('RandRotation', [0, 360]); % Random Rotation
                    augmentation2 = imageDataAugmenter('RandScale', [0.5, 1]); % Random Scale
                    augmentation3 = imageDataAugmenter('RandXReflection', true); % X Reflection
                    augmentation4 = imageDataAugmenter('RandYReflection', true); % Y Reflection
                    augmentation5 = imageDataAugmenter('RandXShear', [0, 45]); % Random X shear
                    augmentation6 = imageDataAugmenter('RandYShear', [0, 45]); % Random Y shear
                    augmentation7 = imageDataAugmenter('RandXTranslation', [0 45]); % Random X translation
                    augmentation8 = imageDataAugmenter('RandYTranslation', [0 45]); % Random Y translation
                    % applying all the augmentations
                    % Applying the augment operation on original image
                    random_rotation = augment(augmentation1, image);
                    random_scale = augment(augmentation2, image);
                    random_x_reflection = augment(augmentation3, image);
                    random_y_reflection = augment(augmentation4, image);
                    random_x_shear = augment(augmentation5, image);
                    random_y_shear = augment(augmentation6, image);
                    random_x_translation = augment(augmentation7, image);
                    random_y_translation = augment(augmentation8, image);
                    augment_image_cell = {[image, 'source'], ...
                        [random_rotation, 'random_rotation']...
                        [random_scale, 'random_scale'], ...
                        [random_x_reflection, 'random_x_reflection'], ...
                        [random_y_reflection, 'random_y_reflection'], ...
                        [random_x_shear, 'random_x_shear'], ...
                        [random_y_shear, 'random_y_shear'], ...
                        [random_x_translation, 'random_x_translation'], ...
                        [random_y_translation, 'random_y_translation']};                    
                otherwise
                    disp("provide a valid option list with options between (0-8) or '9' for all");
            end
        end
        %%
        % converting the image to greyscale
        % First check whether the image is already grayscale if so skip
        % this greyscale conversion
        if grayscale_con
            [rows, columns, layers] = size(image);
            if layers > 1
                grayscale_image = rgb2gray(image);
                augment_image_cell{end+1} = [grayscale_image, 'grayscale'];
            end
        end
        %%
        % Saving the image to new folder car_train_image
        for i = 1:length(augment_image_cell)
            updated_filename = destination_folder + augment_image_cell{i}(2) + "_" + image_name;
            imwrite(augment_image_cell{i}(1), updated_filename);
            image_updated_list{end + 1} = updated_filename + image_label;
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