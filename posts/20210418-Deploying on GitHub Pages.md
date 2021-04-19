This site is (at the time of writing) hosted on GitHub Pages, so if you're
looking to host there as well, it should mostly 'just work'.
The project's git repository includes a `.github` directory with a GitHub
Actions workflow defined to download Pandoc, run pdblog, and then push the
output files to a `gh-pages` branch. So if you fork or 'Use this template' on
the GitHub website and make your desired changes, there's only a few other
steps needed:

 1. Edit the `$ASSETS_DIR/CNAME` file to refer to your own domain (assuming
    you're using a custom domain - if not, you can just delete the file).
    Github Pages needs this file in the root of the branch containing the site
    contents.
 
 2. Enable GitHub Pages in your repository settings, and set it to get site
    contents from the `gh-pages` branch. You'll want to do this _after_ you
    push your site customizations, othewise you'll just end up temporarily
    hosting a copy of this site.

That should be everything. Happy blogging!
