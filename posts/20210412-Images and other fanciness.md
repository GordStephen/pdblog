Here's a post that contains images! Images and other media are easy to include
in the site. Any files or folders in `$ASSETS_DIR` will be recursively copied
to the site root (`$OUT_DIR`) when running `pdblog.sh`.

For example, the following image was stored in `$ASSETS_DIR/enterprise.jpg`
and so was copied to `/enterprise.jpg` in the resulting site:

![Space Shuttle Enterprise](/enterprise.jpg)

The Pandoc-flavoured Markdown that generated it is:

```
![Space Shuttle Enterprise](/enterprise.jpg)
```

Pandoc will by default create a figure for the image and label it with the
image's alt text. You can disable this by appending a `\` at the end of the
line, for example using

```
![Arches in Utah](/subfolder/arch.jpg)\
```

we get 

![Arches in Utah](/subfolder/arch.jpg)\

That picture was initially saved in `$ASSETS_DIR/subfolder/arch.jpg`, and
so ended up at `/subfolder/arch.jpg`).

Pandoc also provides support for creating HTML tables and syntax highlighting.
Here's a Pandoc-flavoured Markdown table:

```
 Name   Favorite Color   Favorite Fruit
------ ---------------- ----------------
Alice    Blue              Orange
Bob      Yellow            Pear
Eve      Green             Apple
```

and here's the converted HTML version:

 Name   Favorite Color   Favorite Fruit
------ ---------------- ----------------
Alice    Blue              Orange
Bob      Yellow            Pear
Eve      Green             Apple

Finally, here's an excerpt from `pdblog.sh`, with syntax highlighing applied:

```sh
for f in $ASSETS_DIR/*; do
    [ -f "$f" ] || [ -d "$f" ] || continue
    echo "Copying $f to $OUT_DIR/${f##*/}"
    cp -r $f $OUT_DIR/
done

for f in $includes_folder/*; do
    [ -f "$f" ] || [ -d "$f" ] || continue
    echo "Copying $f to $OUT_DIR/${f##*/}"
    cp -r $f $OUT_DIR/
done
```

Generally, if Pandoc can convert something to HTML, it can be used in your blog
(although you may need to augment your theme's CSS to make it look nice). Feel
free to suggest CSS additions to the default theme's style sheet!
