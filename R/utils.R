
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
