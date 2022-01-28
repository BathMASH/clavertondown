---
title: "Test 007: Better colours in sepia and night mode of gitbook"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'September 2020'
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
    fig_caption: true
    keep_md: true
  clavertondown::epub_clav:
    toc: false
  clavertondown::gitbook_clav:
    split_by: section
    self_contained: no
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    keep_md: true
    fig_caption: true
    toc: true
---

Here is some normal text.

\BeginKnitrBlock{definition}<div class="bookdown-definition" custom-style="DefinitionStyle" id="def:unnamed-chunk-1"><span class="def:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="def:unnamed-chunk-1"></span>Definition 1  </strong></span><div>Definition</div></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyleUpright" id="thm:unnamed-chunk-2"><span class="thm:unnamed-chunk-2" custom-style="NameStyle"><strong><span id="thm:unnamed-chunk-2"></span>Theorem 1  </strong></span><p>Theorem</p></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proof}<div class="bookdown-proof" custom-style="ProofStyle"><span class="proof" custom-style="NameStyle"><strong>Proof. </strong></span> <p>Proof</p><p>&squ;</p></div>\EndKnitrBlock{proof}

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-4"><span class="exm:unnamed-chunk-4" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-4"></span>Example 1  </strong></span><div>Example</div></div>\EndKnitrBlock{example}

<!--chapter:end:index.Rmd-->

