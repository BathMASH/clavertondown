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
  clavertondown::html_clav:
    toc: true
    fig_caption: true
    keep_md: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
  clavertondown::epub_clav:
    toc: true
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
---
# Here is a figure



![Figure 1.1: Something else to do with cars](Notes_files/figure-html/cars-plot-1.png)

# Here is the putting of a figure inside another built in environment

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-1"></span>Example 2.1  </strong></span><div>Here is an example.

![Figure 2.1: Something to do with cars](Notes_files/figure-html/cars-plot-1.png)

This is a test. So, you need an empty line before and after the above for it to be a float. At the end of an environment this means that you need TWO empty lines. This is Pandoc.
</div></div>\EndKnitrBlock{example}

# Here is the putting of a figure inside a newtheorem

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" ><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>An example

![Figure 3.1: Something to do with cars](Notes_files/figure-html/cars-plot-1.png)

</div></div>\EndKnitrBlock{Example}


<!--chapter:end:index.Rmd-->

