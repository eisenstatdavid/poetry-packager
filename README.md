# Poetry Packager

For people who want to write poems in Markdown and submit them to literary magazines.

## Usage

1.  Edit `templates/cover-letter.md` to your liking.

2.  Run `bin/package.sh`. For example,

        $ bin/package.sh example.md sonnet-18.md sonnet-73.md

    This writes `3 Poems.docx` and `cover-letter.txt` to the current directory.
    The styling will be broadly acceptable, but always check the guidelines
    of the magazines you submit to.

## Known Issues

The reference styles are woefully incomplete, limiting the Markdown features that can be used.
