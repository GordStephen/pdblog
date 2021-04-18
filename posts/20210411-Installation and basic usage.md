So, you want to make a pdblog? It's very easy!

# Installing

First, make sure you have pandoc
[installed](https://pandoc.org/installing.html)
and available in your `$PATH`.
Then, the easiest way to get continue is probably to clone the `pdblog`
repository using git:

```sh
git clone https://github.com/GordStephen/pdblog
```

From there you can run `./pdblog.sh` in the repository root to generate
the default site.

# Configuration

The initial lines of the `pdblog.sh` script define some configuration
variables that you will want to change:

-------------------- ----------------------------------------------------------
`SITE_AUTHOR`        Your name. With the default theme, this shows up in the
                     HTML head for every page.

`SITE_URL`           The URL of your site index. Will be used when generating
                     links on the home page

`SITE_TITLE`         The main title of your site. With the default theme,
                     this shows up in large text at the top of every page

`SITE_SUBTITLE`      A subtitle for your site. With the default theme,
                     this shows up below the main title at the top of every
                     page

`SITE_DESCRIPTION`   A few words describing the site. With the default
                     theme, this shows up in the title tag of the HTML head
                     for every page

`SITE_FOOTER`        Additional text about the site. With the default theme,
                     this shows up at the bottom of every page.
-------------------- ----------------------------------------------------------

There are also some variables that you can probably leave as-is, at least
for now:

-------------------- ----------------------------------------------------------
`POSTS_DIR`          The directory containing your posts (e.g. Markdown files).
                     Initially set as `posts`.

`ASSETS_DIR`         The directory containing non-post files (images,
                     documents, etc) to be included in the site. Initially set
                     as `assets`.

`THEME_DIR`          The directory containing the theme information for your
                     site. Initially set as `theme`.

`OUT_DIR`            The directory where the complete generated site should be
                     stored. Initially set as `out`.
-------------------- ----------------------------------------------------------

While these defaults are probably fine for most users, there may come a
point where you want to select different values (for example, to quickly
change between themes, or integrate with a particular hosting service).

# Writing posts

Posts are stored in `$POSTS_DIR`. The file name of a post is in the format
`YYYYMMDD-my post name.md`. There are three components to this naming
convention:

-------------------- ----------------------------------------------------------
`YYYYMMDD`           The publication date to associate with the post. This will                           be displayed and used for sorting in the post listing,
                     and shown at the top of the post itself.

`my post name`       Your post title. Spaces and other special characters are
                     fine to include here, although you may need to quote your
                     filename or escape those characters when referencing the
                     filename in other programs.

`md`                 This is a Markdown file. By default, pdblog only processes
                     post files with this extension, although this is easy to
                     change (pandoc supports many formats).
-------------------- ----------------------------------------------------------
   
Once you've created a file with the appropriate name, go ahead and fill
it in with content! Again, by default pdblog expects your posts to be
pandoc-flavoured Markdown, but it can be adjusted to accept many other file
formats as well.

After you've finished writing your post, run `./pdblog.sh` again to convert the
file and regenerate the index with it included.
