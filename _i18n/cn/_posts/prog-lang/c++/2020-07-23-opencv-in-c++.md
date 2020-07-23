---
layout: post
author: Yan 
toc: true
image: assets/images/prog-lang/c++/opencv-title.png
title: c++上使用opencv
tags:
categories: [c++, opencv]
top-first: true
top-twice: true
first-level-classification: prog-lang
twice-level-classification: c++
permalink: /:year/:month/:day/:title:output_ext
---

# opencv支持的图片格式

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

# 格式转换

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

# 读取图片

## `cv::Mat` imread()

* 函数原型,

```c++
#include<opencv2/opencv.hpp>
Mat cv::imread(const string& filename,int flags=MREAD_COLOR);
```

* 参数 

`const string& filename`: 图片路径

`flags`: 读入方式
```c++
IMREAD_UNCHANGED            = -1, //返回包含alpha通道的加载图像
IMREAD_GRAYSCALE            = 0,  //返回一个灰度图像
IMREAD_COLOR                = 1,  //返回一个BGR通道的图像
IMREAD_ANYDEPTH             = 2,  //当输入具有相应的深度时返回16位/ 32位图像，否则将其转换为8位。.
IMREAD_ANYCOLOR             = 4,  //则以任何可能的颜色格式读取图像。
IMREAD_LOAD_GDAL            = 8,  //使用GDAL的驱动加载图像。
IMREAD_REDUCED_GRAYSCALE_2  = 16, //将图像转换为单通道灰度图像，图像大小减少1/2。
IMREAD_REDUCED_COLOR_2      = 17, //转换图像的3通道BGR彩色图像和图像的大小减少1/2。
IMREAD_REDUCED_GRAYSCALE_4  = 32, //将图像转换为单通道灰度图像，图像大小减少1/4。
IMREAD_REDUCED_COLOR_4      = 33, //转换图像的3通道BGR彩色图像和图像的大小减少1/4。
IMREAD_REDUCED_GRAYSCALE_8  = 64, //将图像转换为单通道灰度图像，图像大小减少1/8。
IMREAD_REDUCED_COLOR_8      = 65, //转换图像的3通道BGR色彩图像和图像大小减少1/8。
IMREAD_IGNORE_ORIENTATION   = 128 //不旋转图像根据EXIF的定位标志。
```

## `IplImage*` cvLoadImage()

* 原型

```c++
#include <opencv2/imgcodecs/imgcodecs_c.h>
IplImage* cvLoadImage( const char* filename, int flags=CV_LOAD_IMAGE_COLOR )
```

* 参数 

`const char* filename`: 图片路径

`flags`: 读入方式
```c++
CV_LOAD_IMAGE_UNCHANGED
CV_LOAD_IMAGE_GRAYSCALE
CV_LOAD_IMAGE_COLOR
CV_LOAD_IMAGE_ANYDEPTH
CV_LOAD_IMAGE_ANYCOLOR
CV_LOAD_IMAGE_IGNORE_ORIENTATION
```

* cvDecodeImageM()

使用`cvDecodeImageM()`函数返回`cv::Mat`格式

# 显示图片

## namedWindow()

* 函数原型

```c++
#include <opencv2/highgui/highgui.hpp>
void cv::namedWindow(const String & winname,int flags = WINDOW_AUTOSIZE)	
```

* 参数

`const String & winname`: 窗口的标识名称

`flag`: 窗口的生成方式
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

* 函数原型

```c++
#include <opencv2/highgui/highgui.hpp>
void imshow(const string& winname,InputArray mat);
```

* 参数

`const string& winname`: 窗口的标识名称

`InputArray mat`: 显示的图片的矩阵数据

# 创建图片cvCreateImage

* 函数原型

```c++
IplImage* cvCreateImage(CvSize cvSize(int width, int height), int depth, int channels);
```
* 参数

`depth`: 图像元素深度值
```c++
IPL_DEPTH_8U - 无符号8位整型
IPL_DEPTH_8S - 有符号8位整型
IPL_DEPTH_16U - 无符号16位整型
IPL_DEPTH_16S - 有符号16位整型
IPL_DEPTH_32S - 有符号32位整型
IPL_DEPTH_32F - 单精度浮点数
IPL_DEPTH_64F - 双精度浮点数
```

`channels`: 通道值,可以是`1,2,3,4`

# 示例源码

* [识别图片,显示识别结果](https://gitlab.com/yan518/aml_npu_app/-/blob/master/detect_library/sample_demo_x11/main.cpp)

* [摄像头识别](https://gitlab.com/yan518/aml_npu_app/-/blob/master/detect_library/yolo_demo_mipi_x11/main.cpp)

# 官方文档

[https://docs.opencv.org/](https://docs.opencv.org/)

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
