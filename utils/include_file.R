include_file <- function(doc_path, encoding = "UTF-8"){
        paste(readLines(doc_path, encoding = encoding), collapse = "\n")
}

