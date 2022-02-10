#!/bin/bash

for test in */; do

echo "------------------------------------------------------------------------------------ "
echo $test
echo $test
echo "------------------------------------------------------------------------------------ "
if [ $test == "docs/" ]; then
    cd ../example
else
    cd $test
fi
Rscript -e "bookdown::render_book('index.Rmd','clavertondown::gitbook_clav')"
Rscript -e "bookdown::render_book('index.Rmd','clavertondown::html_clav')"
Rscript -e "bookdown::render_book('index.Rmd','clavertondown::pdf_clav')"
Rscript -e "bookdown::render_book('index.Rmd','clavertondown::epub_clav')"
Rscript -e "bookdown::render_book('index.Rmd','clavertondown::word_clav')"
echo $test
if [ $test == "docs/" ]; then
    cd ../tests
    if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ../example/$test ./$test; then
	echo "NO IMPORTANT CHANGES"
	if diff -r -q -a -X "exclude" ../$test ./$test; then
	    echo "NO CHANGES TO SCRIPTS OR META"
	fi
    else
	diff -r -a -X "exclude" -I "<script" -I "<meta" ../$test ./$test
    fi
else
    cd ..
    if diff -r -q -a -X "exclude" -I "<script" -I "<meta" $test/notes $test/compare; then
	echo "NO IMPORTANT CHANGES"
	if diff -r -q -a -X "exclude" $test/notes $test/compare; then
	    echo "NO CHANGES TO SCRIPTS OR META"
	fi
    else
	diff -r -a -X "exclude" -I "<script" -I "<meta" $test/notes $test/compare
    fi
    echo "Do you want to replace the comparison files with the output from the most recent run? y/n"
    read decision
    if [ $decision == "y" ]; then
	rm -r $test/compare
	cp -r $test/notes $test/compare
    fi
fi
echo $test
echo "Do you want to continue? y/n"
read decision
if [ $decision != "y" ]; then
    exit 1
fi

done

