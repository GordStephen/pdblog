SITE_URL=""
SITE_AUTHOR=""
SITE_TITLE=""
SITE_SUBTITLE=""
SITE_DESCRIPTION=""
SITE_FOOTER=''

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
