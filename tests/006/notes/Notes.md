---
title: "Test 006: Be able to turn colours off"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'August 2020'
site: bookdown::bookdown_site
lang: en
documentclass: article
classoption: a4paper
fontsize: 10pt
geometry: margin=2.5cm
output:
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::epub_clav:
    toc: false
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
---

# Section 1

\BeginKnitrBlock{definition}
<span class="def:unnamed-chunk-1" custom-style="NameStyle"><strong>(\#def:unnamed-chunk-1) </strong></span>A definition
\EndKnitrBlock{definition}

# Section 2

Some text to show us what the padding does or does not look like
\BeginKnitrBlock{example}
<span class="exm:unnamed-chunk-2" custom-style="NameStyle"><strong>(\#exm:unnamed-chunk-2) </strong></span>Here is a test
\EndKnitrBlock{example}
Some text to show us what the padding does or does not look like

\BeginKnitrBlock{theorem}
<span class="thm:unnamed-chunk-3" custom-style="NameStyle"><strong>(\#thm:unnamed-chunk-3) </strong></span>A theorem
\EndKnitrBlock{theorem}

\BeginKnitrBlock{proof}
\iffalse{} <span class="proof" custom-style="NameStyle"><em>Proof. </em></span>  \fi{}<p>A proof</p>
\EndKnitrBlock{proof}

## Section 2.1

\BeginKnitrBlock{Exercises}
<span class="Exercises" custom-style="NameStyle"><strong>\iffalse{}  (\#Exercises:unnamed-chunk-5)  \fi{}</strong></span>Some exercises
\EndKnitrBlock{Exercises}

<!--chapter:end:index.Rmd-->

