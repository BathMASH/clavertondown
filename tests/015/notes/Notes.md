---
title: "Test 015: Put a labeled figure/table inside a theorem/proof etc. but also have maths in the caption"
author: 'Emma Cliffe, Skills Centre: MASH, University of Bath'
date: 'September 2026'
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
  clavertondown::word_clav:
    toc: true
    number_sections: true
    keep_md: true
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
  clavertondown::epub_clav:
    toc: true
---
# Here is a figure



![Figure 1.1: Something else to do with cars 1   $A \times B$](Notes_files/figure-html/cars-plot-1.png "Alternative text")

# Here is a figure with hyphen in the label

Hyphens in figure labels works... 

![Figure 2.1: Something else to do with cars 1-   $A \times B$](Notes_files/figure-html/cars-plot-1.png "Alternative text")

Here I am referencing the first figure <a href="#fig:cars1">1.1</a> and second <a href="#fig:cars-cars">2.1</a>

# Here is the putting of a figure inside another built in environment

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:unnamed-chunk-1"><span class="exm:unnamed-chunk-1" custom-style="NameStyle"><strong><span id="exm:unnamed-chunk-1"></span>Example 3.1  </strong></span><div>Here is an example.

![Figure 3.1: Something to do with cars 2](Notes_files/figure-html/cars-plot-1.png "Alternative text")

This is a test. So, you need an empty line before and after the above for it to be a float. At the end of an environment this means that you need TWO empty lines. This is Pandoc.
</div></div>\EndKnitrBlock{example}

# Here is the putting of a figure inside a newtheorem

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" id="exe:test"><span class="Example" custom-style="NameStyle"><strong> Example 4.1:  </strong></span><div>An example

![Figure 4.1: Something to do with cars 3](Notes_files/figure-html/cars-plot-1.png "Alternative text")

</div></div>\EndKnitrBlock{Example}

Here I reference that theorem <a href="#exe:test">4.1</a>

# Here is when we set width - and everything is different now

![Figure 5.1: Something else to do with cars 4](Notes_files/figure-html/cars-plot-1.png "Alternative text"){width="60%"}

# Where do hyphens break?

They only break in newtheorem, not inbuilt, not figures

\BeginKnitrBlock{example}<div class="bookdown-example" custom-style="ExampleStyle" id="exm:inbuilt-test"><span class="exm:inbuilt-test" custom-style="NameStyle"><strong><span id="exm:inbuilt-test"></span>Example 6.1  </strong></span><div>Here is a final example.</div></div>\EndKnitrBlock{example}

Here I reference that last theorem <a href="#exm:inbuilt-test">6.1</a>

\BeginKnitrBlock{Example}<div class="Example" custom-style="ExampleStyle" id="exe:test-test"><span class="Example" custom-style="NameStyle"><strong> Example 6.2:  </strong></span><div>The broken one.</div></div>\EndKnitrBlock{Example}

Here I reference the broken one <a href="#exe:test-test">6.2</a>

\BeginKnitrBlock{Nugget}<div class="Nugget" custom-style="TheoremStyleUpright" id="nug:nugtest"><span class="Nugget" custom-style="NameStyle"><strong> Nugget 6.1:  </strong></span><p>The good one.</p></div>\EndKnitrBlock{Nugget}

Here I reference the good one <a href="#nug:nugtest">6.1</a>

\BeginKnitrBlock{Nugget}<div class="Nugget" custom-style="TheoremStyleUpright" id="nug:nug-test"><span class="Nugget" custom-style="NameStyle"><strong> Nugget 6.2:  </strong></span><p>The good one bad.</p></div>\EndKnitrBlock{Nugget}

Here I reference the good one bad <a href="#nug:nug-test">6.2</a>

<!--chapter:end:index.Rmd-->

