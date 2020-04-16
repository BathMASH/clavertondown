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

#Most of this is stolen from block2 implementation in knitr
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
  if (knitr::is_latex_output()) {
     html.before2 = paste(html.before2, sprintf('(\\#%s) ', label))
  } else {
     html.before2 = paste(html.before2, sprintf('%s (\\#%s) ', env, label))
  }

  name = options$name; to_md = output_md()
  l1 = ''
  if (length(name) == 1) {
    if (to_md) {
      html.before2 = paste(html.before2, sprintf('(%s) ', name))
    } else {
      l1 = sprintf('[%s]', name)
      html.before2 = paste(html.before2, sprintf('\\iffalse (%s) \\fi{} ', name))
    }
  }
   
  h1 = options$html.tag %n% 'div'
  h2 = options$html.tag %n% 'span'
  h3 = options$html.before %n% ''
  h4 = options$html.after %n% ''
  #h5 = options$html.before2 %n% ''
  h6 = options$html.after2 %n% ''

  sprintf(
    '\\BeginKnitrBlock{%s}%s%s<%s class="%s"><%s class="%s" id="%s"><strong>%s</strong></%s>%s%s</%s>%s\\EndKnitrBlock{%s}',
    env, l1, h3, h1, type, h2, env, label, html.before2, h2, code, h6, h1, h4, env
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