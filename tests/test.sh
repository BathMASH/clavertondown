#!/bin/bash


echo -n "Doc: "
if diff -r -q -a -X "exclude" ../docs ./docs; then
    echo "UNCHANGED"
fi


echo -n "001: "
if diff -r -q -a -X "exclude" ./001/notes ./001/compare; then
    echo "UNCHANGED"
fi


echo -n "002: "
if diff -r -q -a -X "exclude" ./002/notes ./002/compare; then
    echo "UNCHANGED"
fi


echo -n "003: "
if diff -r -q -a -X "exclude" ./003/notes ./003/compare; then
    echo "UNCHANGED"
fi


echo -n "004: "
if diff -r -q -a -X "exclude" ./004/notes ./004/compare; then
        echo "UNCHANGED"
fi

echo -n "005: "
if diff -r -q -a -X "exclude" ./005/notes ./005/compare; then
        echo "UNCHANGED"
fi


echo -n "006: "
if diff -r -q -a -X "exclude" ./006/notes ./006/compare; then
        echo "UNCHANGED"
fi


echo -n "007: "
if diff -r -q -a -X "exclude" ./007/notes ./007/compare; then
        echo "UNCHANGED"
fi


echo -n "008: "
if diff -r -q -a -X "exclude" ./008/notes ./008/compare; then
        echo "UNCHANGED"
fi


