This site is (at the time of writing) hosted on GitHub Pages, so if you're
looking to host there as well, it should mostly 'just work'.
The project's git repository includes a `.github` directory with a GitHub
Actions workflow defined to download Pandoc, run pdblog, and then publish the
output files. So if you fork or 'Use this template' on
the GitHub website and make your desired changes, there's only a few other
steps needed:

 1. Enable GitHub Pages in your repository settings (under "Settings" >
    "Pages"), and set the build and deployment source to GitHub Actions.
    You'll want to do this _after_ you push your site customizations, othewise
    you'll just end up temporarily hosting a copy of this site.

 2. If necessary, configure your custom domain on the same settings page.

That should be everything. Happy blogging!
