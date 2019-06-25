library(shiny)
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
# runApp(file.path('rscripts', 'test-app'))


list(
  ui = getTemplate('page1', list(title = 'Test', scripts = '<script></script>')),
  server = server
  ) %>%
  runApp(.)