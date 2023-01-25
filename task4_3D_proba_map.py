import numpy as np
import nibabel as nib
import os

# Set working directory
directory = 'labels'

# Instantiate a list to store probability maps
probabilities_all_files = []

memory_saver = 50

def iterate_over_segmentations():
    count = 1
# Iterate over segmentation images
    for filename in os.listdir(directory):
        if count < memory_saver:
            f = os.path.join(directory, filename)
            # checking if it is a file
            if os.path.isfile(f):
                # Load the registered and segmented MRI images
                tumour_segmentation = nib.load(f).get_fdata()

                # Create a 3D probability map of the tumour distribution
                tumour_probability = tumour_segmentation / np.sum(tumour_segmentation)

                # Store the tumour probability for each structure
                probabilities_all_files.append(tumour_probability)
            
            count += 1

        else:
            break
        
    return probabilities_all_files

probabilities_all_files = iterate_over_segmentations()

# Average probabilities per voxel
proba_map = sum(probabilities_all_files)/len(probabilities_all_files)

# Save the probability map into a NiFTI format (not working yet)
# proba_map_img = nib.Nifti1Image(proba_map)
# nib.save(proba_map_img, '3D_probability_map.nii')

# Display the array
print(proba_map)