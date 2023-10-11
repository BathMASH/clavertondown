---
title: "Test 013: New theorems, numbering and styles with lists immediately inside and a newline present in clear and large"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'September 2022'
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
    fig_caption: false
    toc: true
  clavertondown::html_clav:
    toc: true
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::epub_clav:
    toc: true
header-includes:
  - \usepackage{needspace}
---

# Itemize without theorem


* One
* Two


# Testing some theorem stuff

\BeginKnitrBlock{definition}<div class="bookdown-definition" custom-style="DefinitionStyle" id="def:truth"><span class="def:truth" custom-style="NameStyle"><strong><span id="def:truth"></span>Definition 2.1  </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Here is a definition. </div></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-1"></span>Example 2.1  </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Here is an example.</div></div>\EndKnitrBlock{example}

Here is some more boring text in between.

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyleUpright" id="thm:thm1"><span class="thm:thm1" custom-style="NameStyle"><strong><span id="thm:thm1"></span>Theorem 2.1   (Foo) </strong></span><p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Bookdown is needed for things like theorems and internal references</p></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" custom-style="TheoremStyleUpright" id="prp:prp1"><span class="prp:prp1" custom-style="NameStyle"><strong><span id="prp:prp1"></span>Proposition 2.2   (Thingy we need for <a href="#thm:thm1">2.1</a>) </strong></span><p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

You can create new theorem types</p></div>\EndKnitrBlock{proposition}


\needspace{\baselineskip}

\BeginKnitrBlock{Thought}<div class="Thought" custom-style="TheoremStyleUpright" id="tho:tho1"><span class="Thought" custom-style="NameStyle"><strong> Thought 2.1:   (Bar of <a href="#thm:thm1">2.1</a>) </strong></span><p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

You can create new theorem types</p></div>\EndKnitrBlock{Thought}

\BeginKnitrBlock{Proof}<div class="Proof" custom-style="ProofStyle" ><span class="Proof" custom-style="NameStyle"><strong> Proof:  (Of theorem <a href="#thm:thm1">2.1</a>) </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Here is a proof</div><p>&squ;</p></div>\EndKnitrBlock{Proof}

\BeginKnitrBlock{proof}<div class="bookdown-proof" custom-style="ProofStyle"><span class="proof" custom-style="NameStyle"><strong>Proof (Proof of theorem <a href="#thm:thm1">2.1</a>). </strong></span> <p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Here is a proof</p><p>&squ;</p></div>\EndKnitrBlock{proof}


\BeginKnitrBlock{Defns}<div class="Defns" custom-style="DefinitionStyle" ><span class="Defns" custom-style="NameStyle"><strong> Defns: </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

You can create new unumbered theorem types</div></div>\EndKnitrBlock{Defns}

\BeginKnitrBlock{Nugget}<div class="Nugget" custom-style="TheoremStyleUpright" id="nug:nug1"><span class="Nugget" custom-style="NameStyle"><strong> Nugget 2.2:  </strong></span><p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

You can create new theorem types</p></div>\EndKnitrBlock{Nugget}

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" ><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

An example</div></div>\EndKnitrBlock{Example}

\BeginKnitrBlock{Solution}<div class="Solution" custom-style="ProofStyle" id="sol:sol1"><span class="Solution" custom-style="NameStyle"><strong> Solution 2.1:  </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

You can create new theorem types</div></div>\EndKnitrBlock{Solution}

\BeginKnitrBlock{Exercises}<div class="Exercises" custom-style="ExampleStyle" ><span class="Exercises" custom-style="NameStyle"><strong> Exercises: </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Here is a question</div></div>\EndKnitrBlock{Exercises}

\BeginKnitrBlock{solution}<div class="bookdown-solution" custom-style="ProofStyle"><span class="solution" custom-style="NameStyle"><strong>Solution. </strong></span> <p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Test</p></div>\EndKnitrBlock{solution}

# Testing the reference link back

Now go to theorem <a href="#thm:thm1">2.1</a> or thought <a href="#tho:tho1">2.1</a>

\BeginKnitrBlock{solution}<div class="bookdown-solution" custom-style="ProofStyle"><span class="solution" custom-style="NameStyle"><strong>Solution. </strong></span> <p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Test</p></div>\EndKnitrBlock{solution}

\needspace{3\baselineskip}

\BeginKnitrBlock{definition}<div class="bookdown-definition" custom-style="DefinitionStyle" id="def:truth"><span class="def:truth" custom-style="NameStyle"><strong><span id="def:truth"></span>Definition 2.1  </strong></span><div>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Here is a definition. </div></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{Thought}<div class="Thought" custom-style="TheoremStyleUpright" id="tho:tho1"><span class="Thought" custom-style="NameStyle"><strong> Thought 2.1:   (Bar of <a href="#thm:thm1">2.1</a>) </strong></span><p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

You can create new theorem types</p></div>\EndKnitrBlock{Thought}

Now an actual new thing:
\BeginKnitrBlock{Thought}<div class="Thought" custom-style="TheoremStyleUpright" id="tho:tho2"><span class="Thought" custom-style="NameStyle"><strong> Thought 3.1:  </strong></span><p>
\leavevmode\vspace{-\baselinestretch\parskip}\nobreak

* One
* Two

Stuff and nonsense</p></div>\EndKnitrBlock{Thought}

<!--chapter:end:index.Rmd-->

