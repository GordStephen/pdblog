In addition to the HTML site index on the homepage, pdblog now produces an
[Atom feed](https://en.wikipedia.org/wiki/Atom_(Web_standard))
of all your blog content, so visitors can follow your posts from their feed
reader of choice! By default the feed is created at `/atom.xml`, although
this can easily be changed to something else in the variable configuration
section near the top of `pdblog.sh`:

```sh
homepage="$OUT_DIR"/index.html
errorpage="$OUT_DIR"/404.html
feed="$OUT_DIR"/atom.xml # Change this as desired
```

The default template header now includes a `<link>` element that announces
the feed, and a direct link is also provided in the default footer text.
