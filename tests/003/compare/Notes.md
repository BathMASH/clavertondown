---
title: "Test 003: Repeat an environment with the correct numbering"
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
  clavertondown::epub_clav:
    toc: true
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::html_clav:
    toc: true
    fig_caption: true
    keep_md: true
---

# Section 1





\BeginKnitrBlock{example}
<span class="exm:inbuilt" custom-style="NameStyle"><strong>(\#exm:inbuilt) </strong></span>2+3
\EndKnitrBlock{example}

\BeginKnitrBlock{Exercise}
<span class="Exercise" custom-style="NameStyle"><strong>\iffalse{}  (\#Exercise:author)  \fi{}</strong></span>4+5
\EndKnitrBlock{Exercise}

\BeginKnitrBlock{example}
<span class="exm:inbuilt" custom-style="NameStyle"><strong>(\#exm:inbuilt) </strong></span>2+3
\EndKnitrBlock{example}

# Section 2

\BeginKnitrBlock{example}
<span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong>(\#exm:unnamed-chunk-1) </strong></span>I should be example 2.1
\EndKnitrBlock{example}

\BeginKnitrBlock{example}
<span class="exm:inbuilt" custom-style="NameStyle"><strong>(\#exm:inbuilt) </strong></span>2+3
\EndKnitrBlock{example}

\BeginKnitrBlock{Exercise}
<span class="Exercise" custom-style="NameStyle"><strong>\iffalse{}  (\#Exercise:author)  \fi{}</strong></span>4+5
\EndKnitrBlock{Exercise}

\BeginKnitrBlock{example}
<span class="exm:unnamed-chunk-2" custom-style="NameStyle"><strong>(\#exm:unnamed-chunk-2) </strong></span>I should be example 2.2
\EndKnitrBlock{example}


\BeginKnitrBlock{Exercise}
<span class="Exercise" custom-style="NameStyle"><strong>\iffalse{}  (\#Exercise:author2)  \fi{}</strong></span>I should be exercise 2.1
\EndKnitrBlock{Exercise}

Conclusion: This worked already everywhere except LaTeX. This is a Bookdown issue. To be fair, there isn't any nice way to do this in LaTeX. I did not want to go down the road of restatable in LaTeX. Instead I wanted to resolve this prior to that point in the way an author would. To do so we change the repeated label to be the ref instead and also ensure that the counter is not incremented. 

<!--chapter:end:index.Rmd-->

