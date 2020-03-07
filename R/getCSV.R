#' Retrieve CSV files from the Open Data BCN portal
#' @description  Use \code{getCSV()} to read any CSV file available on the
#' \href{https://opendata-ajuntament.barcelona.cat/en/}{Open Data BCN} website and
#' load it directly in your RStudio environment. Use \code{\link[baRcelona]{datasetlist}}
#' @param topic character
#' @param subtopic character
#' @author Xavier Vivancos
#' @usage
#' getCSV(id)
#'
#' @details
#' \itemize{
#'  \item{If you want to retrieve all the current data sets
#'  and their resources, execute the function without arguments}
#'  \item{You can filter by topic and obtain a subset.}
#'  \item{If you are having difficulties finding a certain data set,
#' you can also filter by more specific topics}
#' }
#' @examples
#' # Retrieves all the current data sets
#' datasetlist()
#'
#' # Only shows the data sets about population
#' datasetlist(topic = "Population")
#'
#' # Only shows the data sets about sports
#' datasetlist(subtopic = "Sport")

getCSV <- function(id){

  # Load libraries
  suppressMessages(library(jsonlite))

  # URL containing the requested data set
  url <-"https://opendata-ajuntament.barcelona.cat/data/api/action/datastore_search?resource_id="
  urlid <- paste0(url, id)

  # Data set
  dataset <- fromJSON(urlid, flatten=TRUE)
  dataset$result$records

}

