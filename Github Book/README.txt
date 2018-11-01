Note that when using the "knit" button from the RStudio IDE, only the index is rendered correctly, and all other pages are left blank.

Use instead this from the console, making sure that the working directory is where the index.Rmd file is located:

bookdown::render_book('index.Rmd', 'bookdown::gitbook')