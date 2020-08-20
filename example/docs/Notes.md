---
title: "ClavertonDown Example"
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
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::epub_clav:
    toc: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: true
---

\newpage
\pagenumbering{arabic}

# Introduction {-}

ClavertonDown is aimed at staff at the University of Bath which is located on Claverton Down. It uses knitr, RMarkdown and Bookdown and aims to produce a system for creating sets of lecture notes in a variety of formats, including those which are technically accessible and those which are often preferred by disabled students. We aim for the system to be usable in both pure and applied mathematical settings. Requests to adapt the system or the outputs of the system to meet these goals will be considered by MASH. The main contact email address is mash-access@bath.ac.uk but you should use the Team set up by the Centre for Learning and Teaching for support in the first instance.  

This document is **also** a work in progress. Like everything right now!

# What formats do I need to produce and why?

ClavertonDown can produce:

* HTML book
* HTML page
* Standard, clear and large print PDF
* Word document
* EPub book

From a technical point of view only three of these formats of mathematical text are accessible:

* HTML using MathJax to render all mathematical text (HTML book and page)
  * HTML formats must meet WCAG 2.1 Level AA requirements and use MathJax to render all mathematical text. 
  * You can check your document meets the legal requirement of WCAG 2.1 Level AA with e.g. [Accessibility Insights for Web plugin for Chrome](https://accessibilityinsights.io/docs/en/web/overview)
  * You can check it is MathJax by right clicking on the expression (try it in the HTML version):
  \[x = \frac{-b\pm\sqrt{b^2 - 4ac}}{2a}\]
* Word document using in-built Equation Editor for all mathematical text
  * Word formats must pass the in-built Accessibility Checker and use the in-built Equation Editor for all mathematical text.
  * You can use the in-built Word Accessibility Checker and information on [Making your Word documents accessible](https://support.office.com/en-gb/article/make-your-word-documents-accessible-to-people-with-disabilities-d9bf3683-87ac-47ea-b91a-78dcacb3c66d) to check your document.
  * You can use Review -> Read Aloud (Alt + Ctrl + Space) to check the maths 
* EPub3 using MathML for all mathematical text:
  * If the HTML format is accessible then the EPub3 output from ClavertonDown will be also

The output from ClavertonDown will meet these requirements as far as possible. However, we cannot stop you from doing things which will fail to meet requirements. In particular, if you use images, sound, videos, colour or interactive/dynamic elements within the HTML you will need to ensure that you have done so within the accessibility requirements. 

## Why do we still supply inaccessible PDFs?

It isn't possible to create accessible PDFs using LaTeX. Even if a PDF is accessible the mathematical text within it will **still be technically inaccessible** regardless of how the PDF has been produced but...

* not all accessibility is about technical access - for some a clear or large print PDF is best
* clear print is selected most often by disabled students in the Department of Mathematical Sciences.

# Testing some theorem stuff

\BeginKnitrBlock{theorem}\iffalse{-91-70-111-111-93-}\fi{}<div class="bookdown-theorem" id="thm:thm1"><strong>(\#thm:thm1)  \iffalse (Foo) \fi{} </strong>Bookdown is needed for things like theorems and internal references</div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proposition}\iffalse{-91-84-104-105-110-103-121-32-119-101-32-110-101-101-100-32-102-111-114-32-92-114-101-102-123-116-104-109-58-116-104-109-49-125-93-}\fi{}<div class="bookdown-proposition" id="prp:prp1"><strong>(\#prp:prp1)  \iffalse (Thingy we need for \@ref(thm:thm1)) \fi{} </strong>You can create new theorem types</div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Proof}<div class="newtheorem"><span class="Proof" id="Proof:unnamed-chunk-1"><strong> Proof:  (Of theorem \@ref(thm:thm1)) </strong></span>Here is a proof</div>\EndKnitrBlock{Proof}

\BeginKnitrBlock{proof}\iffalse{-91-80-114-111-111-102-32-111-102-32-116-104-101-111-114-101-109-32-92-114-101-102-123-116-104-109-58-116-104-109-49-125-93-}\fi{}<div class="bookdown-proof" id="<em>Proof</em> (Proof of theorem \@ref(thm:thm1)). ">\iffalse{} <span class="proof"><em>Proof</em> (Proof of theorem \@ref(thm:thm1)). </span>  \fi{}Here is a proof</div>\EndKnitrBlock{proof}

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" id="prp:prp2"><strong>(\#prp:prp2) </strong>Bookdown is needed for things like theorems and internal references</div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Thought}<div class="newtheorem"><span class="Thought" id="Thought:tho1"><strong> Thought (\#Thought:tho1)  (Bar) </strong></span>You can create new theorem types</div>\EndKnitrBlock{Thought}

\BeginKnitrBlock{Wonder}<div class="newtheorem"><span class="Wonder" id="Wonder:unnamed-chunk-3"><strong> Wonder: </strong></span>You can create new unumbered theorem types</div>\EndKnitrBlock{Wonder}

\BeginKnitrBlock{Nugget}<div class="newtheorem"><span class="Nugget" id="Nugget:nug1"><strong> Nugget (\#Nugget:nug1) </strong></span>You can create new theorem types</div>\EndKnitrBlock{Nugget}

Now go to \@ref(thm:thm1).

\BeginKnitrBlock{Solution}<div class="newtheorem"><span class="Solution" id="Solution:sol1"><strong> Solution (\#Solution:sol1) </strong></span>You can create new theorem types</div>\EndKnitrBlock{Solution}

\BeginKnitrBlock{solution}<div class="bookdown-solution" id="<em>Solution. </em>">\iffalse{} <span class="solution"><em>Solution. </em></span>  \fi{}Test</div>\EndKnitrBlock{solution}

<!--chapter:end:index.Rmd-->

