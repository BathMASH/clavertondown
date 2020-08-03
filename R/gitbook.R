gitbook_clav = function(
  fig_caption = TRUE, number_sections = TRUE, self_contained = FALSE,
  lib_dir = 'libs', pandoc_args = NULL, ..., template = 'default',
  split_by = c('chapter', 'chapter+number', 'section', 'section+number', 'rmd', 'none'),
  split_bib = TRUE, config = list(), includes = list(), table_css = TRUE
) {
  html_clav = function(..., extra_dependencies = list()) {
    rmarkdown::html_document(
      ..., extra_dependencies = c(extra_dependencies, bookdown:::gitbook_dependency(table_css))
    )
  }
  gb_config = config
  if (identical(template, 'default')) {
    template = clavertondown_file('templates', 'gitbook.html')
  }
  mathjax_header = clavertondown_file('templates','mathjax-setup.html')
  includes$in_header = c(includes$in_header, mathjax_header)

  config = html_clav(
    toc = TRUE, number_sections = number_sections, fig_caption = fig_caption,
    self_contained = self_contained, lib_dir = lib_dir, theme = NULL,
    template = template, pandoc_args = bookdown:::pandoc_args2(pandoc_args), includes = includes, ...
  )
  split_by = match.arg(split_by)
  post = config$post_processor  # in case a post processor have been defined
  config$post_processor = function(metadata, input, output, clean, verbose) {
    if (is.function(post)) output = post(metadata, input, output, clean, verbose)
    new_theorems = load_config()[['new_theorems']]
    number_by = load_config()[['number_by']]
    on.exit(bookdown:::write_search_data(), add = TRUE)

    # a hack to remove Pandoc's margin for code blocks since gitbook has already
    # defined margin on <pre> (there would be too much bottom margin)
    x = read_utf8(output)
    x = x[x != 'div.sourceCode { margin: 1em 0; }']
    write_utf8(x, output)

    bookdown:::move_files_html(output, lib_dir)
    output2 = split_chapters_clav(
      output, bookdown:::gitbook_page, number_sections, split_by, split_bib, new_theorems, number_by, gb_config
    )
    if (file.exists(output) && !same_path(output, output2)) file.remove(output)
    bookdown:::move_files_html(output2, lib_dir)
    output2
  }
  config$bookdown_output_format = 'html'
  config = set_opts_knit(config)
  config
}

