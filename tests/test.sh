#!/bin/bash


echo "------------- Docs ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ../docs ./docs; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ../docs ./docs; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ../docs ./docs
fi


echo "------------- 001 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./001/notes ./001/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./001/notes ./001/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./001/notes ./001/compare
fi

echo "------------- 002 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./002/notes ./002/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./002/notes ./002/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./002/notes ./002/compare
fi

echo "------------- 003 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./003/notes ./003/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./003/notes ./003/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./003/notes ./003/compare
fi

echo "------------- 004 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./004/notes ./004/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./004/notes ./004/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./004/notes ./004/compare
fi

echo "------------- 005 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./005/notes ./005/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./005/notes ./005/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./005/notes ./005/compare
fi

echo "------------- 006 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./006/notes ./006/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./006/notes ./006/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./006/notes ./006/compare
fi

echo "------------- 007 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./007/notes ./007/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./007/notes ./007/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./007/notes ./007/compare
fi

echo "------------- 008 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./008/notes ./008/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./008/notes ./008/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./008/notes ./008/compare
fi

echo "------------- 009 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./009/notes ./009/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./009/notes ./009/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./009/notes ./009/compare
fi

echo "------------- 010 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./010/notes ./010/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./010/notes ./010/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
    fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./010/notes ./010/compare
fi

echo "------------- 011 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./011/notes ./011/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./011/notes ./011/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./011/notes ./011/compare
fi

echo "------------- 012 ------------- "
if diff -r -q -a -X "exclude" -I "<script" -I "<meta" ./012/notes ./012/compare; then
    echo "NO IMPORTANT CHANGES"
    if diff -r -q -a -X "exclude" ./012/notes ./012/compare; then
	echo "NO CHANGES TO SCRIPTS OR META"
fi
else
    diff -r -a -X "exclude" -I "<script" -I "<meta" ./012/notes ./012/compare
fi



# echo -n "002: "
# if diff -r -q -a -X "exclude" ./002/notes ./002/compare; then
#     echo "UNCHANGED"
# fi


# echo -n "003: "
# if diff -r -q -a -X "exclude" ./003/notes ./003/compare; then
#     echo "UNCHANGED"
# fi


# echo -n "004: "
# if diff -r -q -a -X "exclude" ./004/notes ./004/compare; then
#         echo "UNCHANGED"
# fi

# echo -n "005: "
# if diff -r -q -a -X "exclude" ./005/notes ./005/compare; then
#         echo "UNCHANGED"
# fi


# echo -n "006: "
# if diff -r -q -a -X "exclude" ./006/notes ./006/compare; then
#         echo "UNCHANGED"
# fi


# echo -n "007: "
# if diff -r -q -a -X "exclude" ./007/notes ./007/compare; then
#         echo "UNCHANGED"
# fi


# echo -n "008: "
# if diff -r -q -a -X "exclude" ./008/notes ./008/compare; then
#         echo "UNCHANGED"
# fi

# echo -n "009: "
# if diff -r -q -a -X "exclude" ./009/notes ./009/compare; then
#         echo "UNCHANGED"
# fi
# echo -n "008: "
# if diff -r -q -a -X "exclude" ./010/notes ./010/compare; then
#         echo "UNCHANGED"
# fi


