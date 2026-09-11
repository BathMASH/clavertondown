---
title: "Test 005: Put a labeled figure/table inside a theorem/proof etc."
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'August 2020'
site: bookdown::bookdown_site
language: en
documentclass: article
classoption: a4paper
fontsize: 10pt
geometry: margin=2.5cm
output:
  clavertondown::html_clav:
    toc: true
    fig_caption: true
    keep_md: true
  clavertondown::epub_clav:
    toc: true
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
---
# Here is a figure



![(\#fig:cars1)Something else to do with cars](Notes_files/figure-html/cars-plot-1.png "Alternative text")

# Here is the putting of a figure inside another built in environment

\BeginKnitrBlock{example}BEGINSORTNAMEOUTMARKER-ENDSORTNAMEOUTMARKER<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong>(\#exm:unnamed-chunk-1) </strong></span><div>Here is an example.

![(\#fig:cars2)Something to do with cars](Notes_files/figure-html/cars-plot-1.png "Alternative text")

This is a test. So, you need an empty line before and after the above for it to be a float. At the end of an environment this means that you need TWO empty lines. This is Pandoc.
</div></div>\EndKnitrBlock{example}

# Here is the putting of a figure inside a newtheorem

\BeginKnitrBlock{Example}BEGINSORTNAMEOUTMARKER-ENDSORTNAMEOUTMARKER<div class="Example" custom-style="ExampleStyle" id="Example:unnamed-chunk-2"><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>An example

![(\#fig:cars3)Something to do with cars](Notes_files/figure-html/cars-plot-1.png "Alternative text")

</div></div>\EndKnitrBlock{Example}

# Here is when we set width - and everything is different now

![(\#fig:cars4)Something else to do with cars](Notes_files/figure-html/cars-plot-1.png "Alternative text"){width="60%"}

<!--chapter:end:index.Rmd-->

