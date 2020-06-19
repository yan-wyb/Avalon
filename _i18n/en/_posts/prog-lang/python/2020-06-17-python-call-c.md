---
layout: post
author: Yan 
toc: true
image: assets/images/prog-lang/python/python-logo.jpg
title: Python calls the C interface
tags:
categories: [python, c]
top-first: true
top-twice: true
first-level-classification: prog-lang
twice-level-classification: python
permalink: /:year/:month/:day/:title:output_ext
---

Python mainly uses `ctype` to interface with C language, here is the commonly used docking method.

# Data type comparison table

![python ctypes]({{ site.baseurl }}/assets/images/prog-lang/python/python-ctypes.png)

## Load link library

Python calls C functions, most of the cases are function interfaces in the called link library file.

```python
from ctypes import *
c_so = CDLL('/path/to/c.so')
```

The C library can parse the so library, return the corresponding library object, and call the function interface inside,
    
```python
c_so.func(arg1, arg2, ...)
```

# Structure

There is no concept of a structure in Python, so the only way is to design a corresponding class to correspond to the structure member of the structure when it is called.

Create a new `class`, declared as `Structure`, the structure is as follows.

```python
class class_name(Structure):
    _fields_ = [
    ]
```

example:

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

Corresponding structure:

```c
typedef struct input_image {
  unsigned char *data;            ///<picture data ptr value
  det_pixel_format pixel_format;  ///< color format
  int width;                      ///< width value of pixel
  int height;                     ///< height value of pixel
  int channel;                    ///< stride or channel for picture
} input_image_t;
```

# Enum

```python
class class_name(Enum):
    cytpes_enum0 = 0
    ctypes_enum1
    ...
```

example:

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

The corresponding C language enum:

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

# Function interface docking.

1.Get the corresponding function interface 

```python
c_so = CDLL('/path/to/c.so')
get_c_func = c_so.c_func
```

2.Set parameter type

```python
get_c_func.argtypes = [c_types ...]
```

3.When the parameter is called, the type needs to be converted

```python
get_c_func(c_types(arg1) ...)
```

example:

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

Corresponding C function.

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

# source code with example

Github: [https://github.com/yan-wyb/source/tree/master/python/ctypes](https://github.com/yan-wyb/source/tree/master/python/ctypes)

# Official Manual

Official Manual : [https://docs.python.org/3/library/ctypes.html](https://docs.python.org/3/library/ctypes.html)

# issues

If there are doubts or errors, please mention issues --> [Issues](https://github.com/yan-wyb/issues/issues)
