---
title: "ClavertonDown Example"
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
    pandoc_args: --default-image-extension=svg
  clavertondown::gitbook_clav:
    split_by: section
    keep_md: true
    config:
      download: [["Notes.html", "HTML page"], ["Notes.pdf","Standard print PDF"], ["NotesClear.pdf","Clear print PDF"], ["NotesLarge.pdf","Large print PDF"], ["Notes.docx","Accessible Word document"], ["Notes.epub","Accessible EPub book" ]]
      sharing: no
    pandoc_args: --default-image-extension=svg
  clavertondown::pdf_clav:
    latex_engine: pdflatex
    keep_tex: true
    fig_caption: true
    toc: true
    extra_dependencies: ["float"]
    pandoc_args: --default-image-extension=pdf
  clavertondown::html_clav:
    toc: true
    pandoc_args: --default-image-extension=svg
  clavertondown::epub_clav:
    toc: false
    pandoc_args: --default-image-extension=svg
header-includes:
  - \newcommand{\BOO}{BOO}
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
* currently, clear print is selected most often by disabled students in the Department of Mathematical Sciences
* PDF remains the best fallback when a student is concerned that a document is not being rendered as the author intended
* PDF remains the best starting point for creating hard copy resources which is important for some disabled students


Finally, our aim here is to produce choice for *all* students, disabled or not, and many will still select PDF. 

## Do I really have to put all this on Moodle?

If you use the same set up as this example document then all the outputs will be collected together into a single folder. We recommend that you:

* Zip up the folder and upload it to Moodle *as a file*
* Select Add a resource -> File. Give the resource a name (e.g. lecture notes 1).
* Add the zip file. Right click on the zip file, a window appears, click on unzip and wait until complete. 
* Right click on the zip again and click on delete. You will have a folder remaining. 
* Left click on the folder to open it. 
* Find the main file index.html and right click on this, 
a window appears, click on Set main file. 
* Change any other settings you wish in the resource and then save. 

When you click on this resource you will see the HTML book version of the notes. This is technically accessible, searchable and usable on a mobile device. In the menu at the top there is a download button, from here a student can access any of the other formats. This is as close as we can get to replicating the Blackboard Ally student experience of being able to transform accessible resources to other formats.

# Theorems and stuff

You will notice that there are a variety of ways that theorem type environments are presented in the different formats. All of these pass technical accessibility tests or are following RNIB Clear Print guidelines and have been used for at least a decade in our provision for disabled students. We have also take on feedback that in HTML formats colour might be helpful to show where environments start and finish. We have chosen to impose a structured colour scheme on you, for now. The colours have been chosen so that they pass accessibility tests for contrast with the text. 

However, this doesn't mean we have got it right. Give us feedback. Ideally, get students to give feedback too. 

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyleUpright" id="thm:thm1"><span class="thm:thm1" custom-style="NameStyle"><strong><span id="thm:thm1"></span>Theorem 2.1   (Foo) </strong></span><p>
This is a theorem environment already provided by Bookdown. It still works as before.
</p></div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" custom-style="TheoremStyleUpright" id="prp:prp1"><span class="prp:prp1" custom-style="NameStyle"><strong><span id="prp:prp1"></span>Proposition 2.2   (Thingy we need for <a href="#thm:thm1">2.1</a>) </strong></span><p>
However, in this system you can now 

* Change the numbering system of the inbuilt environments - this is done in the file _bookdown.yml. Please see the file in the same folder as this file. 
* Reference other environments within names. Notice that you need to use a double backslash.
</p></div>\EndKnitrBlock{proposition}

\BeginKnitrBlock{Proof}<div class="Proof" custom-style="ProofStyle" ><span class="Proof" custom-style="NameStyle"><strong> Proof:  (Of theorem <a href="#thm:thm1">2.1</a>) </strong></span><div>
You can make new unnumbered theorem environments. You can call them whatever you like. They work kind of like the inbuilt ones but the environment is always newtheorem and the env defines the type. 

You need to have predefined the type and made any changes to the standard print style in the file _bookdown.yml. Please see the file in the same folder as this file. 

You can't control what things look like in the other formats as they have been designed with a variety of accessibility features. If you don't like how they look then maybe contact us and ask about it. It might be something we can think about changing or allowing author control or, it might not.
</div><p>&squ;</p></div>\EndKnitrBlock{Proof}

\BeginKnitrBlock{proof}<div class="bookdown-proof" custom-style="ProofStyle"><span class="proof" custom-style="NameStyle"><strong>Proof (Proof of theorem <a href="#thm:thm1">2.1</a>). </strong></span> <p>
Defining your own proof environment doesn't stop the inbuilt one working. 
</p><p>&squ;</p></div>\EndKnitrBlock{proof}

\BeginKnitrBlock{definition}<div class="bookdown-definition" custom-style="DefinitionStyle" id="def:unnamed-chunk-3"><span class="def:unnamed-chunk-3" custom-style="NameStyle"><strong><span id="def:unnamed-chunk-3"></span>Definition 2.1  </strong></span><div>
You can leave some things numbered on their own.
</div></div>\EndKnitrBlock{definition}

\BeginKnitrBlock{Definitions}<div class="Definitions" custom-style="DefinitionStyle" id="Def:def1"><span class="Definitions" custom-style="NameStyle"><strong> Definitions 2.2:  </strong></span><div>
You can create new numbered theorem types. Unlike inbuilt environments, for them to be numbered in all formats they *must* have a label. If you forget then they won't be numbered in any format *except* for PDF and then your numbering won't match. I might try and fix this at some point. You can number them alone or with other inbuilt or newtheorem environments.

You need to have predefined the type, the numbering and made any changes to the standard print style in the file _bookdown.yml. Please see the file in the same folder as this file.

Take care not to reuse the inbuilt numbering labels with your new theorems! This will lead to odd things happening. The inbuilt labels to avoid are: thm, lem, cor, prp, cnj, def, exm, exr, fig, tab and eq. 
</div></div>\EndKnitrBlock{Definitions}

References still work in the same way as in Bookdown. Now go to theorem <a href="#thm:thm1">2.1</a> or proposition <a href="#prp:prp1">2.2</a>.

Here is some text which is not part of the below example.
\BeginKnitrBlock{Examples}<div class="Examples" ><span class="Examples" custom-style="NameStyle"><strong> Examples: </strong></span><div>You can turn off the colour and padding in html, ePub and Word for any newtheorem or inbuilt theorem type. You do this in the _bookdown.yml file by adding the theorem name to the colouroff style_with list.</div></div>\EndKnitrBlock{Examples}
Here is some text which is not part of the above example.

## But I want to number some of them...

\BeginKnitrBlock{Definitions}<div class="Definitions" custom-style="DefinitionStyle" id="Def:unnamed-chunk-5"><span class="Definitions" custom-style="NameStyle"><strong> Definitions: </strong></span><div>This is unnumbered in all formats</div></div>\EndKnitrBlock{Definitions}

\BeginKnitrBlock{Definitions}<div class="Definitions" custom-style="DefinitionStyle" id="Def:def3"><span class="Definitions" custom-style="NameStyle"><strong> Definitions 2.3:  </strong></span><div>This should be definitions 2.3 in all formats</div></div>\EndKnitrBlock{Definitions}

### Out of interest...

What happens if I try to number an environment I have specifically declared to be unnumbered? e.g. using {newtheorem, env='Examples', label="argh"}

This will fail to compile for PDF and it will produce "Examples (#Examples:argh)" as the title in other formats. 

The only real benefit to be gained from specifically declaring an environment to be unnumbered is that you are less likely to accidentally number an instance of it!

## Colour has meaning

The coloured styles for theorem-type environments in HTML, EPub and Word are an attempt to colour code based very broadly on the mathematical type of enviroment. This is to respond to feedback that clear visual markers of the start and end of theorems was important. For accessibility purposes the use of colour can also be used to facilitate cognitive processing and this is stronger if the choice of colour has meaning.   

LaTeX styling, while originally intended to broadly correspond to semantic type is, in our decade or so of experience, not used this way by authors of lecture notes due to the fonts and styling which are imposed in standard LaTeX. So, the three styles in LaTeX:

* Plain
* Definition
* Remark

are used to impose the authors visual preferences mostly with respect to font, font attributes and layout. That is, they are usually syntactic choices, not semantic ones.  

Hence, our assignment is NOT based, at all, on the PDF styling specified by the author, or any other information like e.g. numberwith. 

Since the user can define any number of new theorem type environments we have to... guess... to try and align colours to broad types. We have four HTML styles:

* ProofStyle: (P|p)roof(s), (S|s)olution(s), (S|s)oln(s), (R|r)emark(s) and anything including these words; if not then one of the below
* ExampleStyle: (E|e)xample(s), (E|e)xercise(s) and anything including these words; if not then one of the below
* DefinitionStyle: (D|d)efinition(s), (D|d)efn(s) and anything including these words; if not then defaults to the below
* TheoremStyle: Everything else - but should definitely include (T|t)heorem(s), (L|l)emma(s), (C|c)orollar(y|ies), (P|p)roposition(s), (C|c)onjecture(s). 

You might find this automatic sorting to be wrong or annoying. Also, we can't possibly guess what you might call things so lots of types which aren't theorem-like will end up with the default theorem colouring which isn't helpful. 

This is an accessibility issue - the use of colour to highlight meaning helps with processing so we need to give you control to an extent.  

### So...?

We have given the author direct control over which class of HTML to place each theorem type in - both in built and new theorems. You can override our guesses. We have also given you control to turn off italics in the book HTML (the other accessible formats have this turned off already). 

* To turn off italics change style_with -> italicsoff to TRUE in the _bookdown.yml file (or add this to a file you already have). You don't need to specify this, if you don't, for backwards compatibility, it will default to italicsoff is FALSE
* To classify theorem types you can add, if you wish, a classify_as section to your _bookdown.yml. Again, you don't need to add this if you don't want to change anything. You can see an example of this in the _bookdown.yml file for this document in which the new theorem type Thought is classified as an example. If you remove this classification it will default to the theorem type and the below will change colour.  

\BeginKnitrBlock{Thought}<div class="Thought" custom-style="ExampleStyle" id="Tho:unnamed-chunk-6"><span class="Thought" custom-style="NameStyle"><strong> Thought: </strong></span><p>Here is a thought. </p></div>\EndKnitrBlock{Thought}

# Figures inside other environments

## Here is a figure



![Figure 2.1: This is title and a caption with a reference <a href="#thm:thm1">2.1</a> inside it](./Notes_files/figures/cars-plot-1 "This is the alternative text"){width="60%"}

## Here is the putting of a figure inside another built in environment

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-7"><span class="exm:unnamed-chunk-7" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-7"></span>Example 2.1  </strong></span><div>Here is an example.

![Figure 2.2: Something to do with cars](./Notes_files/figures/cars-plot-1   "Some more meaningful alternative text?"){width="60%"}

This is a test. So, you need an empty line before and after the above for it to be a float. At the end of an environment this means that you need TWO empty lines. This is Pandoc.
</div></div>\EndKnitrBlock{example}

## Here is the putting of a figure inside a newtheorem

Here we are going to do something a bit more impressive with the automatic creation of alternative image formats. This is only useful to you if you are using R to generate graphs etc.





\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" ><span class="Example" custom-style="NameStyle"><strong> Example: </strong></span><div>An example in which we have autogenerated a useful description of the scatterplot for a person who cannot see it, using BrailleR. To see the content of the long description if you view the HTML in Firefox and right click you can request it.

![Figure 2.3: More cars things](./Notes_files/figures/cars-plot-1 "This is a scatterplot with speed on the x-axis and distance on the y-axis, please read the long description for details."){longdesc=./cars.txt width="60%"}

</div></div>\EndKnitrBlock{Example}



# Repeating environments

Sometimes I would like to repeat a definition from earlier and have it numbered the same. This now works as expected in all formats including the numbering of the environment. However, the numbering of *things inside the environment* will probably be wrong so take care. Tell us if this is important to you as it is low priority at the moment. 

Inbuilt using own numbering

\BeginKnitrBlock{theorem}<div class="bookdown-theorem" custom-style="TheoremStyleUpright" id="thm:thm1"><span class="thm:thm1" custom-style="NameStyle"><strong><span id="thm:thm1"></span>Theorem 2.1   (Foo) </strong></span><p>
This is a theorem environment already provided by Bookdown. It still works as before.
</p></div>\EndKnitrBlock{theorem}

Inbuilt using other inbuilt numbering

\BeginKnitrBlock{proposition}<div class="bookdown-proposition" custom-style="TheoremStyleUpright" id="prp:prp1"><span class="prp:prp1" custom-style="NameStyle"><strong><span id="prp:prp1"></span>Proposition 2.2   (Thingy we need for <a href="#thm:thm1">2.1</a>) </strong></span><p>
However, in this system you can now 

* Change the numbering system of the inbuilt environments - this is done in the file _bookdown.yml. Please see the file in the same folder as this file. 
* Reference other environments within names. Notice that you need to use a double backslash.
</p></div>\EndKnitrBlock{proposition}

Newtheorem using other inbuilt numbering

\BeginKnitrBlock{Definitions}<div class="Definitions" custom-style="DefinitionStyle" id="Def:def1"><span class="Definitions" custom-style="NameStyle"><strong> Definitions 2.2:  </strong></span><div>
You can create new numbered theorem types. Unlike inbuilt environments, for them to be numbered in all formats they *must* have a label. If you forget then they won't be numbered in any format *except* for PDF and then your numbering won't match. I might try and fix this at some point. You can number them alone or with other inbuilt or newtheorem environments.

You need to have predefined the type, the numbering and made any changes to the standard print style in the file _bookdown.yml. Please see the file in the same folder as this file.

Take care not to reuse the inbuilt numbering labels with your new theorems! This will lead to odd things happening. The inbuilt labels to avoid are: thm, lem, cor, prp, cnj, def, exm, exr, fig, tab and eq. 
</div></div>\EndKnitrBlock{Definitions}

I still need to test the other combinations. Please tell me if it is broken. 

# But... I want it to do...

We have chosen to create a new package instead of adding to Bookdown because we are diverging from what Bookdown was designed to do. This also means that we can mould how this system works to best meet the needs of students and lecturers. 

Tell us what to do next. We'll tell you if it is possible and the likely priority! 

# LaTeX newcommands, usepackages etc.

You can add these in the header-includes part of the code at the start of this file. You cannot pass a filename to this at the moment. If this is a dealbreaker then let me know. This will work in all formats. *All* other ways of adding commands and packages in will not result in the right thing happening in formats other than PDF, as far as I know.
\[
\BOO(x)
\]

# Great. How do I use this thing?

This package is not on CRAN and it is not going to be in the short or medium term. Instead you need to install it directly from github (if you want to know why then get in touch and ask) which means you will need devtools installed and loaded.  

## Installing ClavertonDown

Once you have devtools you need to load it:

> library(devtools)

Then you can install ClavertonDown:

> install_github("BathMASH/ClavertonDown")

Obviously, you need an internet connection. 

## Using ClavertonDown for the first time

I suggest that you download the files which were used to create this document:

* https://raw.githubusercontent.com/BathMASH/clavertondown/master/example/index.Rmd
* https://raw.githubusercontent.com/BathMASH/clavertondown/master/example/_bookdown.yml

Put them in a folder together, open index.Rmd in RStudio and use the Knit menu to compile the various formats. If this doesn't work then something is wrong (get in touch Bath people!). Then... read the files. 

# Can I tell people not at Claverton Down about this?

Yes, sure, that is why it is public. But, this is released with no promises and no warranty. Help will only be provided to staff and students of the University of Bath but we might fix bugs or consider suggestions by others. 

<!--chapter:end:index.Rmd-->

