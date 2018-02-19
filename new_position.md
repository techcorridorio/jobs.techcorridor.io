---
layout: default
title: New Position
permalink: /positions/new
redirect_from:
  /new_position.html
---

## Post a Position

Thank you for your interest in posting a position on this site!  We have a growing technology community in Iowa's Technology Corridor and we'd love to help connect you.

_Please understand that this community job board is maintained entirely by volunteers._  We have a vested interest in seeing our tech community grow and thrive, but our time can be limited -- though we'll do our best to review requests quickly.  (Want to lend a hand?  Get in touch in the `#admin` room on our Slack.)

### Rules

We are focused on Iowa's Technology Corridor.  Roughly speaking, this includes areas near I-380 in Iowa.  Remote jobs are welcomed, but only if the company involved _already has **at least one** employee in the area_.  Generally speaking, the positions should be related to **creating** new technology.  For example, software developers, graphic designers, project managers, etc.

### How Do I Feature a Position?

Featured positions show up on the front page.  [Find out more about featuring a position](/featured_positions/new).

### How Do I Post?

There are currently 2 ways to post a position.  (This job board is still a bit of an experiment for us.  We plan to make the process easier if there's sufficient interest.)

#### Request Assistance

<a class="mailto" data-email="am9ic0B0ZWNoY29ycmlkb3IuaW8=">Send us an email</a> asking for help posting your position.  Please include all relevant position details in your email.

#### Pull Request (Preferred)

This entire website is open source and pull requests to add positions are welcome!  If you have the skills to [make an acceptable pull request]({{ site.github_url }}/new/master/_positions/_?filename=my_position.md), that's all that is necessary to get your position published.

There is currently no database; the job posts are simply a set of Markdown files.  Your position should be stored in a new file in `_positions/*.md`.  The filename should be unique.  One good option for choosing a filename is to base it on the URL of your job posting.  For example, `http://example.com/jobs/12345.html` would become `_positions/example_com_jobs_12345.md`.

The content of the file needs to begin with YAML frontmatter describing the position.  The rest of the file is either Markdown or HTML.  Please limit your HTML to simple formatting only, generally the same subset that Markdown allows.

Here's an example:.

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
