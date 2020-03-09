#' Retrieve CSV files from the Open Data BCN portal
#' @description  Use \code{get.csv()} to extract any CSV data set available on the
#' \href{https://opendata-ajuntament.barcelona.cat/en/}{Open Data BCN website} and
#' load it directly in your RStudio environment.
#'
#' Previously, use \code{\link[baRcelona]{datasetlist}} to get the resource ID
#' of the CSV you want to consult, and then introduce it as an input argument
#' using the \code{get.csv()} function.
#' @param id character
#' @author Xavier Vivancos
#' @usage
#' get.csv(id)
#'
#' @examples
#' # Get the resource ID of the CSV you want to consult
#' datasetlist()
#'
#' # Retrieve the CSV
#' get.csv(id = "e9d8d056-f1c9-4d38-b7ae-aedc9281417e")

get.csv <- function(id){

  # URL containing the requested data set
  url <-"https://opendata-ajuntament.barcelona.cat/data/api/action/datastore_search?resource_id="
  urlid <- paste0(url, id)

  # Data set
  dataset <- jsonlite::fromJSON(urlid, flatten=TRUE)
  dataset$result$records

}
