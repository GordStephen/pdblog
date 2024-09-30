Information about the look and feel of the site is stored in `$THEME_DIR`,
which by default is the `theme` directory in the project root.
This directory contains the Pandoc HTML templates for the site:

-------------------- ----------------------------------------------------------
`post.html`          The main template for post pages. It will usually
                     load in `header.html` and `footer.html` as partials.
             
`404.html`           The template for the site's 404 page. It will usually
                     load in `header.html` and `footer.html` as partials. Note
                     that you need to take care of telling your web server to
                     use this file for 404 responses - pdblog can't help you
                     with that.
              
`header.html`        Common HTML for the top of each page. Used to create the
                     index page, and usually the post and 404 pages as well.
                
`footer.html`        Common HTML for the bottom of each page. Used to create
                     the index page, and usually the post and 404 pages as well.
                
`highlighting.theme` [KDE-style](https://docs.kde.org/trunk5/en/kate/katepart/color-themes.html#color-themes-json)
                     syntax highlighting color scheme used by Pandoc 
-------------------- ----------------------------------------------------------

There are templates for generating the site's Atom feed (`header.xml`,
`entry.xml`, and `footer.xml`) in `$THEME_DIR` as well, although these are less
likely to require customization.

Finally, `$THEME_DIR/includes` contains theme-related files (such as CSS or
Javascript) that will be copied directly into the site root.
For example, the default theme includes the file
`$THEME_DIR/includes/style.css` which is copied to `/style.css` in the
resulting web site.
