pdf_clav = function(
  toc = TRUE, number_sections = TRUE, fig_caption = TRUE, pandoc_args = NULL, ...,
  base_format = rmarkdown::pdf_document, toc_unnumbered = TRUE,
  toc_appendix = FALSE, toc_bib = FALSE, quote_footer = NULL, highlight_bw = FALSE
) {
  config = get_base_format(base_format, list(
    toc = toc, number_sections = number_sections, fig_caption = fig_caption,
    pandoc_args = bookdown:::pandoc_args2(pandoc_args), ...
  ))
  config$pandoc$ext = '.tex'
  post = config$post_processor  # in case a post processor have been defined
  config$post_processor = function(metadata, input, output, clean, verbose) {
    if (is.function(post)) output = post(metadata, input, output, clean, verbose)
    f = with_ext(output, '.tex')
    new_theorems = load_config()[['new_theorems']]
    number_by = load_config()[['number_by']]
    style_with = load_config()[['style_with']]
    new_theorems_unnumbered = new_theorems[new_theorems == "---"]
    #print("Unnumbered:")
    #print(new_theorems_unnumbered)
    new_theorems_numbered = new_theorems[new_theorems != "---"]
    #print("Numbered:")
    #print(new_theorems_numbered)

    new_theorem_abbr = c(theorem_abbr, new_theorems_numbered)
    new_label_names_math = c(label_names_math, setNames(names(new_theorems_numbered), unlist(new_theorems_numbered, use.names=FALSE)))
    new_label_names = c(list(fig = 'Figure ', tab = 'Table ', eq = 'Equation '), new_label_names_math)
    new_label_types = names(new_label_names)
    new_reg_label_types = paste(new_label_types, collapse = '|')
    new_reg_label_types = paste(new_reg_label_types, 'ex', sep = '|')
    #This should be the numbered and the unnumbered new_theorems together in this as this function is from html.R
    x = resolve_new_theorems(read_utf8(f), global = !number_sections, new_theorems, number_by)
    #x = resolve_refs_latex(read_utf8(f), new_reg_label_types)
    #This should now only involve those theorems which are numbered
    x = resolve_refs_latex(x, new_reg_label_types, new_theorems, number_by)
    #x = resolve_ref_links_latex(x)
    x = bookdown:::restore_part_latex(x)
    x = bookdown:::restore_appendix_latex(x, toc_appendix)
    if (!toc_unnumbered) x = bookdown:::remove_toc_items(x)
    if (toc_bib) x = bookdown:::add_toc_bib(x)
    x = restore_block2(x, !number_sections, new_theorems_numbered, new_theorems_unnumbered, new_theorem_abbr, new_label_names, number_by, style_with)
    if (!is.null(quote_footer)) {
      if (length(quote_footer) != 2 || !is.character(quote_footer)) warning(
        "The 'quote_footer' argument should be a character vector of length 2"
      ) else x = bookdown:::process_quote_latex(x, quote_footer)
    }
    if (highlight_bw) x = bookdown:::highlight_grayscale_latex(x)
    post = getOption('bookdown.post.latex')
    if (is.function(post)) x = post(x)

    #The below has to happen after restore_block2 otherwise we don't have the packages we need
    xClear = revise_latex_alts(x, '12')
    xLarge = revise_latex_alts(x, '17')

    outputClear = paste(sans_ext(output), 'Clear.tex', sep='')
    file.copy(output, outputClear)
    fClear = with_ext(outputClear, '.tex')
    outputLarge = paste(sans_ext(output), 'Large.tex', sep='')
    file.copy(output, outputLarge)
    fLarge = with_ext(outputLarge, '.tex')

    write_utf8(x, f)
    write_utf8(xClear, fClear)
    write_utf8(xLarge, fLarge)
    tinytex::latexmk(
      f, config$pandoc$latex_engine,
      if ('--biblatex' %in% config$pandoc$args) 'biber' else 'bibtex'
    )
    tinytex::latexmk(
      fClear, config$pandoc$latex_engine,
      if ('--biblatex' %in% config$pandoc$args) 'biber' else 'bibtex'
    )
    tinytex::latexmk(
      fLarge, config$pandoc$latex_engine,
      if ('--biblatex' %in% config$pandoc$args) 'biber' else 'bibtex'
    )

    output = with_ext(output, '.pdf')
    outputClear = with_ext(paste(sans_ext(output), 'Clear', sep=''), '.pdf')
    outputLarge = with_ext(paste(sans_ext(output), 'Large', sep=''), '.pdf')
    
    o = load_config()[['output_dir']]
    #print(c("The output directory is: ",o))
    keep_tex = isTRUE(config$pandoc$keep_tex)
    if (!keep_tex) {
       file.remove(f)
       file.remove(fClear)
       file.remove(fLarge)
    }
    if (is.null(o)) return(output)

    output2 = file.path(o, output)
    output2Clear = file.path(o, outputClear)
    output2Large = file.path(o, outputLarge)
    file.rename(output, output2)
    file.rename(outputClear, output2Clear)
    file.rename(outputLarge, output2Large)
    if (keep_tex) {
       file.rename(f, file.path(o, f))
       file.rename(fClear, file.path(o, fClear))
       file.rename(fLarge, file.path(o, fLarge))
    }
    output2
  }
  # always enable tables (use packages booktabs, longtable, ...)
  pre = config$pre_processor
  config$pre_processor = function(...) {
    c(
      if (is.function(pre)) pre(...), '--variable', 'tables=yes', '--standalone',
      if (rmarkdown::pandoc_available('2.7.1')) '-Mhas-frontmatter=false'
    )
  }
  config$bookdown_output_format = 'latex'
  config = set_opts_knit(config)
  config
}


restore_block2 = function(x, global = FALSE, new_theorems_numbered, new_theorems_unnumbered, new_theorem_abbr, new_label_names, number_by, style_with) {
  #print(new_theorems)
  new_number_by = setNames(unlist(new_theorems_numbered, use.name=FALSE), unlist(new_theorems_numbered, use.names=FALSE))
  #Recall: number_by at this point is from the user and defines counter shares, it is prepended so that the entry 'overrides' the default
  number_by = c(number_by,list('thm'='thm','lem'='lem','cor'='cor','prp'='prp','cnj'='cnj','def' = 'def','exm'='exm','exr'='exr'),new_number_by)

  new_label_prefix = function(type, dict = new_label_names) bookdown:::i18n('label', type, dict)

  i = grep('^\\\\begin\\{document\\}', x)[1]
  if (is.na(i)) return(x)
  if (length(grep('\\\\(Begin|End)KnitrBlock', tail(x, -i))))
    x = append(x, '\\let\\BeginKnitrBlock\\begin \\let\\EndKnitrBlock\\end', i - 1)
  new_all_math_env = c(names(new_theorem_abbr), names(label_names_math2))
  if (length(grep(sprintf('^\\\\BeginKnitrBlock\\{(%s)\\}', paste(new_all_math_env, collapse = '|')), x)) &&
      length(grep('^\\s*\\\\newtheorem\\{theorem\\}', head(x, i))) == 0) {
      print("Writing out the newtheorem statements")
      #This array aligns to theorem_abbr but has those sharing a counter replaced by the env they share the counter with
      #You can't use aligned_abbr = theorem_abbr[match(number_by[match(theorem_abbr,number_by)],theorem_abbr)] when there are matches in the counter shares
      aligned_abbr = new_theorem_abbr[match(unlist(number_by[match(unlist(new_theorem_abbr,use.names = FALSE),names(number_by))],use.names = FALSE),new_theorem_abbr)]
      #These are the locations of the envs which share a counter
      duplicated_abbrLoc = which(duplicated(names(aligned_abbr)))
      #These are the locations of the envs which have their counter being shared
      counters_abbrLoc = unique(match(names(aligned_abbr[duplicated_abbrLoc]),names(aligned_abbr)))
      #These are the locations of all the envs which share counters and those which they share
      allcounted_abbrLoc = c(counters_abbrLoc,duplicated_abbrLoc)
      #These are the locations of all the envs that don't share a counter
      if(length(allcounted_abbrLoc) > 0)
        noncounters_abbrLoc = match(names(aligned_abbr[-allcounted_abbrLoc]),names(aligned_abbr))
      else
        noncounters_abbrLoc = 1:length(aligned_abbr)
      #print(noncounters_abbrLoc)

      #The envs which are going to share their counter
      theorem_counters_defs = sprintf(
        '%s\\newtheorem{%s}{%s}%s', theorem_style(names(aligned_abbr[counters_abbrLoc]),style_with), names(aligned_abbr[counters_abbrLoc]),
      	str_trim(vapply(aligned_abbr[counters_abbrLoc], new_label_prefix, character(1), USE.NAMES = FALSE)),
      	if (global) '' else {
           if (length(grep('^\\\\chapter[*]?', x))) '[chapter]' else '[section]'
      	}
      )

      #The envs which share a counter, these pick up their names from the original theorem_abbr using the aligned locations
      theorem_counted_defs = sprintf(
        '%s\\newtheorem{%s}[%s]{%s}', theorem_style(names(new_theorem_abbr[duplicated_abbrLoc]),style_with), names(new_theorem_abbr[duplicated_abbrLoc]), names(aligned_abbr[duplicated_abbrLoc]),
      	str_trim(vapply(new_theorem_abbr[duplicated_abbrLoc], new_label_prefix, character(1), USE.NAMES = FALSE))
      )

      #The envs which use their own counter and do not share it
      theorem_rest_defs = sprintf(
        '%s\\newtheorem{%s}{%s}%s', theorem_style(names(aligned_abbr[noncounters_abbrLoc]),style_with), names(aligned_abbr[noncounters_abbrLoc]),
      	str_trim(vapply(aligned_abbr[noncounters_abbrLoc], new_label_prefix, character(1), USE.NAMES = FALSE)),
	if (global) '' else {
	   if (length(grep('^\\\\chapter[*]?', x))) '[chapter]' else '[section]'
	}
      )

      #Unnumbered environments
      # the proof environment has already been defined by amsthm
      new_label_names_math2 = c(label_names_math2,setNames(names(new_theorems_unnumbered),names(new_theorems_unnumbered)))
      #print(new_label_names_math2)
      proof_envs = setdiff(names(new_label_names_math2), 'proof')
      proof_defs = sprintf(
        '%s\\newtheorem*{%s}{%s}', theorem_style(proof_envs,style_with), proof_envs,
      	gsub('^\\s+|[.]\\s*$', '', vapply(proof_envs, new_label_prefix, character(1), new_label_names_math2))
    	)
      x = append(x, c('\\usepackage{amsthm}', theorem_counters_defs, theorem_counted_defs, theorem_rest_defs, proof_defs), i - 1)
  }
  # remove the empty lines around the block2 environments
  i3 = if (length(i1 <- grep('^\\\\BeginKnitrBlock\\{', x))) (i1 + 1)[x[i1 + 1] == '']
  i3 = c(i3, if (length(i2 <- grep('^\\\\EndKnitrBlock\\{', x))) (i2 - 1)[x[i2 - 1] == ''])
  if (length(i3)) x = x[-i3]

  r = '^(.*\\\\BeginKnitrBlock\\{[^}]+\\})(\\\\iffalse\\{-)([-0-9]+)(-\\}\\\\fi\\{\\})(.*)$'
  if (length(i <- grep(r, x)) == 0) return(x)
  opts = sapply(strsplit(gsub(r, '\\3', x[i]), '-'), function(z) {
    intToUtf8(as.integer(z))
  }, USE.NAMES = FALSE)
  x[i] = paste0(gsub(r, '\\1', x[i]), opts, gsub(r, '\\5', x[i]))
  x
}

#We need a plain theorem style to be defined so that we can reset when outputting shared counter setups
style_plain = c('theorem', 'lemma', 'corollary', 'proposition', 'conjecture')
style_definition = c('definition', 'example', 'exercise')
style_remark = c('remark')
# which styles of theorem environments to use
theorem_style = function(env,style_with) {
  styles = character(length(env))
  #print(style_with["definition"])
  #print(env)
  styles[env %in% style_plain] = '\\theoremstyle{plain}\n'
  styles[env %in% style_with["plain"]] = '\\theoremstyle{plain}\n'
  styles[env %in% style_definition] = '\\theoremstyle{definition}\n'
  styles[env %in% style_with["definition"]] = '\\theoremstyle{definition}\n'
  styles[env %in% style_remark] = '\\theoremstyle{remark}\n'
  styles[env %in% style_with["remark"]] = '\\theoremstyle{remark}\n'
  #print("Styles:")
  #print(styles)
  styles
}

revise_latex_alts = function(x,pointsize) {
  clearfile = clavertondown_file('templates','Clear.tex')
  clearstring = paste(read_utf8(clearfile), collapse = "\n")
  clearstring = gsub('\\\\', '\\\\\\\\', clearstring)
  x = gsub('\\{article\\}','\\{extarticle\\}', x)
  x = gsub('\\{report\\}','\\{extreport\\}', x)
  x = gsub('\\\\begin\\{document\\}', sprintf('\n\n%s\n\n\\\\begin\\{document\\}', clearstring), x)
  x = gsub('\\d+pt,',sprintf('%spt,',pointsize),x)
  x
}

resolve_name_refs_latex = function(x){
  x = gsub('\\\\@ref\\((eq:[-/:[:alnum:]]+)\\)', '\\\\eqref{\\1}', x)
  x = gsub('\\\\@ref\\(([-/:[:alnum:]]+)\\)', '\\\\ref{\\1}', x)
  x
}

resolve_basic_refs_latex = function(x){
  # equation references \eqref{}
  x = gsub(
    '(?<!\\\\textbackslash{})@ref\\((eq:[-/:[:alnum:]]+)\\)', '\\\\eqref{\\1}', x,
    perl = TRUE
  )
  # normal references \ref{}
  x = gsub(
    '(?<!\\\\textbackslash{})@ref\\(([-/:[:alnum:]]+)\\)', '\\\\ref{\\1}', x,
    perl = TRUE
  )
  x
}


#To do the right thing with repeated environments we need to remove the label and override the numbering of the environment to be that of the label.
#This is actually quite involved... so, what tools does LaTeX have we can use...? None, really. The package proof-at-the-end might be a longer-term solution but any solution in LaTeX requires us to alter how the original theorem is encoded. This just moves the difficult problem to somewhere else in the code. The thing to do which fits in with the rest of this code is to alter the below function to do some of the same work which resolve_refs_html does _via_ parse_fig_labels. First question is... can we reuse parse_fig_labels? Actually, yes, we can but it seems to make no difference to the output at all! It is because the labs are in a different format at this point in the LaTeX code due to the escaped \
#OK, looking at whether we can notice that this is a repeated environment in the engine... Nope, there is no different in the options from the r chunk if it is a reuse - you cannot tell this! So, here is the best place unfortunately :(
#Let's concentrate on detection first, to detect a reuse of a label we need to collect all the labels etc. 
resolve_refs_latex = function(x, new_reg_label_types, new_theorems, number_by) {
  #Look for the labels
  m = gregexpr(sprintf('\\(\\\\#((%s):[-/[:alnum:]]+)\\)', new_reg_label_types), x)
  labs = regmatches(x, m)
  actuallabs = list()
  locs = list()
  duplocs = list()
  
  for (i in seq_along(labs)) {
    if (length(lab <- labs[[i]]) == 0) next
    #This is where the labels are, now we need to locate any repeats
    actuallabs = c(actuallabs,lab)
    locs = c(locs,i)
  }
  dups = duplicated(actuallabs)
  #This is where the duplicates are
  if(length(dups) > 0){
    for(i in 1:length(dups))
      if(dups[[i]] == TRUE){
        duplocs = c(duplocs,locs[[i]])
      	#This is where we need to insert the counter override... is there a way to do this so that we don't have to put anything after the theorem 
      	#print(x[[locs[[i]]-3]])
      	#print(actuallabs[[i]])
      	#print(gsub(sprintf('\\(\\\\#((%s):[-/[:alnum:]]+)\\)', new_reg_label_types), '\\\\ref{\\1}', actuallabs[[i]]))      
      	#We need to know what sort of environment this is so that we can override the numbering.
	#Actually, this is more complicated, we do need to know this, but, if this environment is numbered with another environments counter
	#then it is that counter that we need to mess about with. Can we even access this information?
	stringr::str_split("aabcc", "b")[[1]][[1]]
      	whatami = stringr::str_split(stringr::str_remove(x[[locs[[i]]-2]],'\\\\BeginKnitrBlock\\{'),'\\}',n=2)[[1]][[1]]
	print(whatami)
	mycounter = character(0)
	#Create list of all of the theorem types
	new_theorem_abbr = c(theorem_abbr,new_theorems)
	#print(new_theorem_abbr)
	mycounter = names(new_theorem_abbr[match(number_by[new_theorem_abbr[whatami][[1]]],new_theorem_abbr)])
	#Numbered as itself
	if(length(mycounter)==0)
	  mycounter = whatami
	#print(mycounter)
      	if(length(whatami) == 0)
          stop('There is a problem with a repeated environment.')
      	x[[locs[[i]]-3]] = stringr::str_c(x[[locs[[i]]-3]],sprintf('\\begingroup\\renewcommand{\\the%s}{%s}', mycounter, gsub(sprintf('\\(\\\\#((%s):[-/[:alnum:]]+)\\)', new_reg_label_types), '\\\\ref{\\1}', actuallabs[[i]])))
      	#Remove the duplicate label
      	#print(sprintf('\\(\\\\%s\\)',stringr::str_sub(actuallabs[[i]],3,-2)))
      	x[[locs[[i]]]] = stringr::str_remove(x[[locs[[i]]]],sprintf('\\(\\\\%s\\)',stringr::str_sub(actuallabs[[i]],3,-2)))
      	
      	#This is where we need to end the group, we are making the assumption that you cannot put theorem environments inside other theorem environments
	#which I think is true because of how the engine works.
      	for(j in locs[[i]]:length(x))
          if(stringr::str_detect(x[[j]],'\\EndKnitrBlock')){
	    print(sprintf('I am an %s using the counter %s. Starting at original loc %d I found the end at loc %d while reading %s', whatami, mycounter, locs[[i]], j, x[[j]]))
	    x[[j+1]] = stringr::str_c(x[[j+1]],sprintf('\\endgroup\\addtocounter{%s}{-1}',mycounter))
	    break
	  }
     }
  }
 
  x = resolve_basic_refs_latex(x)  
  #print(new_reg_label_types)
  #This is the original
  x = gsub(sprintf('\\(\\\\#((%s):[-/[:alnum:]]+)\\)', new_reg_label_types), '\\\\label{\\1}', x)
  x
}
