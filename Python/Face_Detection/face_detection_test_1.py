'''
Sources:
http://pythonpath.wordpress.com/2012/05/08/pil-to-opencv-image/
http://www.lucaamore.com/?p=638
'''

#Python 2.7.2
#Opencv 2.4.2
#PIL 1.1.7

import cv
import Image

def DetectFace(image, faceCascade):
    #modified from: http://www.lucaamore.com/?p=638

    min_size = (20,20)
    image_scale = 1
    haar_scale = 1.1
    min_neighbors = 3
    haar_flags = 0

    # Allocate the temporary images
    smallImage = cv.CreateImage(
            (
                cv.Round(image.width / image_scale),
                cv.Round(image.height / image_scale)
            ), 8 ,1)

    # Scale input image for faster processing
    cv.Resize(image, smallImage, cv.CV_INTER_LINEAR)

    # Equalize the histogram
    cv.EqualizeHist(smallImage, smallImage)

    # Detect the faces
    faces = cv.HaarDetectObjects(
            smallImage, faceCascade, cv.CreateMemStorage(0),
            haar_scale, min_neighbors, haar_flags, min_size
        )

    # If faces are found
    if faces:
        for ((x, y, w, h), n) in faces:
            # the input to cv.HaarDetectObjects was resized, so scale the
            # bounding box of each face and convert it to two CvPoints
            pt1 = (int(x * image_scale), int(y * image_scale))
            pt2 = (int((x + w) * image_scale), int((y + h) * image_scale))
            cv.Rectangle(image, pt1, pt2, cv.RGB(255, 0, 0), 5, 8, 0)

    return image

def pil2cvGrey(pil_im):
    #from: http://pythonpath.wordpress.com/2012/05/08/pil-to-opencv-image/
    pil_im = pil_im.convert('L')
    cv_im = cv.CreateImageHeader(pil_im.size, cv.IPL_DEPTH_8U, 1)
    cv.SetData(cv_im, pil_im.tostring(), pil_im.size[0]  )
    return cv_im

def cv2pil(cv_im):
    return Image.fromstring("L", cv.GetSize(cv_im), cv_im.tostring())


pil_im=Image.open('testPics/faces.jpg')
cv_im=pil2cv(pil_im)
#the haarcascade files tells opencv what to look for.
faceCascade = cv.Load('C:/Python27/Lib/site-packages/opencv/haarcascade_frontalface_default.xml')
face=DetectFace(cv_im,faceCascade)
img=cv2pil(face)
img.show()
