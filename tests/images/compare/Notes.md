---
title: "Images: using iframe and alternatives for dynamic element including in theorems"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'Sept 2023'
site: bookdown::bookdown_site
language: en
documentclass: article
classoption: a4paper
fontsize: 10pt
geometry: margin=2.5cm
output:
  clavertondown::epub_clav:
    toc: true
    pandoc_args: --default-image-extension=svg
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
    pandoc_args: --default-image-extension=svg
  clavertondown::html_clav:
    toc: true
    fig_caption: true
    keep_md: true
    pandoc_args: --default-image-extension=svg
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
    pandoc_args: --default-image-extension=png
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    pandoc_args: --default-image-extension=svg
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
---

# Here is a figure

<iframe title="DESMOS example graph" src="https://www.desmos.com/calculator/lbcljsazlt?embed" width="700px" height="300px" style="border: 1px solid #ccc" frameborder="0">![[Interactive plot of sine](https://www.desmos.com/calculator/lbcljsazlt)\label{sine}](./sine){width=60% longdesc=https://www.desmos.com/calculator/lbcljsazlt}</iframe>


# Here is the putting of a figure inside another built in environment

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-1"></span>Example 2.1  </strong></span><div>Here is an example.

<iframe title="DESMOS example graph" src="https://www.desmos.com/calculator/lbcljsazlt?embed" width="700px" height="300px" style="border: 1px solid #ccc" frameborder="0">![[Interactive plot of sine](https://www.desmos.com/calculator/lbcljsazlt)\label{sine}](./sine){width=60% longdesc=https://www.desmos.com/calculator/lbcljsazlt}</iframe>

This is some text below. A bug sometimes means this disappears but I cannot replicate in a clean document.
</div></div>\EndKnitrBlock{example}


# Here is the putting of a figure inside a newtheorem

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" ><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>An example

<iframe title="DESMOS example graph" src="https://www.desmos.com/calculator/lbcljsazlt?embed" width="700px" height="300px" style="border: 1px solid #ccc" frameborder="0">![[Interactive plot of sine](https://www.desmos.com/calculator/lbcljsazlt)\label{sine}](./sine){width=60% longdesc=https://www.desmos.com/calculator/lbcljsazlt}</iframe>

This is some text below. A bug sometimes means this disappears but I cannot replicate in a clean document.
</div></div>\EndKnitrBlock{Example}


<!--chapter:end:index.Rmd-->

