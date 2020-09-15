html_chapters_clav = function(
  toc = TRUE, number_sections = TRUE, fig_caption = TRUE, self_contained = FALSE, lib_dir = 'libs',
  template = clavertondown_file('templates/default.html'), pandoc_args = NULL, ...,
  base_format = rmarkdown::html_document, split_bib = TRUE, page_builder = bookdown:::build_chapter,
  split_by = c('section+number', 'section', 'chapter+number', 'chapter', 'rmd', 'none')
) {
  config = get_base_format(base_format, list(
    toc = toc, number_sections = number_sections, fig_caption = fig_caption,
    self_contained = FALSE, lib_dir = lib_dir,
    template = template, pandoc_args = bookdown:::pandoc_args2(pandoc_args), ...
  ))
  split_by = match.arg(split_by)
  post = config$post_processor  # in case a post processor have been defined
  config$post_processor = function(metadata, input, output, clean, verbose) {
    if (is.function(post)) output = post(metadata, input, output, clean, verbose)
    new_theorems = load_config()[['new_theorems']]
    number_by = load_config()[['number_by']]
    bookdown:::move_files_html(output, lib_dir)
    output2 = split_chapters_clav(output, page_builder, number_sections, split_by, split_bib, new_theorems, number_by)
    if (file.exists(output) && !same_path(output, output2)) file.remove(output)
    bookdown:::move_files_html(output2, lib_dir)
    output2
  }
  config$bookdown_output_format = 'html'
  config = set_opts_knit(config)
  config
}

html_book_clav = function(...) {
  html_chapters_clav(..., base_format = rmarkdown::html_document)
}

tufte_html_book_clav = function(...) {
  html_chapters_clav(..., base_format = tufte::tufte_html)
}

html_clav = function(
  ..., toc = TRUE, fig_caption = TRUE, number_sections = TRUE, self_contained = FALSE, pandoc_args = NULL, base_format = rmarkdown::html_document, lib_dir = 'libs'
) {
  config = get_base_format(base_format, list(
    ..., toc = toc, number_sections = number_sections, fig_caption = fig_caption,
    self_contained = FALSE, lib_dir = lib_dir,
    template = clavertondown_file('templates/default.html'), pandoc_args = bookdown:::pandoc_args2(pandoc_args)
  ))
  post = config$post_processor  # in case a post processor have been defined
  config$post_processor = function(metadata, input, output, clean, verbose) {
    if (is.function(post)) output = post(metadata, input, output, clean, verbose)
    new_theorems = load_config()[['new_theorems']]
    number_by = load_config()[['number_by']]
    x = read_utf8(output)
    x = bookdown:::clean_html_tags(x)
    x = bookdown:::restore_appendix_html(x, remove = FALSE)
    x = bookdown:::restore_part_html(x, remove = FALSE)
    x = resolve_new_theorems(x, global = !number_sections, new_theorems, number_by)
    print("Resolved new theorems")
    x = resolve_alt_tags(x)
    x = resolve_refs_html(x, global = !number_sections, new_theorems, number_by)
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

    x = resolve_repeated_ids(x, new_reg_label_types, new_theorems, number_by)
    print("Resolved references")
    print(knitr:::opts_knit$get('header.title'))
    write_utf8(x, output)
    bookdown:::move_files_html(output, lib_dir)
    move_output(output)
  }
  config$bookdown_output_format = 'html'
  config = set_opts_knit(config)
  config
}

html_fragment2_clav = function(..., number_sections = FALSE) {
  html_clav(
    ..., number_sections = number_sections, base_format = rmarkdown::html_fragment
  )
}

html_notebook2_clav = function(..., number_sections = FALSE) {
  html_clav(
    ..., number_sections = number_sections, base_format = rmarkdown::html_notebook
  )
}

html_vignette2_clav = function(..., number_sections = FALSE) {
  html_clav(
    ..., number_sections = number_sections, base_format = rmarkdown::html_vignette
  )
}

ioslides_presentation2_clav = function(..., number_sections = FALSE) {
  html_clav(
    ..., number_sections = number_sections, base_format = rmarkdown::ioslides_presentation
  )
}

slidy_presentation2_clav = function(..., number_sections = FALSE) {
  html_clav(
    ..., number_sections = number_sections, base_format = rmarkdown::slidy_presentation
  )
}

tufte_clav = function(..., number_sections = FALSE) {
  html_clav(
    ..., number_sections = number_sections, base_format = tufte::tufte_html
  )
}


split_chapters_clav = function(output, build = bookdown:::build_chapter, number_sections, split_by, split_bib, new_theorems, number_by, ...) {

  use_rmd_names = split_by == 'rmd'
  split_level = switch(
    split_by, none = 0, chapter = 1, `chapter+number` = 1,
    section = 2, `section+number` = 2, rmd = 1
  )

  if (!(split_level %in% 0:2)) stop('split_level must be 0, 1, or 2')

  x = read_utf8(output)
  x = bookdown:::clean_html_tags(x)

  i1 = bookdown:::find_token(x, '<!--bookdown:title:start-->')
  i2 = bookdown:::find_token(x, '<!--bookdown:title:end-->')
  i3 = bookdown:::find_token(x, '<!--bookdown:toc:start-->')
  i4 = bookdown:::find_token(x, '<!--bookdown:toc:end-->')
  i5 = bookdown:::find_token(x, '<!--bookdown:body:start-->')
  i6 = bookdown:::find_token(x, '<!--bookdown:body:end-->')

  r_chap = '^<!--chapter:end:(.+)-->$'
  n = length(grep(r_chap, x))

  # Need to take care of the div tags here before restore_part_html and
  # restore_appendix_html erase the section ids of the hidden PART or APPENDIX
  # sections.
  if (split_level > 1) {
    body = x[(i5 + 1):(i6 - 1)]
    h1 = grep('^<div (id="[^"]+" )?class="section level1("| )', body) + i5
    h2 = grep('^<div (id="[^"]+" )?class="section level2("| )', body) + i5
    h12 = setNames(c(h1, h2), rep(c('h1', 'h2'), c(length(h1), length(h2))))
	#print(i5)
	#print(h12)
	#This test is highly dubiuous, I have fixed it for now by adding 1 but this is too fragile, could be a windows linux thing as well
	#Actually, I am not sure why this needs to be true? I think I've fixed it below. 
    	#if (length(h12) > 0 && h12[1] != i5 + 2) stop(
    	#  'The document must start with a first (#) or second level (##) heading'
    	#)
    h12 = sort(h12)
    if (length(h12) > 1) {
      n12 = names(h12)
      # h2 that immediately follows h1
      i = h12[n12 == 'h2' & c('h2', head(n12, -1)) == 'h1'] - 1
      # close the h1 section early with </div>
      # reg_chap and sec_num must take this into account so that cross reference
      # works when split by section. (#849)
      if (length(i)) x[i] = paste0(x[i], '\n</div>')
      # h1 that immediately follows h2 but not the first h1
      i = n12 == 'h1' & c('h1', head(n12, -1)) == 'h2'
      if (any(i) && n12[1] == 'h2') i[which(n12 == 'h1')[1]] = FALSE
      i = h12[i] - 1
      # need to comment out the </div> corresponding to the last <h1> in the body
      if (tail(n12, 1) == 'h2' && any(n12 == 'h1')) {
        for (j in (i6 - 1):(tail(h12, 1))) {
          # the line j should close h1, and j - 1 should close h2
          if (all(x[j - 0:1] == '</div>')) break
        }
        i = c(i, j)
      }
      for (j in i) {
        # the i-th lines should be the closing </div> for h1
        if (x[j] != '</div>') stop(
          'Something wrong with the HTML output. The line ', x[j],
          ' is supposed to be </div>'
        )
      }
      x[i] = paste('<!--', x[i], '-->')  # remove the extra </div> of h1
    }
  }

  x = bookdown:::add_section_ids(x)
  x = bookdown:::restore_part_html(x)
  x = bookdown:::restore_appendix_html(x)

  # no (or not enough) tokens found in the template
  if (any(c(i1, i2, i3, i4, i5, i6) == 0)) {
    x = resolve_new_theorems(x, global = !number_sections, new_theorems, number_by)
    x = resolve_refs_html(x, !number_sections, new_theorems, number_by)
    x = bookdown:::add_chapter_prefix(x)
    write_utf8(x, output)
    return(output)
  }

  html_head  = x[1:(i1 - 1)]  # HTML header + includes
  html_title = x[(i1 + 1):(i2 - 1)]  # title/author/date
  html_toc   = x[(i3 + 1):(i4 - 1)]  # TOC
  html_body  = x[(i5 + 1):(i6 - 1)]  # body
  html_foot  = x[(i6 + 1):length(x)]  # HTML footer

  html_toc = bookdown:::add_toc_ids(html_toc)

  idx = grep(r_chap, html_body)
  nms = gsub(r_chap, '\\1', html_body[idx])  # to be used in HTML filenames
  h1 = grep('^<div (id="[^"]+" )?class="section level1("| )', x)
  if(length(h1) == 0) split_level = 0
  if (length(h1) > 0 && length(h1) < length(nms)) warning(
    'You have ', length(nms), ' Rmd input file(s) but only ', length(h1),
    ' first-level heading(s). Did you forget first-level headings in certain Rmd files?'
  )

  html_body = resolve_new_theorems(html_body, !number_sections, new_theorems, number_by)
  html_body = resolve_refs_html(html_body, !number_sections, new_theorems, number_by)

  # do not split the HTML file
  if (split_level == 0) {
    html_body[idx] = ''  # remove chapter tokens
    html_body = bookdown:::add_chapter_prefix(html_body)
    output = 'index.html'
    write_utf8(build(
      html_head, html_toc, c(html_title, html_body), NULL, NULL, NULL, output, html_foot, ...
    ), output)
    return(bookdown:::move_to_output_dir(output))
  }

  if (split_bib) {
    # parse and remove the references chapter
    res = bookdown:::parse_references(html_body)
    refs = res$refs; html_body = res$html; ref_title = res$title
  }
  # parse and remove footnotes (will reassign them to relevant pages later)
  res = bookdown:::parse_footnotes(html_body)
  fnts = res$items
  if (length(fnts)) html_body[res$range] = ''

  if (use_rmd_names) {
    html_body[idx] = ''
    nms_chaps = nms  # Rmd filenames
    if (n >= 1) {
      idx = next_nearest(idx, grep('^<div', html_body))
      idx = c(1, idx[-n])
    }
  } else {
    h1 = grep('^<div (id="[^"]+" )?class="section level1("| )', html_body)
    h2 = grep('^<div (id="[^"]+" )?class="section level2("| )', html_body)
    idx2 = if (split_level == 1) h1 else if (split_level == 2) sort(c(h1, h2))
    n = length(idx2)
    nms_chaps = if (length(idx)) {
      vapply(idx2, character(1), FUN = function(i) head(nms[idx > i], 1))
    }
    reg_id = '^<div id="([^"]+)".*$'
    reg_num = '^(<h[12]><span class="header-section-number">)([.A-Z0-9]+)(</span>.+</h[12]>).*$'
    nms = vapply(idx2, character(1), FUN = function(i) {
      x1 = html_body[i]; x2 = html_body[i + 1]
      id = if (grepl(reg_id, x1)) gsub(reg_id, '\\1', x1)
      num = if (grepl(reg_num, x2)) gsub(reg_num, '\\2', x2)
      if (is.null(id) && is.null(num)) stop(
        'The heading ', x2, ' must have at least an id or a number'
      )
      nm = if (grepl('[+]number$', split_by)) {
        paste(c(num, id), collapse = '-')
      } else id
      if (is.null(nm)) stop('The heading ', x2, ' must have an id')
      gsub('[^[:alnum:]]+', '-', nm)
    })
    if (anyDuplicated(nms)) (if (isTRUE(opts$get('preview'))) warning else stop)(
      'Automatically generated filenames contain duplicated ones: ',
      paste(nms[duplicated(nms)], collapse = ', ')
    )
    # generate index.html if the first Rmd filename is index.Rmd
    if (identical(with_ext(head(nms_chaps, 1), ''), 'index')) nms[1] = 'index'
    html_body[idx] = ''
    idx = idx2
  }
  if (n == 0) {
    idx = 1; nms = output; n = 1
  }

  nms = basename(with_ext(nms, '.html'))  # the HTML filenames to be generated
  input = opts$get('input_rmd')
  html_body = bookdown:::add_chapter_prefix(html_body)
  html_toc = bookdown:::restore_links(html_toc, html_body, idx, nms)
  for (i in seq_len(n)) {
    # skip writing the chapter.html if the current Rmd name is not in the vector
    # of Rmd names passed to render_book() (only this vector of Rmd's should be
    # rendered for preview purposes)
    if (isTRUE(opts$get('preview')) && !(nms_chaps[i] %in% input)) {
      if (!file.exists(output_path(nms[i]))) file.create(nms[i])
      next
    }
    #This should enable us to keep anything prior to the first heading in the gitbook format. I don't understand the reason for preventing this in the first place so we should play around with this. 
    i1 = if(i == 1) 1 else idx[i]
    i2 = if (i == n) length(html_body) else idx[i + 1] - 1
    #print(i1)
    #print(i2)
    #print(html_body[i1:i2])
    html = c(if (i == 1) html_title, html_body[i1:i2])
    a_targets = bookdown:::parse_a_targets(html)
    if (split_bib) {
      html = bookdown:::relocate_references(html, refs, ref_title, a_targets)
    }
    html = bookdown:::relocate_footnotes(html, fnts, a_targets)
    html = bookdown:::restore_links(html, html_body, idx, nms)
    html = build(
      bookdown:::prepend_chapter_title(html_head, html), html_toc, html,
      if (i > 1) nms[i - 1],
      if (i < n) nms[i + 1],
      if (length(nms_chaps)) nms_chaps[i],
      nms[i], html_foot, ...
    )
    write_utf8(html, nms[i])
  }
  nms = bookdown:::move_to_output_dir(nms)

  # find the HTML output file corresponding to the Rmd file passed to render_book()
  if (is.null(input) || length(nms_chaps) == 0) j = 1 else {
    if (is.na(j <- match(input[1], nms_chaps))) j = 1
  }
  nms[j]
}


#' Resolve newtheorems introduced by the user which are using a renderer which does not know the label, only the env name
# If someone has chosen to call their newtheorem Example or example then we have a problem the source of which I cannot find but which I presume to be Pandoc
# as by the time we are postprocessing it is already 'too late'. Hence, there is some odd code in the below to deal with this case. 
resolve_new_theorems = function(content, global = FALSE, new_theorems, number_by){
  if(length(new_theorems) > 0){
    for(i in 1:length(new_theorems)){
      if(new_theorems[[i]] == "---"){
        # Resolve the unnumbered (and HENCE unnamed theorems - since names come from labels and unnumbered SHOULD NOT HAVE labels!) in html:
      	content = gsub(sprintf('id="%s:unnamed-chunk-[-/[:alnum:]]+"', names(new_theorems[i])), sprintf('', new_theorems[[i]]), content)
      	content = gsub(sprintf(' \\(#%s:unnamed-chunk-[-/[:alnum:]]+\\)', names(new_theorems[i])), sprintf(':'), content)
	#Instead of trying to guess what variety of things might happen below we have put \iffalse \iff around the label, we leave it there in this case and remove it in the numbered case. 
	#content = gsub(sprintf('#%s:unnamed-chunk-[-/[:alnum:]]+', names(new_theorems[i])), sprintf(''), content)
      }else{
      	content = gsub(sprintf('id="%s:', names(new_theorems[i])), sprintf('id="%s:', new_theorems[[i]]), content)
      	content = gsub(sprintf('\\(#%s:', names(new_theorems[i])), sprintf('\\(#%s:', new_theorems[[i]]), content)
	#Allow the labels for the numbered
	content = gsub(sprintf('\\\\iffalse\\{\\} \\(\\\\#%s:([[:alnum:]]+)\\) \\\\fi\\{\\}', names(new_theorems[i])), sprintf('\\(\\\\#%s:\\1\\)', new_theorems[[i]]), content)
	#This is still needed for ePub and Word
	content = gsub(sprintf('#%s:', names(new_theorems[i])), sprintf('#%s:', new_theorems[[i]]), content)
	if(names(new_theorems[i]) == 'Example' || names(new_theorems[i]) == 'example'){
	  content = gsub(sprintf('\\(#<a href="%s:([[:alnum:]]+)" class="uri">%s:([[:alnum:]]+)</a>\\)', names(new_theorems[i]), names(new_theorems[i])), sprintf('\\(#%s:\\1\\)', new_theorems[[i]]), content)
	}
      }
    }
  }
  content
}

resolve_alt_tags = function(content){
  #We are looking for titles inside img, by this point there will be an empty alt tag (the alt will have become the caption) which we need to remove and there will be a title which needs to become the alt tag. I am not happy with this method of achieving things as it is very backward but it is the outcome of where we are by this point and is the simplest thing to do. This will work with the ![]() format. I have no idea what the side effect is of this in any other method of including images and this will need to be tested extensively but not right now.

  #Look for empty alt tags with a title on the same line, remove the alt tag and rename the title to be the alt
  content = gsub('title="([^"]*)" alt=""','alt="\\1"', content)
  content
}

resolve_refs_html = function(content, global = FALSE, new_theorems, number_by) {
  content = bookdown:::resolve_ref_links_html(content)

  res = parse_fig_labels(content, global, new_theorems, number_by)
  content = res$content
  ref_table = c(res$ref_table, bookdown:::parse_section_labels(content))

  # look for @ref(label) and resolve to actual figure/table/section numbers
  m = gregexpr('(?<!\\\\)@ref\\(([-:[:alnum:]]+)\\)', content, perl = TRUE)
  refs = regmatches(content, m)

  for (i in seq_along(refs)) {
    if (length(refs[[i]]) == 0) next
    # strip off html tags when resolve numbers in <img>'s alt attribute because
    # the numbers may contain double quotes, e.g. <img alt="<a
    # href="#foo">1.2</a>"" width=...
    ref = bookdown:::ref_to_number(refs[[i]], ref_table, FALSE)
    if (bookdown:::is_img_line(content[i])) ref = bookdown:::strip_html(ref)
    refs[[i]] = ref
  }
  regmatches(content, m) = refs
  content
}

reg_chap = '^(<h1><span class="header-section-number">)([A-Z0-9]+)(</span>.+</h1>)(\n</div>)?$'

# default names for labels
label_names = list(fig = 'Figure ', tab = 'Table ', eq = 'Equation ')
# prefixes for theorem environments
theorem_abbr = c(
  theorem = 'thm', lemma = 'lem', corollary = 'cor', proposition = 'prp', conjecture = 'cnj',
  definition = 'def', example = 'exm', exercise = 'exr'
)
# numbered math environments
label_names_math = setNames(list(
  'Theorem ', 'Lemma ', 'Corollary ', 'Proposition ', 'Conjecture ', 'Definition ', 'Example ', 'Exercise '
), theorem_abbr)
# unnumbered math environments
label_names_math2 = list(proof = 'Proof. ', remark = 'Remark. ', solution = 'Solution. ')
all_math_env = c(names(theorem_abbr), names(label_names_math2))

label_names = c(label_names, label_names_math)

# types of labels currently supported, e.g. \(#fig:foo), \(#tab:bar)
label_types = names(label_names)
reg_label_types = paste(label_types, collapse = '|')
# compatibility with bookdown <= 0.4.7: ex was the prefix for Example; now it's exm
reg_label_types = paste(reg_label_types, 'ex', sep = '|')


parse_fig_labels = function(content, global = FALSE,
new_theorems = list(), number_by = list()
) {
  new_number_by = setNames(unlist(new_theorems, use.names=FALSE),unlist(new_theorems, use.names=FALSE))
  number_by = c(number_by,list('fig' = 'fig', 'tab' = 'tab', 'eq' = 'eq', 'thm'='thm','lem'='lem','cor'='cor','prp'='prp','cnj'='cnj','def' = 'def','exm'='exm','exr'='exr'),new_number_by)
  #print(c('new_theorems: ', new_theorems), quote=FALSE)  
  #print(c('new_number_by: ', new_number_by), quote=FALSE)
  #print(c('number_by: ', number_by), quote=FALSE)
  lines = grep(reg_chap, content)
  chaps = gsub(reg_chap, '\\2', content[lines])  # chapter numbers
  if (length(chaps) == 0) {
    global = TRUE  # no chapter titles or no numbered chapters
  } else {
    chaps = c('0', chaps)  # use Chapter 0 in case of any figure before Chapter 1
    lines = c(0, lines)
  }
  arry = character()  # an array of the form c(label = number, ...)
  if (global) chaps = '0'  # Chapter 0 (could be an arbitrary number)

  content = bookdown:::restore_math_labels(content)

  # See "prefixes for theorem environments" above - we need to update these with the new labels etc. that the user has provided
  # There is probably a better way of doing this. The first job is to confirm that this will work at all. 
  #new_theorem_abbr = c(theorem_abbr, new_theorems)
  #print(c('new_theorem_abbr: ', new_theorem_abbr), quote=FALSE)
  new_label_names_math = c(label_names_math, setNames(names(new_theorems), unlist(new_theorems, use.names=FALSE)))
  #print(c('new_label_names_math: ', new_label_names_math), quote=FALSE)
  #new_all_math_env = c(names(new_theorem_abbr), names(label_names_math2))
  #print(c('new_all_math_env: ', new_all_math_env), quote=FALSE)
  new_label_names = c(list(fig = 'Figure ', tab = 'Table ', eq = 'Equation '), new_label_names_math)
  #print(c('new_label_names: ', new_label_names), quote=FALSE)
  new_label_types = names(new_label_names)
  #print(c('new_label_types: ', new_label_types), quote=FALSE)
  new_reg_label_types = paste(new_label_types, collapse = '|')
  new_reg_label_types = paste(new_reg_label_types, 'ex', sep = '|')
  #print(c('new_reg_label_types: ', new_reg_label_types), quote=FALSE)
    
  # look for (#fig:label) or (#tab:label) and replace them with Figure/Table x.x
  #m = gregexpr(sprintf('\\(#((%s):[-/[:alnum:]]+)\\)', reg_label_types), content)
  m = gregexpr(sprintf('\\(#((%s):[-/[:alnum:]]+)\\)', new_reg_label_types), content)
  labs = regmatches(content, m)
  #cntr = new_counters(label_types, chaps)  # chapter counters
  cntr = bookdown:::new_counters(new_label_types, chaps)  # chapter counters
  figs = grep('^<div class="figure', content)
  eqns = grep('<span class="math display">', content)

  for (i in seq_along(labs)) {
    if (length(lab <- labs[[i]]) == 0) next

    j = if (global) chaps else tail(chaps[lines <= i], 1)
    if (length(j) == 0) j = chaps[1]  # use Chapter 0
    lab = gsub('^\\(#|\\)$', '', lab)
    type = gsub('^([^:]+):.*', '\\1', lab)
    # there could be multiple labels on the same line, but their types must be
    # the same (https://github.com/rstudio/bookdown/issues/538)
    if (length(unique(type)) != 1) stop(
      'There are mutiple types of labels on one line: ', paste(labs, collapse = ', ')
    )
    type = type[1]
    numtype=getElement(number_by,type)
    #numtype = is.list(number_by)
    #stop('numtype, names, elements ',paste(numtype), paste(names(number_by)), paste(number_by$lem))
    num = arry[lab]
    for (k in which(is.na(num))) {
      num[k] = cntr$inc(numtype, j)  # increment number only if the label has not been used
      if (!global) num[k] = paste0(j, '.', num[k])  # Figure X.x
    }
    arry = c(arry, setNames(num, lab))

    switch(type, fig = {
      if (length(grep('^<p class="caption', content[i - 0:1])) == 0) {
        # remove these labels, because there must be a caption on this or
        # previous line (possible negative case: the label appears in the alt
        # text of <img>)
        labs[[i]] = character(length(lab))
        next
      }
      labs[[i]] = paste0(bookdown:::label_prefix(type), num, ': ')
      k = max(figs[figs <= i])
      content[k] = paste(c(content[k], sprintf('<span id="%s"></span>', lab)), collapse = '')
    }, tab = {
      if (length(grep('^<caption', content[i - 0:1])) == 0) next
      labs[[i]] = sprintf(
        '<span id="%s">%s</span>', lab, paste0(bookdown:::label_prefix(type), num, ': ')
      )
    }, eq = {
      labs[[i]] = sprintf('\\tag{%s}', num)
      k = max(eqns[eqns <= i])
      content[k] = sub(
        '(<span class="math display")', sprintf('\\1 id="%s"', lab), content[k]
      )
    }, {
      labs[[i]] = paste0(bookdown:::label_prefix(type), num, ': ')
    })
  }

  regmatches(content, m) = labs

  # remove labels in figure alt text (it will contain \ like (\#fig:label))
  content = gsub('"\\(\\\\#(fig:[-/[:alnum:]]+)\\)', '"', content)

  list(content = content, ref_table = arry)
}


# We need to remove duplicate ids caused by repeated environments
resolve_repeated_ids = function(x, new_reg_label_types, new_theorems, number_by) {
  #Look for the ids
  m = gregexpr(sprintf('id=\"(%s):[-/[:alnum:]]+\"', new_reg_label_types), x)
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
  #print(dups)
  #This is where the duplicates are
  if(length(dups) > 0){
    for(i in 1:length(dups))
      if(dups[[i]] == TRUE){
        duplocs = c(duplocs,locs[[i]])
	#print(x[[locs[[i]]]])
	#print(sprintf('id%s',stringr::str_sub(actuallabs[[i]],3,-1)))
	x[[locs[[i]]]] = stringr::str_remove(x[[locs[[i]]]],sprintf('id%s',stringr::str_sub(actuallabs[[i]],3,-1)))
	#print(x[[locs[[i]]]])
	}
  }

  x
}
