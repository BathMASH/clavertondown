---
title: "Test 005: Repeat an environment with the correct numbering"
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
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::epub_clav:
    toc: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
---

# Section 1





\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:inbuilt" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><strong>(\#exm:inbuilt) </strong><p>2+3<p></div>\EndKnitrBlock{example}

\BeginKnitrBlock{Exercise}<div class="Exercise" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><span class="Exercise" id="Exercise:author"><strong> Exercise (\#Exercise:author) </strong></span><p>4+5</p></div>\EndKnitrBlock{Exercise}

\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:inbuilt" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><strong>(\#exm:inbuilt) </strong><p>2+3<p></div>\EndKnitrBlock{example}

# Section 2

\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:unnamed-chunk-1" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><strong>(\#exm:unnamed-chunk-1) </strong><p>I should be example 2.1<p></div>\EndKnitrBlock{example}

\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:inbuilt" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><strong>(\#exm:inbuilt) </strong><p>2+3<p></div>\EndKnitrBlock{example}

\BeginKnitrBlock{Exercise}<div class="Exercise" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><span class="Exercise" id="Exercise:author"><strong> Exercise (\#Exercise:author) </strong></span><p>4+5</p></div>\EndKnitrBlock{Exercise}

\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:unnamed-chunk-2" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><strong>(\#exm:unnamed-chunk-2) </strong><p>I should be example 2.2<p></div>\EndKnitrBlock{example}


\BeginKnitrBlock{Exercise}<div class="Exercise" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><span class="Exercise" id="Exercise:author2"><strong> Exercise (\#Exercise:author2) </strong></span><p>I should be exercise 2.1</p></div>\EndKnitrBlock{Exercise}

Conclusion: This worked already everywhere except LaTeX. This is a Bookdown issue. To be fair, there isn't any nice way to do this in LaTeX. I did not want to go down the road of restatable in LaTeX. Instead I wanted to resolve this prior to that point in the way an author would. To do so we change the repeated label to be the ref instead and also ensure that the counter is not incremented. 

<!--chapter:end:index.Rmd-->

