load_config = function() {
  if (length(opts$get('config')) == 0 && file.exists('_bookdown.yml')) {
    # store the book config
    opts$set(config = rmarkdown:::yaml_load_file('_bookdown.yml'))
  }
  opts$get('config')
}

get_base_format = function(format, options = list()) {
  if (is.character(format)) format = eval(parse(text = format))
  if (!is.function(format)) stop('The output format must be a function')
  # make sure named elements in `options` have corresponding named arguments in
  # the format function, unless the function has the ... argument
  nms = names(formals(format))
  if (!('...' %in% nms)) options = options[names(options) %in% c(nms, '')]
  do.call(format, options)
}

clavertondown_file = function(...) {
  system.file(..., package = 'clavertondown', mustWork = TRUE)
}

register_eng_math = function(envs, engine) {
  knitr::knit_engines$set(setNames(lapply(envs, function(env) {
    function(options) {
      options$type = env
      engine(options)
    }
  }), envs))
}

# collapse by \n
# this is stolen from knitr as the below stolen thing needs it this way too
one_string = function(x, ...) paste(x, ..., collapse = '\n')

#Theorem environments in **bookdown** fail to work with Pandoc >= 2.7.3 because of an issue in the `block2` engine of **knitr** (rstudio/bookdown#883).
#Actually, this seems to be a wider problem and so I need to fix it locally by removing reliance on block2
eng_theorem = function(options) {
  if (isFALSE(options$echo)) return()
  
  code = one_string(options$code);
  type = options$type %n% 'theorem'
  if (is.null(type)) return(code)
  label = paste(theorem_abbr[type], options$label, sep = ':')
  html.before2 = sprintf('(\\#%s) ', label)
  name = options$name;
  to_md = output_md()

  if(length(name) == 1) {
    if (to_md) {
      html.before2 = paste(html.before2, sprintf('(%s) ', name))
    } else {
      resolvedname = resolve_name_refs_latex(name)
      options$latex.options = sprintf('[%s]', resolvedname)
      html.before2 = paste(html.before2, sprintf('\\iffalse (%s) \\fi{} ', name))
    }
  }

  l1 = options$latex.options
  if (is.null(l1)) l1 = ''
  # protect environment options because Pandoc may escape the characters like
  # {}; when encoded in integers, they won't be escaped, but will need to
  # restore them later; see bookdown:::restore_block2
  if (l1 != '') l1 = paste(
    c('\\iffalse{', utf8ToInt(enc2utf8(l1)), '}\\fi{}'), collapse = '-'
  )
  h1 = options$html.tag %n% 'div'
  h2 = options$html.tag %n% 'span'
  h3 = options$html.before %n% ''
  h4 = options$html.after %n% ''
  #h5 = options$html.before2 %n% ''
  h6 = options$html.after2 %n% ''
  if (knitr::is_latex_output()) {
    h7 = h8 = '\n'
    s1 = s2 = ''
  } else {
  s1 = '<div>'
  s2 = '</div>'
  if(type == 'definition')
      h7 = sprintf('<%s class="bookdown-%s" custom-style="DefinitionStyle" id="%s">', h1, type, label)
    else if(type == 'example' || type == 'exercise')
      h7 = sprintf('<%s class="bookdown-%s" custom-style="ExampleStyle" id="%s">', h1, type, label)
    else{
      h7 = sprintf('<%s class="bookdown-%s" custom-style="TheoremStyle" id="%s">', h1, type, label)
      #This approach breaks WCAG level 2.1 AA when there is a list inside the theorem
      #s1 = '<p><em>'
      s1 = '<div style="font-style:italic">'
      #s2 = '</em></p>'
      s2 = '</div>'
    }
    h8 = sprintf('</%s>', h1)
  }

  sprintf(
    '\\BeginKnitrBlock{%s}%s%s%s<%s class="%s" custom-style="NameStyle"><strong>%s</strong></%s>%s%s%s%s%s%s\\EndKnitrBlock{%s}',
    type, l1, h3, h7, h2, label, html.before2, h2, s1, code, s2, h6, h8, h4, type
  )
}


#Most of this is stolen from block2 implementation in knitr
#Theorem environments in **bookdown** fail to work with Pandoc >= 2.7.3 because of an issue in the `block2` engine (rstudio/bookdown#883)
eng_newtheorem = function(options) {
  if (isFALSE(options$echo)) return()

  code = one_string(options$code); 
  type = options$type
  env = options$env
  if (is.null(type)) return(code)
  if (is.null(env)) return(code)

  #This is how newtheorem differs from block2
  label = paste(env, options$label, sep = ':')
  # html.before2 = sprintf('%s (\\#%s) ', env, label)
  html.before2 = ''
  latex.unnu = ''
  if (knitr::is_latex_output()) {
     html.before2 = paste(html.before2, sprintf('(\\#%s) ', label))
     if(startsWith(options$label,"unnamed-chunk-"))
        latex.unnu = '*'
  } else {
    if(startsWith(options$label,"unnamed-chunk-"))
	html.before2 = paste(html.before2, sprintf('%s: ', env))
    else
	html.before2 = paste(html.before2, sprintf('%s (\\#%s) ', env, label))
  }

  name = options$name;
  #to_md = output_md()
  l1 = ''
  if (length(name) == 1) {
    if (knitr::is_latex_output()) {
       resolvedname = resolve_name_refs_latex(name)
       #print("HERE")
       #print(resolvedname)
       l1 = sprintf('[%s]', resolvedname)
    } else {
      html.before2 = paste(html.before2, sprintf('(%s) ', name))
    }
  }
  if (l1 != '') l1 = paste(
    c('\\iffalse{', utf8ToInt(enc2utf8(l1)), '}\\fi{}'), collapse = '-'
  )
  #This is going to label the numbered and the unnumbered. At this point we cannot determine the right action so we edit them all out and then in resolve theorems we allow the labels of the numbered theorems to stand (see html.R, of all places, for this function)
  if (knitr::is_latex_output())
     html.before2 = paste('\\iffalse{}', html.before2, '\\fi{}')
   
  h1 = options$html.tag %n% 'div'
  h2 = options$html.tag %n% 'span'
  h3 = options$html.before %n% ''
  h4 = options$html.after %n% ''
  #h5 = options$html.before2 %n% ''
  h6 = options$html.after2 %n% ''

  #Added this because of the issue in the block2 engine of knitr
  if(knitr::is_latex_output()){
    h7 = h8 = '\n'
    s1 = s2 = ''
  }else{
    s1 = '<div>'
    s2 = '</div>'
    if(stringr::str_detect(tolower(env), 'proof') || stringr::str_detect(tolower(env), 'solution') || stringr::str_detect(tolower(env), 'soln') || stringr::str_detect(tolower(env), 'remark'))
      h7 = sprintf('<%s class="%s" custom-style="ProofStyle" id="%s">', h1, env, label)
    else if(stringr::str_detect(tolower(env),'example') || stringr::str_detect(tolower(env), 'exercise'))
      h7 = sprintf('<%s class="%s" custom-style="ExampleStyle" id="%s">', h1, env, label)
    else if(stringr::str_detect(tolower(env), 'definition') || stringr::str_detect(tolower(env), 'defn'))
      h7 = sprintf('<%s class="%s" custom-style="DefinitionStyle" id="%s">', h1, env, label)
    else{
      h7 = sprintf('<%s class="%s" custom-style="TheoremStyle" id="%s">', h1, env, label)
      #This approach breaks WCAG level 2.1 AA when there is a list inside the theorem
      #s1 = '<p><em>'
      s1 = '<div style="font-style:italic">'
      #s2 = '</em></p>'
      s2 = '</div>'
      }
    h8 = sprintf('</%s>', h1)
  }

  if(stringr::str_detect(tolower(env), 'proof'))
    if(knitr::is_latex_output())
      h6 = '\\qed'
    else
      h8 = sprintf('<p>&squ;</p></%s>', h1)

  #We need to change the env name if this is a numbered environment which does not have a label.
  #But. We don't know whether the environment is numbered or not at this point so this has to be done in resolve_new_theorems
  #Which, as noted above, lives in html.R even though that probably is nonsensical.

  sprintf(
    '\\BeginKnitrBlock{%s%s}%s%s%s<%s class="%s" custom-style="NameStyle"><strong>%s</strong></%s>%s%s%s%s%s%s\\EndKnitrBlock{%s%s}',
    env, latex.unnu, l1, h3, h7, h2, env, html.before2, h2, s1, code, s2, h6, h8, h4, env, latex.unnu
  )

#Code before the issue with the block2 engine in knitr
#  sprintf(
#    '\\BeginKnitrBlock{%s}%s%s<%s class="%s"><%s class="%s" id="%s"><strong>%s</strong></%s>%s%s</%s>%s\\EndKnitrBlock{%s}',
#    env, l1, h3, h1, type, h2, env, label, html.before2, h2, code, h6, h1, h4, env
#  )

}

eng_proof = function(options) {
  if (isFALSE(options$echo)) return()
    code = one_string(options$code);
    type = options$type %n% 'proof'
    if(is.null(type)) return(code)
    label = label_prefix(type, label_names_math2)
    html.before2 = sprintf('(\\#%s) ', label)
    name = options$name;
    to_md = output_md()

    if (length(name) == 1) {
       if (!to_md){
          resolvedname = resolve_name_refs_latex(name)
       	  options$latex.options = sprintf('[%s]', sub('[.]\\s*$', '', resolvedname))
	  }else{
	  html.before2 = paste(html.before2, sprintf('(%s) ', name))
	}
       r = '^(.+?)([[:punct:][:space:]]+)$'  # "Remark. " -> "Remark (Name). "
       if (grepl(r, label)) {
       	  label1 = gsub(r, '\\1', label)
       	  label2 = paste0(' (', name, ')', gsub(r, '\\2', label))
       } else {
       	 label1 = label; label2 = ''
       }
       label = sprintf('<em>%s</em>%s', label1, label2)
    } else {
       label = sprintf('<em>%s</em>', label)
    }
    html.before2 = sprintf(
    '<span class="%s" custom-style="NameStyle">%s</span> ', type, label
    )
    if (!to_md)
      html.before2 = paste('\\iffalse{}', html.before2, '\\fi{}')

    l1 = options$latex.options
    if (is.null(l1)) l1 = ''
    # protect environment options because Pandoc may escape the characters like
    # {}; when encoded in integers, they won't be escaped, but will need to
    # restore them later; see bookdown:::restore_block2
    if (l1 != '') l1 = paste(
    c('\\iffalse{', utf8ToInt(enc2utf8(l1)), '}\\fi{}'), collapse = '-'
    )
    h2 = options$html.tag %n% 'div'
    h3 = options$html.before %n% ''
    h4 = options$html.after %n% ''
    #h5 = options$html.before2 %n% ''
    h6 = options$html.after2 %n% ''
    latex.unnu = ''
    if (knitr::is_latex_output()) {
    h7 = h8 = '\n'
    latex.unnu = '*'
    } else {
    #A proof can't have a label so it doesn't need an id. The id that was here was working in html, in, one browser, but not in epub as it was being set to a label that could contain all kinds of things which, unlike eng_theorem's label, is not appropriate
    h7 = sprintf('<%s class="bookdown-%s" custom-style="ProofStyle">', h2, type)
    h8 = sprintf('</%s>', h2)
    }

  if(stringr::str_detect(tolower(type), 'proof'))
    if(knitr::is_latex_output())
      h6 = latex.unnu = ''
    else
      h8 = sprintf('<p>&squ;</p></%s>', h2)

    sprintf(
	'\\BeginKnitrBlock{%s%s}%s%s%s%s<p>%s</p>%s%s%s\\EndKnitrBlock{%s%s}',
    	type, latex.unnu, l1, h3, h7, html.before2, code, h6, h8, h4, type, latex.unnu
  	)
}


# set some internal knitr options
set_opts_knit = function(config) {
  # use labels of the form (\#label) in knitr
  config$knitr$opts_knit$bookdown.internal.label = TRUE
  # when the output is LaTeX, force LaTeX tables instead of default Pandoc tables
  # http://tex.stackexchange.com/q/276699/9128
  config$knitr$opts_knit$kable.force.latex = TRUE
  config
}

pandoc2.0 = function() rmarkdown::pandoc_available('2.0')

output_md = function() getOption('bookdown.output.markdown', FALSE)

`%n%` = knitr:::`%n%`

str_trim = function(x) gsub('^\\s+|\\s+$', '', x)

# manipulate internal options
opts = knitr:::new_defaults(list(config = list()))

# This should _only_ intercept the hardcoded theorem types of bookdown and no other fenced environments
# There is a problem with the fact that you can include engines inside fences but you can't include engines inside engines.
# What should we do in this case?
# Also, you can include any number of fenced divs inside a fenced div so we have to make sure that we find the correct ending.
# Actually, if you include others within then the outer one would need to have more than three : . ALSO, you cannot include
# fenced divs inside engines so we can just ignore this case and document that the user has to deal with this. Because, we cannot. 
# This is annoyingly hard. In that it cannot be done simple substitutions as we need a 'stack'. 
# Either we do it this way by intercepting and leave the actual file unchanged or we change this to a one time transform like
# that in bookdown which goes the other way. The simpler way. Blah. Whichever we decide/can do the same actual code needs to
# exist.
# I believe that this now intercepts, we have to decide how to use it now... 
# The only sensible decision is for the to be something that the user runs once, on each of their input files, inspects the output etc.
# Can we create something which will do this nice and neatly? Store the originals somewhere and reset up the directory ready to go?
# Also, this should be in utils and we should remove all of the remmants of other attempts.
# The main reason that this is the only sensible way is that the two formats ARE NOT interchangeable and presumably someone is moving
# to clavertondown because they want to do something which bookdown does not do. As soon as they do that they can't go back. And, they
# may already have done something in bookdown that cannot be converted to clavertondown because of how clavertondown works. 
intercept_theorems = function(input_dir){

  # Make a new directory bookdownOriginal in input_dir
  # If this already exists then bail and warn
  bookdown_original = paste(input_dir, "/bookdownOriginal",sep='')
  if(file.exists(bookdown_original)){
    stop("Error: You should not run this function multiple times on the same input. Your originals are in bookdownOriginal. Moving, renaming or deleting this directory will enable you to run this function again. We do not recommend deleting the directory.");
  }

  # Copy ALL files including subdirectories, recursively, into bookdownOriginal - preserving a copy
  temp_bookdown_original = paste(tempdir(), "/bookdownOriginal",sep='')
  dir.create(temp_bookdown_original)
  # Copy into a temporary directory first as recursion does not ignore the copy to location
  copying1 = file.copy(input_dir,temp_bookdown_original,overwrite=TRUE,recursive=TRUE,copy.date=TRUE)
  copying2 = file.copy(temp_bookdown_original,input_dir,overwrite=TRUE,recursive=TRUE,copy.date=TRUE)
  # Delete the temporary directory so it isn't hanging around and so that you can run this more than once in a session
  unlink(temp_bookdown_original, recursive = TRUE)

  # Check that copying action did not report any problems, if it did then bail and warn
  if(!(copying1 && copying2))
    stop("Error: Failed to fully copy your originals into a bookdownOriginals subdirectory hence we have abandoned the attempt to rewrite your files. Please look at cause of problem and delete partial copy directory bookdownOriginal before trying again.")

  # For each file.Rmd in the input_dir run the below and overwrite in the same location 
  for(input_file in list.files(input_dir,pattern=".Rmd")){
    input_file_loc = paste(input_dir,input_file,sep='')    
    print(sprintf("-----------Processing file %s-----------",input_file_loc))
    x = read_utf8(input_file_loc)

    # Look for all ::: {, ``` and ::: and store the locations
    m = gregexpr('(::::* \\{|::::*\\{|```|::::*|:::)',x)
    positions = regmatches(x, m)
    matches = list()
    locs = list()
    for (i in seq_along(positions)){
    	if(length(match <- positions[[i]]) == 0) next
    	#This is where the things of interest are
    	matches = c(matches,match)
    	locs = c(locs,i)
    }
    #print(matches)
    # Find those of interest, if there isn't a ``` before the next ::: then convert  
    i = 1
    while(i <= length(matches)){
      #print(matches[[i]])
      #print(x[[locs[[i]]]])
      if(matches[[i]] == ':::{' || matches[[i]] == '::: {'){
        print("Located a fenced div")
      	# If there is a ``` then report a warning and skip on
      	if(matches[[i+1]] == '```'){
          print("Warning: We cannot convert fenced divs which contain knitr engines. You need to deal with this conversion by hand, please see clavertondown documentation or consider sticking with bookdown.")
      	}else{
          # convert this and then convert the next :::
	  # We actually need to CHECK if this is a hardencoded theorem and only replace the end if it is... 
	  if(grepl('.(theorem|lemma|corollary|proposition|conjecture|definition|example|exercise|hypothesis|proof|remark|solution)',x[[locs[[i]]]])){
	    x[[locs[[i]]]] = gsub(sprintf('::: \\{.([[:alnum:]]+)[:blank:]?\\#?'), sprintf('``` \\{\\1 '),x[[locs[[i]]]])
	    x[[locs[[i+1]]]] = gsub(':::','```',x[[locs[[i+1]]]])
	    print("This is a bookdown fenced div theorem it is safe to convert to clavertondown, converting:")
	    print(x[[locs[[i]]]])
	    print(x[[locs[[i+1]]]])
	  }else{
	    print("This is not a hard coded bookdown theorem environment so we do not convert it.")
	    print(x[[locs[[i]]]])
	    print(x[[locs[[i+1]]]])
	  }
      	}
      }else{
        if(matches[[i]] == '::::{' || matches[[i]] == ':::: {'){
          if(grepl('(::::+ \\{.(theorem|lemma|corollary|proposition|conjecture|definition|example|exercise|hypothesis|proof|remark|solution)|::::+\\{.(theorem|lemma|corollary|proposition|conjecture|definition|example|exercise|hypothesis|proof|remark|solution))', x[[locs[[i]]]])){
	    print("Located a fenced div")
            print("Warning: You have a bookdown theorem environment which is defined using :::: or more colons. This suggests that there is a fenced div inside this theorem environment. We cannot convert fenced div theorems which contain fenced divs to knitr engines. You need to deal with this conversion by hand, please see clavertondown documentation or consider sticking with bookdown.");
	  }
      	}
      }
      i = i+1  
    }
  write_utf8(x, input_file_loc)
  }
  # return the text or write to output file
  #if (is.null(output)){
  # print(x)
  #}else{
  # temp = with_ext(output,'.Rmd')   
  #write_utf8(x, temp)
  #}
}