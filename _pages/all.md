---
layout: page
title: Time is always silent and it takes time for flowers to bloom . Must be patient . 
permalink: /all/index.html
first-level-classification: [linux,embedded,algorithm,prog-lang,ai,miscellaneous,message]
---

<!-- Posts Index
================================================== -->
<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/linux/index.html"><span>Linux</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[0] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>

<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/embedded/index.html"><span>Embedded</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[1] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>

<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/algorithm/index.html"><span>Algorithm</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[2] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>

<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/prog-lang/index.html"><span>Prog-lang</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[3] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>

<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/ai/index.html"><span>AI</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[4] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>

<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/miscellaneous/index.html"><span>Miscellaneous</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[5] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>

<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/message/index.html"><span>Message</span></a></h2>

 </div>

  <div class="row listrecent">

   {% assign posts=site.posts | where:"first-level-classification",page.first-level-classification[6] %}
   {% for post in posts reversed %}
    {% if post.top-first == true %}

    {% include postbox.html %}

    {% endif %}

   {% endfor %}

  </div>

</section>
<!-- Pagination
================================================== -->
<!-- <div class="bottompagination">
<div class="pointerup"><i class="fa fa-caret-up"></i></div>
<span class="navigation" role="navigation">
    {% include pagination.html %}
</span>
</div>-->

