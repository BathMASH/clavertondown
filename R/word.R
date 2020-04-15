markdown_clav = function(
  fig_caption = TRUE, number_sections = TRUE, md_extensions = NULL, pandoc_args = NULL, ...,
  base_format = rmarkdown::md_document, new_theorems=list(), number_by = list()
) {
  from = rmarkdown::from_rmarkdown(fig_caption, md_extensions)

  config = get_base_format(base_format, list(
    fig_caption = fig_caption, md_extensions = md_extensions, pandoc_args = pandoc_args, ...
  ))
  pre = config$pre_processor
  config$pre_processor = function(metadata, input_file, ...) {
    # Pandoc does not support numbered sections for Word, so figures/tables have
    # to be numbered globally from 1 to n
    process_markdown(input_file, from, pandoc_args, !number_sections, new_theorems, number_by)
    if (is.function(pre)) pre(metadata, input_file, ...)
  }
  post = config$post_processor
  config$post_processor = function(metadata, input, output, clean, verbose) {
    if (is.function(post)) output = post(metadata, input, output, clean, verbose)
    move_output(output)
  }
  config$bookdown_output_format = config$pandoc$to
  config = set_opts_knit(config)
  config
}

word_clav = function(..., reference_docx = NULL) {

  #EHC is HERE
  reference_docx_ref = bookdown_file('templates', 'bookdownReference.docx')
  print(reference_docx)
  print(reference_docx_ref)
  if(is.null(reference_docx)) reference_docx = reference_docx_ref
  markdown_clav(..., base_format = rmarkdown::word_document, reference_docx = reference_docx)
}
