---
layout: post
author: Yan 
toc: true
image: assets/images/prog-lang/c++/opencv-title.png
title: Use opencv on c++
tags:
categories: [c++, opencv]
top-first: true
top-twice: true
first-level-classification: prog-lang
twice-level-classification: c++
permalink: /:year/:month/:day/:title:output_ext
---

# Picture format supported by opencv

```
Windows bitmaps - *.bmp, *.dib (always supported)
JPEG files - *.jpeg, *.jpg, *.jpe (see the Notes section)
JPEG 2000 files - *.jp2 (see the Notes section)
Portable Network Graphics - *.png (see the Notes section)
WebP - *.webp (see the Notes section)
Portable image format - *.pbm, *.pgm, *.ppm (always supported)
Sun rasters - *.sr, *.ras (always supported)
TIFF files - *.tiff, *.tif (see the Notes section)
```

# Format conversion

## `cv::Mat` --> `IplImage*`

```c++
IplImage* pImg
*pImg = IplImage(MatImg);
```

## `IplImage*` --> `cv::Mat`

```c++
cv::Mat MatImg = cvarrToMat(pImg);
```

```

# Read picture

## `cv::Mat` imread()

* Function prototype,

```c++
#include<opencv2/opencv.hpp>
Mat cv::imread(const string& filename,int flags=MREAD_COLOR);
```

* parameter

`const string& filename`: path to picture

`flags`: Reading method
```c++
IMREAD_UNCHANGED            = -1, //Returns the loaded image containing the alpha channel
IMREAD_GRAYSCALE            = 0,  //Return a grayscale image
IMREAD_COLOR                = 1,  //Return a BGR channel image
IMREAD_ANYDEPTH             = 2,  //Return a 16-bit/32-bit image when the input has the corresponding depth, otherwise convert it to 8-bit.
IMREAD_ANYCOLOR             = 4,  //Read the image in any possible color format.
IMREAD_LOAD_GDAL            = 8,  //Use the GDAL driver to load the image.
IMREAD_REDUCED_GRAYSCALE_2  = 16, //Convert the image to a single-channel grayscale image, the image size is reduced by 1/2.
IMREAD_REDUCED_COLOR_2      = 17, //The converted image is a 3-channel BGR color image and the image size is reduced by 1/2.
IMREAD_REDUCED_GRAYSCALE_4  = 32, //Convert the image to a single-channel grayscale image, the image size is reduced by 1/4.
IMREAD_REDUCED_COLOR_4      = 33, //The converted image is a 3-channel BGR color image and the image size is reduced by 1/4.
IMREAD_REDUCED_GRAYSCALE_8  = 64, //Convert the image to a single-channel grayscale image, the image size is reduced by 1/8.
IMREAD_REDUCED_COLOR_8      = 65, //The converted image is a 3-channel BGR color image and the image size is reduced by 1/8.
IMREAD_IGNORE_ORIENTATION   = 128 //Do not rotate the image according to the EXIF positioning mark.
```

## `IplImage*` cvLoadImage()

* Function prototype

```c++
#include <opencv2/imgcodecs/imgcodecs_c.h>
IplImage* cvLoadImage( const char* filename, int flags=CV_LOAD_IMAGE_COLOR )
```

* parameter

`const char* filename`: path to picture

`flags`: Reading method
```c++
CV_LOAD_IMAGE_UNCHANGED
CV_LOAD_IMAGE_GRAYSCALE
CV_LOAD_IMAGE_COLOR
CV_LOAD_IMAGE_ANYDEPTH
CV_LOAD_IMAGE_ANYCOLOR
CV_LOAD_IMAGE_IGNORE_ORIENTATION
```

* cvDecodeImageM()

Use the `cvDecodeImageM()` function to return the `cv::Mat` format

# show image

## namedWindow()

* Function prototype

```c++
#include <opencv2/highgui/highgui.hpp>
void cv::namedWindow(const String & winname,int flags = WINDOW_AUTOSIZE)	
```

* parameter

`const String & winname`: The identifying name of the window

`flag`: How the window is generated
```c++
CV_WND_PROP_FULLSCREEN 	
CV_WND_PROP_AUTOSIZE 	
CV_WND_PROP_ASPECTRATIO 	
CV_WND_PROP_OPENGL 	
CV_WND_PROP_VISIBLE 	
CV_WINDOW_NORMAL 	
CV_WINDOW_AUTOSIZE 	
CV_WINDOW_OPENGL 	
CV_GUI_EXPANDED 	
CV_GUI_NORMAL 	
CV_WINDOW_FULLSCREEN 	
CV_WINDOW_FREERATIO 	
CV_WINDOW_KEEPRATIO 
```

## imshow()

* Function prototype

```c++
#include <opencv2/highgui/highgui.hpp>
void imshow(const string& winname,InputArray mat);
```

* parameter

`const string& winname`: The identifying name of the window

`InputArray mat`: Matrix data of the displayed picture

# cvCreateImage

* Function prototype

```c++
IplImage* cvCreateImage(CvSize cvSize(int width, int height), int depth, int channels);
```
* parameter

`depth`: Image element depth value
```c++
IPL_DEPTH_8U - Unsigned 8-bit integer
IPL_DEPTH_8S - Signed 8-bit integer
IPL_DEPTH_16U - Unsigned 16-bit integer
IPL_DEPTH_16S - Signed 16-bit integer
IPL_DEPTH_32S - Signed 32-bit integer
IPL_DEPTH_32F - Single precision floating point
IPL_DEPTH_64F - Double precision floating point
```

`channels`: Channel value, can be `1,2,3,4`

# source code as an example

* [Recognize the picture and display the recognition result](https://gitlab.com/yan518/aml_npu_app/-/blob/master/detect_library/sample_demo_x11/main.cpp)

* [Camera recognition](https://gitlab.com/yan518/aml_npu_app/-/blob/master/detect_library/yolo_demo_mipi_x11/main.cpp)

# Official documents

[https://docs.opencv.org/](https://docs.opencv.org/)

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
