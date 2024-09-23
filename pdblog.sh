#! /usr/bin/env sh

SITE_URL="https://pdblog.org"
SITE_AUTHOR="pdblog project"
SITE_TITLE="pdblog"
SITE_SUBTITLE="An aggressively simple static site generator"
SITE_DESCRIPTION="pdblog, an aggressively simple site generator"
SITE_FOOTER='<a href="https://github.com/GordStephen/pdblog">pdblog on GitHub</a> | <a href="https://github.com/GordStephen/pdblog/issues">Open an issue</a> | <a href="/atom.xml">Atom</a>'

POST_FORMAT="markdown"
POST_EXTENSION=".md"

POSTS_DIR="posts"
ASSETS_DIR="assets"
THEME_DIR="theme"
OUT_DIR="out"

html_header_template="$THEME_DIR"/header.html
html_footer_template="$THEME_DIR"/footer.html
html_post_template="$THEME_DIR"/post.html
html_error_template="$THEME_DIR"/404.html
atom_header_template="$THEME_DIR"/header.xml
atom_footer_template="$THEME_DIR"/footer.xml
atom_entry_template="$THEME_DIR"/entry.xml
includes_folder=$THEME_DIR/includes
highlight_file="$THEME_DIR"/highlighting.theme

homepage="$OUT_DIR"/index.html
errorpage="$OUT_DIR"/404.html
feed="$OUT_DIR"/atom.xml

# [0-9]\{8\} doesn't seem to work, for some reason
post_regex='[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*'$POST_EXTENSION
now=$(date -Iseconds)

expand_template() {
    pandoc --template="$1" \
           --metadata title="$SITE_DESCRIPTION" \
           --metadata author="$SITE_AUTHOR" \
           --variable siteurl="$SITE_URL" \
           --variable sitetitle="$SITE_TITLE" \
           --variable sitesubtitle="$SITE_SUBTITLE" \
           --variable sitefooter="$SITE_FOOTER" \
           --variable now="$now" \
           -t html < /dev/null
}

html_entry() {
    humantime=$(date -d "$2" '+%B %-e, %Y')
    printf '    <li>\n      <time datetime="%s">%s</time>\n      <a href="%s">%s</a>\n    </li>\n' "$2" "$humantime" "$3" "$1"
}

html_post() {
    pandoc --template="$html_post_template" \
           --metadata title="$1" \
           --metadata author="$SITE_AUTHOR" \
           --variable titlesuffix="$SITE_DESCRIPTION" \
           --variable sitetitle="$SITE_TITLE" \
           --variable sitesubtitle="$SITE_SUBTITLE" \
           --variable humantime="$(date -d "$2" '+%B %-e, %Y')" \
           --variable machinetime="$2" \
           --variable sitefooter="$SITE_FOOTER" \
           --highlight-style "$highlight_file" \
           --shift-heading-level-by=1 \
           -f "$POST_FORMAT" -t html "$3"
}

atom_entry() {
    pandoc --template="$atom_entry_template" \
           --metadata title="$1" \
           --metadata author="$SITE_AUTHOR" \
           --variable timestamp="$2" \
           --variable url="$SITE_URL""$3" \
           --no-highlight \
           -f "$POST_FORMAT" -t html "$4"
}

echo "Preparing destination directory $OUT_DIR..."
mkdir -p "$OUT_DIR"
find "$OUT_DIR" -mindepth 1 -delete

expand_template "$html_error_template" > "$errorpage"
expand_template "$atom_header_template" > "$feed"
expand_template "$html_header_template" > "$homepage"
printf '\n<main>\n  <ol class="posts">\n' >> "$homepage"

find $POSTS_DIR -name $post_regex -type f | sort -r | while read file; do

    filename=$(basename "$file" $POST_EXTENSION)
    timestamp=$(date -d ${filename%%-*} '+%Y-%m-%d')

    title=${filename#*-}
    slug=$(echo "$title" | tr -dc '[:alnum:][:space:]'  | tr '[:upper:]' '[:lower:]' | tr ' _' '-' | tr -s '-' )
    pagedir="$OUT_DIR/$slug"

    echo "Processing $file..."
    mkdir -p "$pagedir"
    html_post "$title" "$timestamp" "$file" > "$pagedir/index.html"
    html_entry "$title" "$timestamp" "/$slug" >> "$homepage"
    atom_entry "$title" "$timestamp" "/$slug" "$file" >> "$feed"

done

printf '  </ol>\n</main>\n\n' >> "$homepage"
expand_template "$html_footer_template" >> "$homepage"
expand_template "$atom_footer_template" >> "$feed"

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
