---
title: "Test 009: Aligning styles between PDF and nonPDF"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'August 2020'
site: bookdown::bookdown_site
lang: en
documentclass: article
classoption: a4paper
fontsize: 10pt
geometry: margin=2.5cm
output:
  clavertondown::html_clav:
    toc: false
  clavertondown::epub_clav:
    toc: false
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
    toc: false
  clavertondown::word_clav:
    toc: false
    number_sections: true
    keep_md: true
---

# Problem

The styles in HTML are an attempt to colour code based on the type of enviroment. Since the user can define any number of these we have to... guess... to try and align colours. We have four HTML styles:

* ProofStyle: (P|p)roof(s), (S|s)olution(s), (S|s)oln(s), (R|r)emark(s) and anything including these words; if not then one of the below
* ExampleStyle: (E|e)xample(s), (E|e)xercise(s) and anything including these words; if not then one of the below
* DefinitionStyle: (D|d)efinition(s), (D|d)efn(s) and anything including these words; if not then defaults to the below
* TheoremStyle: Everything else - but should definitely include (T|t)heorem(s), (L|l)emma(s), (C|c)orollar(y|ies), (P|p)roposition(s), (C|c)onjecture(s). 


Our assignment is NOT currently based, at all, on the PDF styling specified by the author, or any other information like e.g. numberwith. LaTeX styling, while originally intended to broadly correspond to semantic type is not used this way by authors due to the fonts which are imposed in standard LaTeX. So, the three styles in LaTeX:

* Plain
* Definition
* Remark

are used to impose the authors visual preferences mostly with respect to font, font attributes and layout. 

# Actual user story

I thought I could give the same appearance to my Notation, Remarks and Sketch Proof environments by styling them all with style_with remark. But, in HTML, Remarks and Sketch Proof are both pink with roman text (which I expected since it matches the Bookdown Remark), whereas my Notation environment is green with italic text (colours judged by eye in sepia mode, but the point is they look different).

* This happened because Remarks and Sketch Proof were recognised and classified but notation wasn't. 
* I can never cover all bases
* The same author does not use plain and definition style to distinguish by type as the styling with italics is not something wanted. 
* It is not the style choice that is important here. It is consistency of styling within style_with classes. It is somewhat ambiguous what is expected here. If the author had also put theorem and proposition into remark style I presume that he would still have expected notation to be the same colour as the remark type envs. The author knows that things styled the same in PDF turn different colours in HTML and thinks it is useful. 

So... I can either:

* Give the author direct control over which class of HTML to place each thing in
* Try to guess what is wanted using additional information provided by style_with (but we know from experience that this is usually syntactic) and/or number_by (likely to be less misleading)
* Try to infer based on text analysis
* Use a combination of the above

The easiest is clearly the first. While I am at it I can give the user control over the use of italics in the HTML. 

## Thoughts

The only requirements we have in the code are:

* Retain backwards compatibility with clavertondown in terms of style_with and colouroff
* Make sure that whatever I do happens BEFORE colouroff is instigated because I am changing the style classification? Actually, WAIT, colouroff should work on the name not on the classification. Check this. Actually, colouroff simply removes the customstyle completely so it doesn't really matter. It will matter when it comes to switching italics off within the customstyles which use them.

# Tests

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyleUpright" id="thm:unnamed-chunk-1"><span class="thm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="thm:unnamed-chunk-1"></span>Theorem 3.1  </strong></span><p>This is an inbuilt theorem.</p></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{remark}<div class="bookdown-remark" custom-style="ProofStyle">\iffalse{} <span class="remark" custom-style="NameStyle"><strong>Remark. </strong></span>  \fi{}<p>This is an inbuilt remark.</p></div>\EndKnitrBlock{remark}

\BeginKnitrBlock{Notation}<div class="Notation" custom-style="ProofStyle" ><span class="Notation" custom-style="NameStyle"><strong> Notation: </strong></span><p>This is notation.</p></div>\EndKnitrBlock{Notation}

\BeginKnitrBlock{Remarks}<div class="Remarks" custom-style="ProofStyle" ><span class="Remarks" custom-style="NameStyle"><strong> Remarks: </strong></span><div>This is remarks.</div></div>\EndKnitrBlock{Remarks}

\BeginKnitrBlock{Sketch Proof}<div class="Sketch Proof" custom-style="ProofStyle" ><span class="Sketch Proof" custom-style="NameStyle"><strong> Sketch Proof: </strong></span><div>This is a sketch proof.</div><p>&squ;</p></div>\EndKnitrBlock{Sketch Proof}


<!--chapter:end:index.Rmd-->

