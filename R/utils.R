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
      h7 = sprintf('<%s class="%s" custom-style="ProofStyle">', h1, env)
    else if(stringr::str_detect(tolower(env),'example') || stringr::str_detect(tolower(env), 'exercise'))
      h7 = sprintf('<%s class="%s" custom-style="ExampleStyle">', h1, env)
    else if(stringr::str_detect(tolower(env), 'definition') || stringr::str_detect(tolower(env), 'defn'))
      h7 = sprintf('<%s class="%s" custom-style="DefinitionStyle">', h1, env)
    else{
      h7 = sprintf('<%s class="%s" custom-style="TheoremStyle">', h1, env)
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
    label = bookdown:::label_prefix(type, label_names_math2)
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
    if (knitr::is_latex_output()) {
    h7 = h8 = '\n'
    } else {
    #A proof can't have a label so it doesn't need an id. The id that was here was working in html, in, one browser, but not in epub as it was being set to a label that could contain all kinds of things which, unlike eng_theorem's label, is not appropriate
    h7 = sprintf('<%s class="bookdown-%s" custom-style="ProofStyle">', h2, type)
    h8 = sprintf('</%s>', h2)
    }

  if(stringr::str_detect(tolower(type), 'proof'))
    if(knitr::is_latex_output())
      h6 = ''
    else
      h8 = sprintf('<p>&squ;</p></%s>', h2)


    sprintf(
	'\\BeginKnitrBlock{%s}%s%s%s%s<p>%s</p>%s%s%s\\EndKnitrBlock{%s}',
    	type, l1, h3, h7, html.before2, code, h6, h8, h4, type
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

