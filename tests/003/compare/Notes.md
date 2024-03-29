---
title: "Test 003: Repeat an environment with the correct numbering"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'August 2020'
site: bookdown::bookdown_site
language: en
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
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::epub_clav:
    toc: true
---

# Section 1





\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:inbuilt"><span class="exm:inbuilt" custom-style="NameStyle"><strong><span id="exm:inbuilt"></span>Example 1.1  </strong></span><div>2+3</div></div>\EndKnitrBlock{example}

\BeginKnitrBlock{Exercise}<div class="Exercise" custom-style="ExampleStyle" id="Exe:author"><span class="Exercise" custom-style="NameStyle"><strong> Exercise 1.1:  </strong></span><div>4+5</div></div>\EndKnitrBlock{Exercise}

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:inbuilt"><span class="exm:inbuilt" custom-style="NameStyle"><strong><span id="exm:inbuilt"></span>Example 1.1  </strong></span><div>2+3</div></div>\EndKnitrBlock{example}

# Section 2

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-1"></span>Example 2.1  </strong></span><div>I should be example 2.1</div></div>\EndKnitrBlock{example}

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:inbuilt"><span class="exm:inbuilt" custom-style="NameStyle"><strong><span id="exm:inbuilt"></span>Example 1.1  </strong></span><div>2+3</div></div>\EndKnitrBlock{example}

\BeginKnitrBlock{Exercise}<div class="Exercise" custom-style="ExampleStyle" id="Exe:author"><span class="Exercise" custom-style="NameStyle"><strong> Exercise 1.1:  </strong></span><div>4+5</div></div>\EndKnitrBlock{Exercise}

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-2"><span class="exm:unnamed-chunk-2" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-2"></span>Example 2.2  </strong></span><div>I should be example 2.2</div></div>\EndKnitrBlock{example}


\BeginKnitrBlock{Exercise}<div class="Exercise" custom-style="ExampleStyle" id="Exe:author2"><span class="Exercise" custom-style="NameStyle"><strong> Exercise 2.1:  </strong></span><div>I should be exercise 2.1</div></div>\EndKnitrBlock{Exercise}

Conclusion: This worked already everywhere except LaTeX. This is a Bookdown issue. To be fair, there isn't any nice way to do this in LaTeX. I did not want to go down the road of restatable in LaTeX. Instead I wanted to resolve this prior to that point in the way an author would. To do so we change the repeated label to be the ref instead and also ensure that the counter is not incremented. 

<!--chapter:end:index.Rmd-->

