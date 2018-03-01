---
layout: default
title: How to Post
permalink: /posting/how-to
---

### How Do I Feature a Position or Organization?

Featured positions and organizations show up on the front page.  [Learn more about featuring a post...](/feature/new)

### How Do I Post?

There are currently 2 ways to post.  (This job board is still a bit of an experiment for us.  We plan to make the process easier if there's sufficient interest.)

#### Request Assistance

<a class="mailto" data-email="am9ic0B0ZWNoY29ycmlkb3IuaW8=">Send us an email</a> asking for help posting.  Please include all relevant position/organization details in your email.

#### Pull Request (Preferred)

This entire website is open source and pull requests to add posts are welcome!  If you have the skills to , that's all that is necessary to get your post published.

There is currently no database; the job posts are simply a set of Markdown files.  Your organization should be stored in a new file in `_organizations/*.md`.

The content of the file needs to begin with YAML frontmatter describing the position.  The rest of the file is either Markdown or HTML.  Please limit your HTML to simple formatting only, generally the same subset that Markdown allows.

[Post an organization]({{ site.github_url }}/new/master/_organizations/_?filename=my_organization.md)

Here's an example organization:

    ---
    title: Example
    website_url: http://www.example.com/
    positions_url: https://www.example.com/
    location: Iowa City, IA
    ---

    A blurb about the organization goes here.
    
[Post a position]({{ site.github_url }}/new/master/_positions/_?filename=my_position.md)

Here's an example position:

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
