---
title: "Test 008: Numbered equation"
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
    toc: false
    number_sections: true
    keep_md: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: false
  clavertondown::epub_clav:
    toc: false
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::html_clav:
    toc: false
---

Here is a numbered equation:
$$\begin{equation}
x^2
\qquad(1)
\end{equation}$$

<!--chapter:end:index.Rmd-->

