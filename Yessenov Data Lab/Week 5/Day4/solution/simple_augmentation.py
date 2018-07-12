import numpy as np
import tensorflow as tf

def augment_data(dataset, dataset_labels, use_random_rotation=True, use_random_shear=True, use_random_shift=True, use_random_zoom=True):
	augmented_image = []
	augmented_image_labels = []

	for num in range (0, dataset.shape[0]):
		img = dataset[num]
		if use_random_rotation and (np.random.uniform() > 0.5):
			img = tf.contrib.keras.preprocessing.image.random_rotation(img, 10., row_axis=0, col_axis=1, channel_axis=2)

		if use_random_shear and (np.random.uniform() > 0.5):
			img = tf.contrib.keras.preprocessing.image.random_shear(img, 0.1, row_axis=0, col_axis=1, channel_axis=2)

		if use_random_shift and (np.random.uniform() > 0.5):
			img = tf.contrib.keras.preprocessing.image.random_shift(img, 0.1, 0.1, row_axis=0, col_axis=1, channel_axis=2)

		if use_random_zoom and (np.random.uniform() > 0.5):
			img = tf.contrib.keras.preprocessing.image.random_zoom(img, [0.9, 1.1], row_axis=0, col_axis=1, channel_axis=2)

		#if redundant augmentations that only deteriorate the performance:
		# Flipping
		# if (np.random.uniform() > 0.5):
		# 	img = np.fliplr(img)
		# if (np.random.uniform() > 0.5):
		# 	img = np.flipud(img)

		augmented_image.append(img)
		augmented_image_labels.append(dataset_labels[num])


	return np.array(augmented_image), np.array(augmented_image_labels)
