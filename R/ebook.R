epub_clav = function(
  fig_width = 5, fig_height = 4, dev = 'png', fig_caption = TRUE,
  number_sections = TRUE, toc = FALSE, toc_depth = 3, stylesheet = NULL,
  cover_image = NULL, metadata = NULL, chapter_level = 1,
  epub_version = c('epub3', 'epub'), md_extensions = NULL, pandoc_args = NULL,
  template = 'default', ...
) {
  epub_version = match.arg(epub_version)
  new_theorems = load_config()[['new_theorems']]
  number_by = load_config()[['number_by']]
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
      process_markdown(input_file, from, args, !number_sections, new_theorems, number_by)
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

process_markdown = function(input_file, from, pandoc_args, global, new_theorems, number_by, to_md = output_md()) {
  intermediate_html = with_ext(input_file, 'tmp.html')
  on.exit(file.remove(intermediate_html), add = TRUE)
  rmarkdown::pandoc_convert(
    input_file, 'html', from, intermediate_html, TRUE,
    c(pandoc_args, '--section-divs', '--mathjax', '--number-sections')
  )
  x = read_utf8(intermediate_html)
  x = bookdown:::clean_html_tags(x)
  #Need to do the next thing or the newtheorems will not be picked up in the label list
  x = resolve_new_theorems(x, global = !number_sections, new_theorems, number_by)
  figs = parse_fig_labels(x, global, new_theorems, number_by)
  # resolve cross-references and update the Markdown input file
  content = read_utf8(input_file)
  content = resolve_new_theorems(content, global = !number_sections, new_theorems, number_by)
  i = xfun::prose_index(content)
  content[i] = bookdown:::resolve_refs_md(content[i], c(figs$ref_table, bookdown:::parse_section_labels(x)), to_md)
  if (to_md) content = gsub(
    '^\\\\BeginKnitrBlock\\{[^}]+\\}|\\\\EndKnitrBlock\\{[^}]+\\}$', '', content
  )
  content = bookdown:::resolve_ref_links_epub(
    content, bookdown:::parse_ref_links(x, '^<p>%s (.+)</p>$'), to_md
  )
  if (!to_md) {
    i = xfun::prose_index(content)
    s = content[i]
    s = bookdown:::restore_part_epub(s)
    s = bookdown:::restore_appendix_epub(s)
    s = bookdown:::protect_math_env(s)
    content[i] = s
  }
  write_utf8(content, input_file)
}

