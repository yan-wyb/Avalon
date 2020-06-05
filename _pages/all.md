---
layout: page
title: Time is always silent and it takes time for flowers to bloom . Must be patient . 
permalink: /all
first-level-classification: [linux,embedded,algorithm,prog-lang,ai,miscellaneous]
---

<!-- Posts Index
================================================== -->
<section class="recent-posts">

 <div class="section-title">

  <h2><a class="nav-link" href="{{ site.baseurl }}/linux/"><span>Linux</span></a></h2>

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

  <h2><a class="nav-link" href="{{ site.baseurl }}/embedded/"><span>Embedded</span></a></h2>

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

  <h2><a class="nav-link" href="{{ site.baseurl }}/algorithm/"><span>Algorithm</span></a></h2>

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

  <h2><a class="nav-link" href="{{ site.baseurl }}/prog-lang/"><span>Prog-lang</span></a></h2>

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

  <h2><a class="nav-link" href="{{ site.baseurl }}/ai/"><span>AI</span></a></h2>

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

  <h2><a class="nav-link" href="{{ site.baseurl }}/miscellaneous/"><span>Miscellaneous</span></a></h2>

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
<!-- Pagination
================================================== -->
<!-- <div class="bottompagination">
<div class="pointerup"><i class="fa fa-caret-up"></i></div>
<span class="navigation" role="navigation">
    {% include pagination.html %}
</span>
</div>-->

