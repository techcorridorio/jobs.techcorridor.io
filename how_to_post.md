---
layout: default
title: How to Post
permalink: /posting/how-to
---

### How Do I Feature a Position or Organization?

Featured positions and organizations show up on the front page.

<a class="btn btn-default" href="/feature/new">Feature your post</a>

### How Do I Post?

There are currently 2 ways to post.  (This job board is still a bit of an experiment for us.  We plan to make the process easier if there's sufficient interest.)

#### Request Assistance

You can request help with posting, but please be aware that this is a volunteer-run site.  When requesting assistance, please include all relevant organization/position details in your email.

<a class="mailto btn btn-default" data-email="am9ic0B0ZWNoY29ycmlkb3IuaW8=">Send us an email</a>

#### Pull Request _(Preferred)_

This entire website is open source and pull requests to add posts are welcome!  If you have the skills to make a pull request, that's all that is necessary to get your post published.  There is currently no database; the posts are simply a set of Markdown files.  It's pretty straightforward after seeing some examples.

<a href="{{ site.github_url }}/new/master/_organizations/_?filename=my_organization.md" class="btn btn-primary">
  Post an organization
</a>

Here's an example organization ([see more]({{ site.github_url }}/tree/master/_organizations)):

    ---
    title: Example
    website_url: http://www.example.com/
    positions_url: https://www.example.com/
    location: Iowa City, IA
    technologies:
    - HTML5
    - JavaScript
    ---

    A blurb about the organization goes here.
    
<a href="{{ site.github_url }}/new/master/_positions/_?filename=my_position.md" class="btn btn-primary">
  Post a position
</a>

Here's an example position ([see more]({{ site.github_url }}/tree/master/_positions)):

    ---
    source_url: http://example.com/jobs/12345.html
    type: Full Time
    title: Software Developer
    company: Example
    company_url: http://www.example.com/
    location: Iowa City, IA
    ---

    The text of your job description goes here.  It can contain **Markdown** or <b>HTML</b> markup.

      * This is an example of a bulleted list in Markdown.
      * It looks about like what you'd expect in a plain-text email.
      * This is the last bullet point.

    This is the final paragraph in this job posting.


<script>
  (function () {
    var i, links, link, email;

    links = document.getElementsByClassName('mailto');

    for (i = 0; i < links.length; i++) {
      link = links[i];
      email = atob(link.getAttribute('data-email'));
      link.setAttribute('href', 'mailto:' + email);
    }
  }());
</script>
