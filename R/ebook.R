epub_clav = function(
  fig_width = 5, fig_height = 4, dev = 'png', fig_caption = TRUE,
  number_sections = TRUE, toc = FALSE, toc_depth = 3, stylesheet = NULL,
  cover_image = NULL, metadata = NULL, chapter_level = 1,
  epub_version = c('epub3', 'epub'), md_extensions = NULL, pandoc_args = NULL,
  template = clavertondown_file('templates/default.html'), ...
) {
  epub_version = match.arg(epub_version)
  new_theorems = load_config()[['new_theorems']]
  number_by = load_config()[['number_by']]
  style_with = load_config()[['style_with']]
  classify_as = load_config()[['classify_as']]
  args = c(
    pandoc_args,
    if (number_sections) '--number-sections',
    if (toc) '--toc',
    if (!missing(toc_depth)) c('--toc-depth', toc_depth),
    if (!is.null(cover_image)) c('--epub-cover-image', cover_image),
    if (!is.null(metadata)) c('--epub-metadata', metadata),
    if (!identical(template, 'default')) c('--template', template),
    if (!missing(chapter_level)) c('--epub-chapter-level', chapter_level)
  )
  if (is.null(stylesheet)) css = NULL else {
    css = rmarkdown::pandoc_path_arg(epub_css(stylesheet))
    args = c(args, if (pandoc2.0()) '--css' else '--epub-stylesheet', css)
  }

  from = rmarkdown::from_rmarkdown(fig_caption, md_extensions)

  config = rmarkdown::output_format(
    knitr = rmarkdown::knitr_options_html(fig_width, fig_height, NULL, FALSE, dev),
    pandoc = rmarkdown::pandoc_options(epub_version, from, args, ext = '.epub'),
    pre_processor = function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
      process_markdown(input_file, from, args, !number_sections, new_theorems, number_by, style_with, classify_as)
      NULL
    },
    post_processor = function(metadata, input, output, clean, verbose) {
      if (length(css)) file.remove(css)
      move_output(output)
    }
  )
  config$bookdown_output_format = 'epub'
  config = set_opts_knit(config)
  config
}

move_output = function(output) {
  o = load_config()[['output_dir']]
  if (is.null(o)) return(output)
  output2 = file.path(o,output)
  file.rename(output, output2)
  output2
}

process_markdown = function(input_file, from, pandoc_args, global, new_theorems, number_by, style_with, classify_as, to_md = output_md()) {
  intermediate_html = with_ext(input_file, 'tmp.html')
  #You can stop the removal of the intermediate format by uncommenting the below
  #But keep in mind this is used for working out adjustments to the markdown only
  #We are not going via html
  on.exit(file.remove(intermediate_html), add = TRUE)
  rmarkdown::pandoc_convert(
    input_file, 'html', from, intermediate_html, TRUE,
    c(bookdown:::pandoc_args2(pandoc_args), '--section-divs', '--mathjax', '--number-sections')
  )
  x = read_utf8(intermediate_html)
  x = clean_names(x)
  x = bookdown:::clean_html_tags(x)
  #Need to do the next thing or the newtheorems will not be picked up in the label list
  #But this is not actually changing anything else, x is being used only the create figs 
  x = resolve_new_theorems(x, global = !number_sections, new_theorems, number_by)
  figs = parse_fig_labels(x, global, new_theorems, number_by)

  # resolve cross-references and update the Markdown input file
  content = read_utf8(input_file)
  content = clean_names(content)
  #This works because by this point the theorems are in html
  content = resolve_new_theorems(content, global = !number_sections, new_theorems, number_by)
  i = xfun::prose_index(content)
  content[i] = resolve_refs_md(content[i], c(figs$ref_table, bookdown:::parse_section_labels(x)), to_md)
  if (to_md) content = gsub(
    '^\\\\BeginKnitrBlock\\{[^}]+\\}|\\\\EndKnitrBlock\\{[^}]+\\}$', '', content
  )
  content = bookdown:::resolve_ref_links_epub(
    content, bookdown:::parse_ref_links(x, '^<p>%s (.+)</p>$'), to_md
  )

  # We always want to turn off the italics, this isn't really needed to turn off the italics as they aren't carried through but it is needed to change
  # the styling to the non-italics style so that the right css kicks in. 
  #This works because the theorems are by this point in html
  content = fix_classifications(content, classify_as)
  content = remove_colours(content, style_with["colouroff"][[1]])
  content = remove_italics(content, TRUE)  

  if (!to_md) {
    i = xfun::prose_index(content)
    s = content[i]
    s = bookdown:::restore_part_epub(s)
    s = bookdown:::restore_appendix_epub(s)
    s = bookdown:::protect_math_env(s)
    content[i] = s
  }

  #At this point we are in markdown and about to process directly to ebook, which we cannot post-process
  #The result will be a format in which the caption and the alternative text of an image are the same and
  #the intended alternative text will end up in the title. There appears to be no solution to this.
  #Does it actually matter? Will a screenreader, reading an ebook, read the title and alternative text?
  #I actually have no idea... and no immediate way to test this. So I will leave this unresolved for now. 

  write_utf8(content, input_file)
}


resolve_refs_md = function(content, ref_table, to_md = output_md()) {
  ids = names(ref_table)

  # replace (\#fig:label) with Figure x.x:
  for (i in grep('^(<p class="caption|<caption>|Table:|\\\\BeginKnitrBlock)|(!\\[.*?\\]\\(.+?\\))', content)) {
    for (j in ids) {
      m = sprintf('\\(\\\\#%s\\)', j)
      if (grepl(m, content[i])) {
        id = ''; sep = ':'
        type = gsub('^([^:]+).*$', '\\1', j)
        if (type %in% theorem_abbr) {
          id = sprintf('<span id="%s"></span>', j)
          sep = ''
        }
        label = label_prefix(type)
        content[i] = sub(m, paste0(id, label, ref_table[j], sep, ' '), content[i])
        break
      }
    }
  }
  # remove labels in figure alt text (it will contain \ like (\#fig:label))
  content = gsub('"\\(\\\\#(fig:[-[:alnum:]]+)\\)', '"', content)
  # replace (\#eq:label) with equation numbers
  content = bookdown:::add_eq_numbers(content, ids, ref_table, to_md)

  # look for \@ref(label) and resolve to actual figure/table/section numbers
  m = gregexpr('(?<!`)\\\\@ref\\(([-:[:alnum:]]+)\\)', content, perl = TRUE)
  refs = regmatches(content, m)
  regmatches(content, m) = lapply(refs, bookdown:::ref_to_number, ref_table, TRUE)
  content
}
