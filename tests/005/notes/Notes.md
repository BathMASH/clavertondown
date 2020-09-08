---
title: "Test 004: Put a labeled figure/table inside a theorem/proof etc."
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'August 2020'
site: bookdown::bookdown_site
lang: en
documentclass: article
classoption: a4paper
fontsize: 10pt
geometry: margin=2.5cm
output:
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::epub_clav:
    toc: true
  clavertondown::html_clav:
    toc: true
    fig_caption: true
    keep_md: true
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
---
# Here is a figure



![(\#fig:cars1)Something else to do with cars](Notes_files/figure-html/cars-plot-1.png)

# Here is the putting of a figure inside another built in environment

\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:unnamed-chunk-1" custom-style="ExampleStyle" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><span class="example" id="exm:unnamed-chunk-1" custom-style="NameStyle"><strong>(\#exm:unnamed-chunk-1) </strong></span><p>Here is an example.

![(\#fig:cars2)Something to do with cars](Notes_files/figure-html/cars-plot-1.png)

This is a test. So, you need an empty line before and after the above for it to be a float. At the end of an environment this means that you need TWO empty lines. This is Pandoc.
</p></div>\EndKnitrBlock{example}

# Here is the putting of a figure inside a newtheorem

\BeginKnitrBlock{Example}<div class="Example" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;" custom-style="ExampleStyle"><span class="Example" id="Example:unnamed-chunk-2" custom-style="NameStyle"><strong> Example: </strong></span><p>An example

![(\#fig:cars3)Something to do with cars](Notes_files/figure-html/cars-plot-1.png)

</p></div>\EndKnitrBlock{Example}


<!--chapter:end:index.Rmd-->

