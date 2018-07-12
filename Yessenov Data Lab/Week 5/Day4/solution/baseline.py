from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import sys

from tensorflow.examples.tutorials.mnist import input_data

import tensorflow as tf
from tqdm import tqdm
import numpy as np
FLAGS_NET = {}
FLAGS_NET['optimizer_lr'] = 1e-4
FLAGS_NET['optimizer'] = tf.train.AdamOptimizer # could also be tf.train.GradientDescentOptimizer
#FLAGS_NET['optimizer'] = tf.train.GradientDescentOptimizer
FLAGS_NET['get_gradients'] = False
FLAGS_NET['results_name_suffix'] = '_no_dropout'


def conv2d(x, W):
    """conv2d returns a 2d convolution layer with full stride."""
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME')


def max_pool_2x2(x):
    """max_pool_2x2 downsamples a feature map by 2X."""
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                                                strides=[1, 2, 2, 1], padding='SAME')


def weight_variable(shape):
    """weight_variable generates a weight variable of a given shape."""
    initial = tf.truncated_normal(shape, stddev=0.1)
    return tf.Variable(initial)


def bias_variable(shape):
    """bias_variable generates a bias variable of a given shape."""
    initial = tf.constant(0.1, shape=shape)
    return tf.Variable(initial)


def main(_):
    # Import data
    print("here")
    mnist = input_data.read_data_sets(FLAGS.data_dir, one_hot=True)
    print("there")
    # Create the model
    x = tf.placeholder(tf.float32, [None, 784]) # 784=28*28

    # Define loss and optimizer
    y_ = tf.placeholder(tf.float32, [None, 10])

    # Build the graph for the deep net

    # Reshape to use within a convolutional neural net.
    # Last dimension is for "features" - there is only one here, since images are
    # grayscale -- it would be 3 for an RGB image, 4 for RGBA, etc.
    x_image = tf.reshape(x, [-1, 28, 28, 1])

    # First convolutional layer - maps one grayscale image to 32 feature maps.
    W_conv1 = weight_variable([5, 5, 1, 32])
    # each kernel has spatial resolution od (5x5), inputs tensor has 1 channel
    # train 32 convolutional kernels
    b_conv1 = bias_variable([32])
    h_conv1 = tf.nn.relu(conv2d(x_image, W_conv1) + b_conv1)

    # Pooling layer - downsamples by 2X.
    h_pool1 = max_pool_2x2(h_conv1)

    # Second convolutional layer -- maps 32 feature maps to 64.
    W_conv2 = weight_variable([5, 5, 32, 64])
    b_conv2 = bias_variable([64])
    h_conv2 = tf.nn.relu(conv2d(h_pool1, W_conv2) + b_conv2)

    # Second pooling layer.
    h_pool2 = max_pool_2x2(h_conv2)

    # Fully connected layer 1 -- after 2 round of downsampling, our 28x28 image
    # is down to 7x7x64 feature maps -- maps this to 1024 features.
    W_fc1 = weight_variable([7 * 7 * 64, 1024])
    b_fc1 = bias_variable([1024])

    h_pool2_flat = tf.reshape(h_pool2, [-1, 7 * 7 * 64])
    h_fc1 = tf.nn.relu(tf.matmul(h_pool2_flat, W_fc1) + b_fc1)

    # Dropout - controls the complexity of the model, prevents co-adaptation of
    # features.
    keep_prob = tf.placeholder(tf.float32)
    h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)

    # Map the 1024 features to 10 classes, one for each digit
    W_fc2 = weight_variable([1024, 10])
    b_fc2 = bias_variable([10])

    y_conv = tf.matmul(h_fc1_drop, W_fc2) + b_fc2


    # Neccessities for training process. Defining loss.
    cross_entropy = tf.reduce_mean(
            tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y_conv))
    # And now an operation that will compute the gradients for all the weights
    # to minimize the loss cross_entropy.
    optimizer = FLAGS_NET['optimizer'](learning_rate=FLAGS_NET['optimizer_lr'])

    train_step = optimizer.minimize(cross_entropy)
    if FLAGS_NET['get_gradients']:
        # Computer gradients for all the variables
        var_grads = optimizer.compute_gradients(cross_entropy, var_list=[W_fc1])
    # Only for results monitoring
    correct_prediction = tf.equal(tf.argmax(y_conv, 1), tf.argmax(y_, 1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

    with tf.Session() as sess:
        sess.run(tf.global_variables_initializer())
        train_acc_all = []
        train_loss_all = []
        test_acc_all = []
        test_loss_all = []
        if FLAGS_NET['get_gradients']:
            grads_vars_all = []
        for i in tqdm(range(20000)):
            batch = mnist.train.next_batch(32)

            # Here we will compute the variance of the gradients for all the variables
            if FLAGS_NET['get_gradients']:
                batch = mnist.train.next_batch(32)

            if i % 100 == 0:
                indices_train = np.random.choice(np.arange(len(mnist.train.labels)), 5000, replace=True)
                train_acc_, train_loss_ = sess.run([accuracy, cross_entropy],
                    feed_dict={
                        x: mnist.train.images[indices_train],
                        y_: mnist.train.labels[indices_train],
                        keep_prob: 1.0})
                indices_test = np.random.choice(np.arange(len(mnist.test.labels)), 5000, replace=True)
                test_acc_, test_loss_ = sess.run([accuracy, cross_entropy],
                    feed_dict={
                        x: mnist.test.images[indices_test],
                        y_: mnist.test.labels[indices_test],
                        keep_prob: 1.0})

                train_acc_all.append(train_acc_)
                train_loss_all.append(train_loss_)
                test_acc_all.append(test_acc_)
                test_loss_all.append(test_loss_)
                print('step %d, train acc=%.4f, train loss=%.4f, test acc=%.4f, test loss=%.4f, ' % \
                      (i, train_acc_, train_loss_, test_acc_, test_loss_))

                # Save tuple of arrays to a file
                np.savez('results_baseline_'+
                         FLAGS_NET['optimizer'].__name__+
                         '_lr='+str(FLAGS_NET['optimizer_lr']) +
                         str(FLAGS_NET['results_name_suffix']),
                         train_acc=np.array(train_acc_all),
                         train_loss=np.array(train_loss_all),
                         test_acc=np.array(test_acc_all),
                         test_loss=np.array(test_loss_all)
                         )

                # Here we will compute the variance of the gradients for all the variables
                if FLAGS_NET['get_gradients']:
                    gradients_ = sess.run(var_grads[0][1],
                                          feed_dict={
                                              x: mnist.train.images[:1000],
                                              y_: mnist.train.labels[:1000],
                                              keep_prob: 1.0})
                    train_step.run(feed_dict={x: batch[0], y_: batch[1], keep_prob: 0.5})
                    gradients_new_ = sess.run(var_grads[0][1],
                                              feed_dict={
                                              x: mnist.train.images[:1000],
                                              y_: mnist.train.labels[:1000],
                                              keep_prob: 1.0})
                    grads_vars_all.append(np.linalg.norm(gradients_new_-gradients_))

                    # Save tuple of arrays to a file
                    np.savez('results_baseline_'+
                             FLAGS_NET['optimizer'].__name__+
                             '_lr='+
                             str(FLAGS_NET['optimizer_lr'])+'_grads_vars'+
                             str(FLAGS_NET['results_name_suffix']),
                             grads_vars=np.array(train_acc_all),
                             )



            train_step.run(feed_dict={x: batch[0], y_: batch[1], keep_prob: 1.0})


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--data_dir', type=str,
                                            default='./MNIST_data',
                                            help='Directory for storing input data')
    FLAGS, unparsed = parser.parse_known_args()
    tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)

