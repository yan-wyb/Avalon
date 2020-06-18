---
layout: post
author: Yan 
toc: true
image: assets/images/prog-lang/python/python-logo.jpg
title: python调用C接口
tags:
categories: [python, c]
top-first: true
top-twice: true
first-level-classification: prog-lang
twice-level-classification: python
permalink: /:year/:month/:day/:title:output_ext
---

python主要通过`ctype`与C语言进行接口对接,这里是常用的对接方法

## 数据类型对照表

![python ctypes]({{ site.baseurl }}/assets/images/prog-lang/python/python-ctypes.png)

## 加载链接库

python调用C的函数,绝大多数情况都是调用的链接库文件里面的函数接口

```python
from ctypes import *
c_so = CDLL('/path/to/c.so')
```

通过CDLL函数就能解析so库,返回相应的库对象,调用里面的函数接口时,
```python
c_so.func(arg1, arg2, ...)
```

## 结构体

在python中是没有结构体概念的,所以唯一的方法就是设计一个相应的类,在调用时去对应结构体的结构体成员.

新建一个`class`,声明为`Structure`,结构如下

```python
class class_name(Structure):
    _fields_ = [
    ]
```

示例:

```python
class image(Structure):
        _fields_ = [
                ('data',c_char_p),
                ('pixel_format',c_int),
                ('width',c_int),
                ('height',c_int),
                ('channel',c_int)
        ]
```

对应的结构体

```c
typedef struct input_image {
  unsigned char *data;            ///<picture data ptr value
  det_pixel_format pixel_format;  ///< color format
  int width;                      ///< width value of pixel
  int height;                     ///< height value of pixel
  int channel;                    ///< stride or channel for picture
} input_image_t;
```

## 枚举

```python
class class_name(Enum):
    cytpes_enum0 = 0
    ctypes_enum1
    ...
```

示例:

```python
class det_pixel_format(Enum):
        PIX_FMT_GRAY8 = 0
        PIX_FMT_YUV420P = 1
        PIX_FMT_NV12 = 2
        PIX_FMT_NV21 = 3
        PIX_FMT_BGRA8888 = 4
        PIX_FMT_BGR888 = 5
        PIX_FMT_RGBA8888 = 6
        PIX_FMT_RGB888 = 7
```

对应的C的枚举

```c
typedef enum {
  ///< Y 1 8bpp(Single channel 8bit gray pixels )
  PIX_FMT_GRAY8,
  ///< YUV  4:2:0 12bpp ( 3 channels, one brightness channel, the othe
  /// two for the U component and V component channel, all channels are continuous)
  PIX_FMT_YUV420P,
  ///< YUV  4:2:0 12bpp ( 2 channels, one channel is a continuous
  /// luminance
  /// channel, and the other channel is interleaved as a UV component )
  PIX_FMT_NV12,
  ///< YUV  4:2:0       12bpp ( 2 channels, one channel is a continuous
  /// luminance
  /// channel, and the other channel is interleaved as a UV component )
  PIX_FMT_NV21,
  ///< BGRA 8:8:8:8     32bpp ( 4-channel 32bit BGRA pixels )
  PIX_FMT_BGRA8888,
  ///< BGR  8:8:8       24bpp ( 3-channel 24bit BGR pixels )
  PIX_FMT_BGR888,
  ///< RGBA 8:8:8：8    32bpp ( 4-channel 32bit RGBA pixels )
  PIX_FMT_RGBA8888,
  ///< RGB  8:8:8       24bpp ( 3-channel 24bit RGB pixels )
  PIX_FMT_RGB888
} det_pixel_format;
```

## 函数接口对接

1.获取对应的函数接口 

```python
c_so = CDLL('/path/to/c.so')
get_c_func = c_so.c_func
```

2.设置参数类型

```python
get_c_func.argtypes = [c_types ...]
```

3.调用,参数传入时转换类型

```python
get_c_func(c_types(arg1) ...)
```

示例:

```python
def get_model_size(self, det_type, width,height,channel):
            det_get_model_size = self.detect_so.det_get_model_size    /*This is step1*/
            det_get_model_size.argtypes = [c_int,POINTER(c_int),POINTER(c_int),POINTER(c_int)] /*This is step2*/
            GET_MODEL_SIZE_STATUS = det_get_model_size(c_int(det_type),
                            pointer(width),pointer(height),pointer(channel))   /*This is step3*/
            if GET_MODEL_SIZE_STATUS :
                    sys.exit('get model size fail !')
            return width,height,channel
```

对应的C函数

```c
det_status_t det_get_model_size(det_model_type modelType, int *width, int *height, int *channel)
{
    LOGP("Enter, modeltype:%d", modelType);

    int ret = DET_STATUS_OK;
    p_det_network_t net = &network[modelType];
    if (!net->status) {
        LOGE("Model has not created! modeltype:%d", modelType);
        _SET_STATUS_(ret, DET_STATUS_ERROR, exit);
    }

    net->process.model_getsize(width, height, channel);
exit:
    LOGP("Leave, modeltype:%d", modelType);
    return ret;
}
```

## 示例源码

Git地址: [https://github.com/yan-wyb/source/tree/master/python/ctypes](https://github.com/yan-wyb/source/tree/master/python/ctypes)

## 官方手册

官方手册 : [https://docs.python.org/3/library/ctypes.html](https://docs.python.org/3/library/ctypes.html)
