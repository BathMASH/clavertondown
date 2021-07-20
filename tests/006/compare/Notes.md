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

\BeginKnitrBlock{definition}<div class="bookdown-definition" id="def:unnamed-chunk-1"><span class="def:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="def:unnamed-chunk-1"></span>Definition 1.1  </strong></span><div>A definition</div></div>\EndKnitrBlock{definition}

# Section 2

Some text to show us what the padding does or does not look like
\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:unnamed-chunk-2"><span class="exm:unnamed-chunk-2" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-2"></span>Example 2.1  </strong></span><div>Here is a test</div></div>\EndKnitrBlock{example}
Some text to show us what the padding does or does not look like

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyle" id="thm:unnamed-chunk-3"><span class="thm:unnamed-chunk-3" custom-style="NameStyle"><strong><span id="thm:unnamed-chunk-3"></span>Theorem 2.1  </strong></span><div style="font-style:italic">A theorem</div></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proof}<div class="bookdown-proof" custom-style="ProofStyle">\iffalse{} <span class="proof" custom-style="NameStyle"><em>Proof. </em></span>  \fi{}<p>A proof</p><p>&squ;</p></div>\EndKnitrBlock{proof}

## Section 2.1

\BeginKnitrBlock{Exercises}<div class="Exercises" ><span class="Exercises"><strong> Exercises: </strong></span><div>Some exercises</div></div>\EndKnitrBlock{Exercises}

<!--chapter:end:index.Rmd-->

