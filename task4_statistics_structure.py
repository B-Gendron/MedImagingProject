import numpy as np
import nibabel as nib
import os

# Set working directory
directory = 'labels'

# Load structure segmentation image
structure_segmentation = nib.load("simple_segmentation.nii").get_fdata()

# Instantiate empty lists to store probabilities
proba_0 = []
proba_1 = []
proba_2 = []

# Unzip segmentation images
for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    # checking if it is a file
    if os.path.isfile(f):
        # Load the registered and segmented MRI images
        tumour_segmentation = nib.load(f).get_fdata()

        # Create a 3D probability image of the tumour distribution
        tumour_probability = tumour_segmentation / np.sum(tumour_segmentation)

        # Compute the tumour probability for each structure
        structure_labels = np.unique(structure_segmentation)
        tumour_probability_by_structure = {}
        for label in structure_labels:
            structure_voxels = np.where(structure_segmentation == label)
            tumour_voxels_in_structure = np.sum(tumour_segmentation[structure_voxels]) # issue here
            tumour_probability_by_structure[label] = tumour_voxels_in_structure / len(structure_voxels[0])

        # Store the tumour probability for each structure
        proba_0.append(tumour_probability_by_structure[0.0])
        proba_1.append(tumour_probability_by_structure[1.0])
        proba_2.append(tumour_probability_by_structure[2.0])

# Average probabilities per structure
p0, p1, p2 = sum(proba_0)/len(proba_0), sum(proba_1)/len(proba_1), sum(proba_2)/len(proba_2)

# Display result
print(f'The overall probabilities to have a tumour in structure 0 is {p0}')
print(f'The overall probabilities to have a tumour in structure 1 is {p1}')
print(f'The overall probabilities to have a tumour in structure 2 is {p2}')