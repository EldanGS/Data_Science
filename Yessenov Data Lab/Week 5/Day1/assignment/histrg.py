def histrg(img, bins):

    #define a 2D histogram  with "bins^2" number of entries
    h = np.zeros((bins, bins))

    #execute the loop for each pixel in the image, 
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):

            #increment a histogram bin which corresponds to the value 
            #of pixel i,j; h(r,g)
            R = float(img[i,j,0])
            G = float(img[i,j,1])
            B = float(img[i,j,2])

            r = int(np.floor(R/(R+G+B) * bins))
            g = int(np.floor(G/(R+G+B) * bins))
            
            h[r,g] = h[r,g] + 1


    # normalize the histogram such that its integral (sum) is equal 1
    h = h/np.sum(h)
    h = np.reshape(h, (-1))
    return h
