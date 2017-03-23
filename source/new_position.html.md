## Post a position

Thank you for your interest in posting a position on this site!  We have a growing technology community in Iowa's Technology Corridor and we'd love to help connect you.

Please understand that this community job board is maintained entirely by volunteers.  We have a vested interest in seeing our tech community grow and thrive, but our time can be limited -- though we'll do our best to review requests quickly.  (Want to lend a hand?  Get in touch in the `#admin` room on our Slack.)

### Rules

We are focused on Iowa's Technology Corridor.  Roughly speaking, this includes areas near I-380 in Iowa.  Remote jobs are welcomed, but only if the company involved _already has **at least one** employee in the area_.

Generally speaking, the positions should be related to **creating** new technology.  For example, software developers, graphic designers, project managers, etc.

### Featured Jobs

If you are interested in featuring a job on the front page, please <a class="mailto" data-email="am9ic0B0ZWNoY29ycmlkb3IuaW8=">send us an email</a>.

### Posting

There are currently 2 ways to post a position.  (This job board is still a bit of an experiment for us.  We plan to make the process easier if there's sufficient interest.)

#### Pull Request (Free)

This entire website is open source and pull requests to add positions are welcome!  If you have the skills to [make an acceptable pull request](https://github.com/techcorridorio/jobs.techcorridor.io/new/master/source/positions?filename=my_position.html.md), that's all that is necessary to get your position published.

There is currently no database; the job posts are simply a set of Markdown files.  Your position should be stored in a new file in `source/positions/*.html.md`.  The filename should be unique.  One good option for choosing a filename is to base it on the URL of your job posting.  For example, `http://example.com/jobs/12345.html` would become `source/positions/example_com_jobs_12345.html.md`.

The content of the file needs to begin with YAML frontmatter describing the position.  The rest of the file is either Markdown or HTML.  Please limit your HTML to simple formatting only, generally the same subset that Markdown allows.

Here's an example:.

    ---
    position:
      source_url: http://example.com/jobs/12345.html
      type: Full Time
      title: Software Developer
      company: Example
      company_url: http://www.example.com/
      location: Iowa City, IA
    ---

    The text of your job description goes here.  It can contain **Markdown** or <b>HTML</b> markup.

#### Request assistance

If you don't know what any of the above means, <a class="mailto" data-email="am9ic0B0ZWNoY29ycmlkb3IuaW8=">send us an email</a> asking for help making the above pull request.  Please include all relevant position details.

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
