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
  clavertondown::word_clav:
    toc: false
    number_sections: true
    keep_md: true
  clavertondown::epub_clav:
    toc: false
  clavertondown::gitbook_clav:
    split_by: section
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
  clavertondown::html_clav:
    toc: false
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    dev: pdf
    keep_tex: true
    fig_caption: false
    toc: false
---

# Problem

The styles in HTML are an attempt to colour code based on the type of enviroment. Since the user can define any number of these we have to... guess... to try and align colours. We have four HTML styles:

* DefinitionStyle
* ExampleStyle
* TheoremStyle
* ProofStyle


Our assignment is NOT currently based, at all, on the PDF styling specified by the author, or any other information like e.g. numberwith. LaTeX styling, while originally intended to broadly correspond to semantic type is not used this way by authors due to the fonts which are imposed in standard LaTeX. So, the three styles in LaTeX:

* Plain
* Definition
* Remark

are used to impose the authors visual preferences mostly with respect to font, font attributes and layout. 


# There are two different issues here

* Case 1 (HTML output): Author makes a newtheorem and it defaults to TheoremStyle but might not be a theorem. Author has styled the newtheorem in LaTeX. 
Try: To use numberwith information e.g. if a new environment is numbered with definitions AND has fallen through the best guessing assign style of what it is numbered with 
Try: Failing the above, where a style_with is specified try Definition styling -> DefinitionStyle; remark styling -> ExampleStyle; plain styling -> TheoremStyle


* Case 2 (PDF output): Author makes a newtheorem and I make a best guess at the HTML styling. Author has not styled the newtheorem in LaTeX.
Try: DefinitionStyle -> the style of definition environment (either inbuilt or as reassigned by user); ExampleStyle -> the style of example environment (either inbuilt or as reassigned by user); TheoremStyle -> the style of theorem env (ditto); ProofStyle -> remark (I think that proof style is hard-coded?)



<!--chapter:end:index.Rmd-->
