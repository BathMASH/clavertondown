---
title: "Test 011: Unnumbered theorems work"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'October 2021'
site: bookdown::bookdown_site
lang: en
documentclass: article
classoption: a4paper
fontsize: 10pt
geometry: margin=2.5cm
output:
  clavertondown::word_clav:
    toc: false
    number_sections: true
    keep_md: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: false
  clavertondown::html_clav:
    toc: false
  clavertondown::epub_clav:
    toc: false
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
---

Reported bug is that a document with only unnumbered (declared unnumbered) Examples in fails to compile LaTeX with error that Example* is not defined.

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" ><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>This is a test</div></div>\EndKnitrBlock{Example}

Replicated. What happens if there is any other numbered thing? It works fine. 



What if I don't even use that but it is in the _bookdown file? No, that doesn't work. What if I use a numbered inbuilt (with or without a label)? 



This works fine too. 

So, there is something that happens only if there are numbered envs in use which affects unnumbered envs and which was introduced within the last 54 weeks. 

Problem is obvious - no theorem things are output at all...   

Fixed in obvious place for bug to be. 

<!--chapter:end:index.Rmd-->

