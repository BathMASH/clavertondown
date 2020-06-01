#' @importFrom xfun in_dir sans_ext with_ext same_path read_utf8 write_utf8
NULL

.onLoad = function(lib, pkg) {
  #For user created theorems we cannot register them by name as in the above
  #The below uses an engine based on block2
  library(bookdown)
  register_eng_math(names(theorem_abbr), eng_theorem)
  register_eng_math('newtheorem', eng_newtheorem)
}
