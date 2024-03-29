---
title: "Test 004: New theorems, numbering and styles"
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
    toc: true
    number_sections: true
    keep_md: true
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: true
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::html_clav:
    toc: true
  clavertondown::epub_clav:
    toc: true
---
# Testing some theorem stuff

\BeginKnitrBlock{definition}<div class="bookdown-definition" custom-style="DefinitionStyle" id="def:truth"><span class="def:truth" custom-style="NameStyle"><strong><span id="def:truth"></span>Definition 1.1  </strong></span><div>Here is a definition</div></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-1"></span>Example 1.1  </strong></span><div>Here is an example.</div></div>\EndKnitrBlock{example}

Here is some more boring text in between.

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyleUpright" id="thm:thm1"><span class="thm:thm1" custom-style="NameStyle"><strong><span id="thm:thm1"></span>Theorem 1.1   (Foo) </strong></span><p>Bookdown is needed for things like theorems and internal references</p></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" custom-style="TheoremStyleUpright" id="prp:prp1"><span class="prp:prp1" custom-style="NameStyle"><strong><span id="prp:prp1"></span>Proposition 1.2   (Thingy we need for <a href="#thm:thm1">1.1</a>) </strong></span><p>You can create new theorem types</p></div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Proof}<div class="Proof" custom-style="ProofStyle" ><span class="Proof" custom-style="NameStyle"><strong> Proof:  (Of theorem <a href="#thm:thm1">1.1</a>) </strong></span><div>Here is a proof</div><p>&squ;</p></div>\EndKnitrBlock{Proof}

\BeginKnitrBlock{proof}<div class="bookdown-proof" custom-style="ProofStyle"><span class="proof" custom-style="NameStyle"><strong>Proof (Proof of theorem <a href="#thm:thm1">1.1</a>). </strong></span> <p>Here is a proof</p><p>&squ;</p></div>\EndKnitrBlock{proof}

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" custom-style="TheoremStyleUpright" id="prp:prp2"><span class="prp:prp2" custom-style="NameStyle"><strong><span id="prp:prp2"></span>Proposition 1.3  </strong></span><p>Bookdown is needed for things like theorems and internal references</p></div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Thought}<div class="Thought" custom-style="TheoremStyleUpright" id="tho:tho1"><span class="Thought" custom-style="NameStyle"><strong> Thought 1.1:   (Bar of <a href="#thm:thm1">1.1</a>) </strong></span><p>You can create new theorem types</p></div>\EndKnitrBlock{Thought}

\BeginKnitrBlock{Defns}<div class="Defns" custom-style="DefinitionStyle" ><span class="Defns" custom-style="NameStyle"><strong> Defns: </strong></span><div>You can create new unumbered theorem types</div></div>\EndKnitrBlock{Defns}

\BeginKnitrBlock{Nugget}<div class="Nugget" custom-style="TheoremStyleUpright" id="nug:nug1"><span class="Nugget" custom-style="NameStyle"><strong> Nugget 1.2:  </strong></span><p>You can create new theorem types</p></div>\EndKnitrBlock{Nugget}

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" ><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>An example</div></div>\EndKnitrBlock{Example}

\BeginKnitrBlock{Solution}<div class="Solution" custom-style="ProofStyle" id="sol:sol1"><span class="Solution" custom-style="NameStyle"><strong> Solution 1.1:  </strong></span><div>You can create new theorem types</div></div>\EndKnitrBlock{Solution}

\BeginKnitrBlock{Exercises}<div class="Exercises" custom-style="ExampleStyle" ><span class="Exercises" custom-style="NameStyle"><strong> Exercises: </strong></span><div>Here is a question</div></div>\EndKnitrBlock{Exercises}

\BeginKnitrBlock{solution}<div class="bookdown-solution" custom-style="ProofStyle"><span class="solution" custom-style="NameStyle"><strong>Solution. </strong></span> <p>Test</p></div>\EndKnitrBlock{solution}

# Testing the reference link back

Now go to theorem <a href="#thm:thm1">1.1</a> or thought <a href="#tho:tho1">1.1</a>

\BeginKnitrBlock{solution}<div class="bookdown-solution" custom-style="ProofStyle"><span class="solution" custom-style="NameStyle"><strong>Solution. </strong></span> <p>Test</p></div>\EndKnitrBlock{solution}

\BeginKnitrBlock{definition}<div class="bookdown-definition" custom-style="DefinitionStyle" id="def:truth"><span class="def:truth" custom-style="NameStyle"><strong><span id="def:truth"></span>Definition 1.1  </strong></span><div>Here is a definition</div></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{Thought}<div class="Thought" custom-style="TheoremStyleUpright" id="tho:tho1"><span class="Thought" custom-style="NameStyle"><strong> Thought 1.1:   (Bar of <a href="#thm:thm1">1.1</a>) </strong></span><p>You can create new theorem types</p></div>\EndKnitrBlock{Thought}

Now an actual new thing:
\BeginKnitrBlock{Thought}<div class="Thought" custom-style="TheoremStyleUpright" id="tho:tho2"><span class="Thought" custom-style="NameStyle"><strong> Thought 2.1:  </strong></span><p>Stuff and nonsense</p></div>\EndKnitrBlock{Thought}

<!--chapter:end:index.Rmd-->

