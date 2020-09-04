---
title: "Test 003: New theorems, numbering and styles"
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
    toc: true
  clavertondown::epub_clav:
    toc: true
  clavertondown::html_clav:
    toc: true
---
# Testing some theorem stuff

\BeginKnitrBlock{definition}<div class="bookdown-definition" id="def:truth" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: AliceBlue; border-left-style: solid; border-color: CadetBlue; padding-left: 0.5em;"><strong>(\#def:truth) </strong><p>Here is a definition<p></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{example}<div class="bookdown-example" id="exm:unnamed-chunk-1" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><strong>(\#exm:unnamed-chunk-1) </strong><p>Here is an example.<p></div>\EndKnitrBlock{example}

Here is some more boring text in between.

\BeginKnitrBlock{theorem}\iffalse{-91-70-111-111-93-}\fi{}<div class="bookdown-theorem" id="thm:thm1" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><strong>(\#thm:thm1)  \iffalse (Foo) \fi{} </strong><p><em>Bookdown is needed for things like theorems and internal references</em></p></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proposition}\iffalse{-91-84-104-105-110-103-121-32-119-101-32-110-101-101-100-32-102-111-114-32-92-114-101-102-123-116-104-109-58-116-104-109-49-125-93-}\fi{}<div class="bookdown-proposition" id="prp:prp1" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><strong>(\#prp:prp1)  \iffalse (Thingy we need for \@ref(thm:thm1)) \fi{} </strong><p><em>You can create new theorem types</em></p></div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Proof}<div class="Proof" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: seashell; border-left-style: solid; border-color: darkkhaki; padding-left: 0.5em;"><span class="Proof" id="Proof:unnamed-chunk-2"><strong> Proof:  (Of theorem \@ref(thm:thm1)) </strong></span><p>Here is a proof</p><p>&squ;</p></div>\EndKnitrBlock{Proof}

\BeginKnitrBlock{proof}\iffalse{-91-80-114-111-111-102-32-111-102-32-116-104-101-111-114-101-109-32-92-114-101-102-123-116-104-109-58-116-104-109-49-125-93-}\fi{}<div class="bookdown-proof" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: seashell; border-left-style: solid; border-color: darkkhaki; padding-left: 0.5em;">\iffalse{} <span class="proof"><em>Proof</em> (Proof of theorem \@ref(thm:thm1)). </span>  \fi{}<p>Here is a proof</p><p>&squ;</p></div>\EndKnitrBlock{proof}

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" id="prp:prp2" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><strong>(\#prp:prp2) </strong><p><em>Bookdown is needed for things like theorems and internal references</em></p></div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Thought}<div class="Thought" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><span class="Thought" id="Thought:tho1"><strong> Thought (\#Thought:tho1)  (Bar of \@ref(thm:thm1)) </strong></span><p><em>You can create new theorem types</em></p></div>\EndKnitrBlock{Thought}

\BeginKnitrBlock{Defns}<div class="Defns" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: AliceBlue; border-left-style: solid; border-color: CadetBlue; padding-left: 0.5em;"><span class="Defns" id="Defns:unnamed-chunk-4"><strong> Defns: </strong></span><p>You can create new unumbered theorem types</p></div>\EndKnitrBlock{Defns}

\BeginKnitrBlock{Nugget}<div class="Nugget" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><span class="Nugget" id="Nugget:nug1"><strong> Nugget (\#Nugget:nug1) </strong></span><p><em>You can create new theorem types</em></p></div>\EndKnitrBlock{Nugget}

\BeginKnitrBlock{Example}<div class="Example" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><span class="Example" id="Example:unnamed-chunk-5"><strong> Example: </strong></span><p>An example</p></div>\EndKnitrBlock{Example}

\BeginKnitrBlock{Solution}<div class="Solution" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: seashell; border-left-style: solid; border-color: darkkhaki; padding-left: 0.5em;"><span class="Solution" id="Solution:sol1"><strong> Solution (\#Solution:sol1) </strong></span><p>You can create new theorem types</p></div>\EndKnitrBlock{Solution}

\BeginKnitrBlock{Exercises}<div class="Exercises" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: lavenderblush; border-left-style: solid; border-color: mediumorchid; padding-left: 0.5em;"><span class="Exercises" id="Exercises:unnamed-chunk-6"><strong> Exercises: </strong></span><p>Here is a question</p></div>\EndKnitrBlock{Exercises}

\BeginKnitrBlock{solution}<div class="bookdown-solution" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: seashell; border-left-style: solid; border-color: darkkhaki; padding-left: 0.5em;">\iffalse{} <span class="solution"><em>Solution. </em></span>  \fi{}<p>Test</p></div>\EndKnitrBlock{solution}

# Testing the reference link back

Now go to theorem \@ref(thm:thm1) or thought \@ref(tho:tho1)

\BeginKnitrBlock{solution}<div class="bookdown-solution" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: seashell; border-left-style: solid; border-color: darkkhaki; padding-left: 0.5em;">\iffalse{} <span class="solution"><em>Solution. </em></span>  \fi{}<p>Test</p></div>\EndKnitrBlock{solution}

\BeginKnitrBlock{definition}<div class="bookdown-definition" id="def:truth" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: AliceBlue; border-left-style: solid; border-color: CadetBlue; padding-left: 0.5em;"><strong>(\#def:truth) </strong><p>Here is a definition<p></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{Thought}<div class="Thought" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><span class="Thought" id="Thought:tho1"><strong> Thought (\#Thought:tho1)  (Bar of \@ref(thm:thm1)) </strong></span><p><em>You can create new theorem types</em></p></div>\EndKnitrBlock{Thought}

Now an actual new thing:
\BeginKnitrBlock{Thought}<div class="Thought" style="margin-bottom: 1.5em; margin-top:1.5em; background-color: honeydew; border-left-style: solid; border-color: darkseagreen; padding-left: 0.5em;"><span class="Thought" id="Thought:tho2"><strong> Thought (\#Thought:tho2) </strong></span><p><em>Stuff and nonsense</em></p></div>\EndKnitrBlock{Thought}

<!--chapter:end:index.Rmd-->

