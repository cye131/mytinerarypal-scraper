getTemplate = function(html, params = list(title = 'NULL')) {
  
  if (!file.exists(file.path('layout/html', paste0(html,'.html')))) stop('Error: layout does not exist')
  
  
  # Load base HTML file
  base0 =
    readLines('layout/html/base.html', warn = FALSE, encoding = 'UTF-8')
  
  baseVars = str_match_all(baseHTML, '\\{\\{(.*?)\\}\\}')[[1]][,2]
  baseSub =
    lapply(baseInputs, function(x) if (x %in% names(params)) params[[x]] else '') %>%
    setNames(., paste0('\\{\\{',baseInputs,'\\}\\}')) %>%
    unlist(.)
  

  # Calculate how many tabs in the inner HTML content is
  innerTabsOut =
    base0 %>%
    .[str_detect(., fixed('{LOAD_HTML_HERE}'))] %>%
    str_count(., fixed('\t'))
  
  inner =
    # Load inner html
    file.path('layout/html', paste0(html,'.html')) %>%
    readLines(., warn = FALSE, encoding = 'UTF-8') %>%
    paste0(., collapse = '\r\n') %>%
    # Add tabs in
    str_replace_all(
      .,
      c('\\\r\\\n' = paste0(c('\r\n',rep('\t',innerTabsOut)), collapse = ''))
      )

  baseHTML %>%
    stringr::str_replace_all(., baseSub) %>% 
    str_replace(., fixed('{LOAD_HTML_HERE}'), replacement = inner) %>%
    HTML(.) %>%
    return(.)
}



