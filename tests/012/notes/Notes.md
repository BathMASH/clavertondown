---
title: "Test 001: Just text"
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
    toc: false
  clavertondown::epub_clav:
    toc: false
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: false
  clavertondown::word_clav:
    toc: false
    number_sections: true
    keep_md: true
---

# Index

This is a minimal example which contains just this sentence.

<!--chapter:end:index.Rmd-->

# Test

This is a test

<!--chapter:end:01-test.Rmd-->

# Test 2

This is the second test

<!--chapter:end:02-test2.Rmd-->

