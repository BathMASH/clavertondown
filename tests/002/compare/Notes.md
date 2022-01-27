---
title: "Test 002: Sections and text"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'August 2020'
site: bookdown::bookdown_site
language: en
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
  clavertondown::epub_clav:
    toc: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: true
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
---

We can put some text before the first section heading!

# Unnumbered section {-}

This is an unnumbered section.

# Section 1

This is section 1 and now we have a subsection.

## Subsection 1.1

And another one.

## Subsection 1.2

And now an section with a subsection immediately at the start.

# Section 2
## Subsection 2.1

And some final text.

<!--chapter:end:index.Rmd-->

