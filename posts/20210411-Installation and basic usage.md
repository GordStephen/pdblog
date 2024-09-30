So, you want to make a pdblog? It's very easy!

# Installing

First, make sure you have pandoc
[installed](https://pandoc.org/installing.html)
and available in your `$PATH`.
Then, the easiest way to get continue is probably to clone the `pdblog`
repository using git:

```sh
git clone https://github.com/GordStephen/pdblog.git myblog
```

Cloning the repo like this will also let you rebase your site against any
future updates to the base scripts and theme.

By default, the pdblog repo is set up to generate the pdblog.org website.
After you clone the repo, the `posts` directory will
contain the posts for pdblog.org (what you're reading now!).
To check that things are working, you can run the site generation script in the
repository root (`myblog` in the example above) to generate the site:

```sh
cd myblog
./pdblog
```

# Resetting the repo

At this point you'll want to replace the pdblog.org posts and configuration
with your own content. While you can certainly just delete the post files,
change the configuration file as per below, and go from there, if you're going
to be version controlling your site contents
with git, it's cleaner to just reset the git history to before those
site-specific changes were made. This state of the repo is tracked by the
`pdblog` branch, so to reset the active branch of the repo to this state,
and pretend the pdblog.org commits never happened, run:

```sh
git reset --hard pdblog
```

# Configuration

With the slate wiped clean, you're ready to start configuring the site using
the variables defined in `config.sh`. While the defaults for many of these
are probably fine, at a minimum you'll want to set the following variables:

-------------------- ----------------------------------------------------------
`SITE_URL`           The URL of your site index. Will be used when generating
                     links on the home page

`SITE_AUTHOR`        Your name. With the default theme, this shows up in the
                     HTML head for every page, as well as the Atom feed

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
`POSTS_FORMAT`       The Pandoc input format that posts are authored in.
                     Initially set as `markdown`.

`POSTS_EXTENSION`    The file extension to use when finding posts.
                     Initially set as `md`.

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
The configuration file also includes a number of other more advanced settings
that are less likely to need changing.

# Writing posts

Posts are stored in `$POSTS_DIR`. The file name of a post is in the format
`YYYYMMDD-My post name.md`. There are three components to this naming
convention:

-------------------- ----------------------------------------------------------
`YYYYMMDD`           Eight digits giving the publication date to associate with
                     the post. This will be used for sorting in the post
                     listing, and parsed and displayed at the top of the post
                     itself.

`My post name`       Your post title. Spaces and other special characters are
                     fine to include here, although you may need to quote your
                     filename or escape those characters when referencing the
                     filename in other programs.

`md`                 The file extension defined by `POSTS_EXTENSION`.
-------------------- ----------------------------------------------------------

Once you've created a file with the appropriate name, go ahead and fill
it in with content! By default pdblog expects your posts to be
pandoc-flavoured Markdown, but it can be adjusted to accept many other file
formats as well.

After you've finished writing your post, run `./pdblog.sh` again to convert the
file and regenerate the index with it included.
