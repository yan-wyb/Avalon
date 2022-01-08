---
layout: post
author: Yan 
toc: true
image:
title: 如何添加google analytics
tags:
categories: [web]
top-first: false
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---

这里记录如何添加google analytics到网站

# 1. 申请google analytics账号

登录`google analytics`网站，并注册账号

# 2. 生成数据流接口

1. 点击设置，找到`Account Settings`, 选择`Data Streams`.

![Account Setting]({{ site.baseurl }}/assets/images/miscellaneous/analytis4.png)

2. 选择`Add Stream`,

![Stream]({{ site.baseurl }}/assets/images/miscellaneous/analytis3.png)

3. 输入网站的地址和名称

![Generate]({{ site.baseurl }}/assets/images/miscellaneous/analytis2.png)


# 3. 添加到网站

在生成的Stream下面，有一个添加到网站的代码

![code]({{ site.baseurl }}/assets/images/miscellaneous/analytis1.png)

将其添加到网站的`head`中即可。以jekyll为例，

1. 在`_includes`目录下新增`google-analytics.html`

```html
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-D6LYD0GPXC"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-D6LYD0GPXC');
</script>
```

2. include到`_include/head.html`中

```html
{% raw %}
{% include google-analytics.html %}
{% endraw %}
```


