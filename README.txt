Note that when using the "knit" button from the RStudio IDE, only the index is rendered correctly, and all other pages are left blank.

Use instead this from the console, making sure that the working directory is where the index.Rmd file is located:

bookdown::render_book('index.Rmd', 'bookdown::gitbook')

TASKS:

--Rename files using this format:

00-word-word-word.Rmd

Note that Bookdown does not like spaces in file names. Also, it is convenient if files are numbered sequentially.

--Within files:

The first heading should use one hashtag with a space between the hashtag and the title! This is because the first heading becomes the title for the chapter when the book is rendered.

# Heading 

Subsequent headings use two, three, etc., hashtags:

## Heading 2