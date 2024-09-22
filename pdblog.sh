#! /usr/bin/env sh

# === begin config ===

SITE_URL="https://pdblog.org"
SITE_AUTHOR="pdblog project"
SITE_TITLE="pdblog"
SITE_SUBTITLE="An aggressively simple static site generator"
SITE_DESCRIPTION="pdblog, an aggressively simple site generator"
SITE_FOOTER='<a href="https://github.com/GordStephen/pdblog">pdblog on GitHub</a> | <a href="https://github.com/GordStephen/pdblog/issues">Open an issue</a>'

POST_FORMAT="markdown"
POST_EXTENSION=".md"

POSTS_DIR="posts"
ASSETS_DIR="assets"
THEME_DIR="theme"
OUT_DIR="out"

# === end config ===

html_header_template="$THEME_DIR"/header.html
html_footer_template="$THEME_DIR"/footer.html
html_post_template="$THEME_DIR"/post.html
html_error_template="$THEME_DIR"/404.html

atom_header_template="$THEME_DIR"/header.xml
atom_footer_template="$THEME_DIR"/footer.xml
atom_entry_template="$THEME_DIR"/entry.xml

highlight_file="$THEME_DIR"/highlighting.theme

expand_template() {
    pandoc --template="$1" \
           --metadata title="$SITE_DESCRIPTION" \
           --metadata author="$SITE_AUTHOR" \
           --variable siteurl="$SITE_URL" \
           --variable sitetitle="$SITE_TITLE" \
           --variable sitesubtitle="$SITE_SUBTITLE" \
           --variable sitefooter="$SITE_FOOTER" \
           --variable now="$(date -Iseconds)" \
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
           --variable url="$3" \
           -f "$POST_FORMAT" -t html "$4"
}

if [ -d "$OUT_DIR" ]; then
    echo "Destination directory $OUT_DIR already exists, removing..."
    rm -r "$OUT_DIR"
fi

# Process files to HTML

mkdir -p "$OUT_DIR"
homepage="$OUT_DIR"/index.html
errorpage="$OUT_DIR"/404.html
feed="$OUT_DIR"/atom.xml

echo "Generating $errorpage..."
expand_template "$html_error_template" > "$errorpage"

echo "Generating $homepage..."
expand_template "$html_header_template" > "$homepage"
printf '\n<main>\n  <ol class="posts">\n' >> "$homepage"

echo "Generating $feed..."
expand_template "$atom_header_template" > "$feed"

# [0-9]\{8\} doesn't seem to work, for some reason
post_regex='[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*'$POST_EXTENSION

find $POSTS_DIR -name $post_regex | sort -r | while read file; do

    [ -f "$file" ] || continue

    # Extract date and title text
    filename=$(basename "$file" $POST_EXTENSION)
    title=$(echo "$filename" | sed -E 's/^[0-9]{8}-(.*)$/\1/')
    timestamp=$(echo "$filename" | sed -E 's/^([0-9]{8})-.*$/\1/')
    timestamp=$(date -d "$timestamp" '+%Y-%m-%d')

    # Process title text
    slug=$(echo "$title" | tr -dc '[:alnum:][:space:]'  | tr '[:upper:]' '[:lower:]' | tr -s ' -_'  | tr ' _' '-' )
    link=/"$slug"
    url="$SITE_URL"/"$slug"
    page="$OUT_DIR"/"$slug"/index.html

    echo "Processing $file to $page"

    mkdir -p $(dirname "$page")
    html_post "$title" "$timestamp" "$file" > "$page"
    html_entry "$title" "$timestamp" "$link" >> "$homepage"
    atom_entry "$title" "$timestamp" "$url" "$file" >> "$feed"

done

printf '  </ol>\n</main>\n\n' >> "$homepage"
expand_template "$html_footer_template" >> "$homepage"
expand_template "$atom_footer_template" >> "$feed"

# Copy assets and theme includes

for f in $ASSETS_DIR/*; do
    [ -f "$f" ] || [ -d "$f" ] || continue
    echo "Copying $f to $OUT_DIR/"
    cp -r $f $OUT_DIR/
done

for f in $THEME_DIR/includes/*; do
    [ -f "$f" ] || [ -d "$f" ] || continue
    echo "Copying $f to $OUT_DIR/"
    cp -r $f $OUT_DIR/
done
