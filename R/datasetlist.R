#' Get the list of current data sets and their resources
#' @description  Use \code{datasetlist()} to manage the catalogue of data sets
#' on the \href{https://opendata-ajuntament.barcelona.cat/en/}{Open Data BCN} website.
#' This function may have an interest for citizens to know what information is available on the
#' portal and the data sets that are being added.
#' @param topic character
#' @param subtopic character
#' @author Xavier Vivancos
#' @usage
#' datasetlist()
#'
#' datasetlist(topic = c("Administration", "City and Services",
#'                       "Economy and Business", "Population",
#'                       "Territory"))
#'
#' datasetlist(subtopic = c("Culture and Leisure", "Demography",
#'                          "Education", "Employment", "Environment",
#'                          "Housing", "Human resources",
#'                          "Legislation and justice", "Participation",
#'                          "Procurement", "Public opinion",
#'                          "Public sector", "Science and technology",
#'                          "Security", "Society and Welfare", "Sport",
#'                          "Tourism", "Town planning and Infrastructures",
#'                          "Trade", "Transport"))
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

datasetlist <- function(topic, subtopic){

  # Load libraries
  suppressMessages(library(jsonlite))
  suppressMessages(library(tidyverse))

  # List of current datasets and their resources
  path <- "https://opendata-ajuntament.barcelona.cat/data/api/action/current_package_list_with_resources?limit=500"
  resources <- fromJSON(path, flatten=TRUE)$result %>%
    select(title, id, organization.parent.description, organization.description,
           fuente, department, author) %>%
    rename(Title=title,
           ID=id,
           `Main topic`=organization.parent.description,
           Subtopic=organization.description,
           Source=fuente,
           Department=department,
           Author=author) %>%
    mutate_at(c(3, 4, 5, 6, 7), as.factor)

  # Function call without arguments
  if(missing(topic) && missing(subtopic)){

    resources

  # Function call with the subtopic argument
  } else if(missing(topic) && subtopic %in% levels(resources$Subtopic)){

    resources %>% filter(Subtopic==subtopic)

  # Function call with the topic argument
  } else if(missing(subtopic) && topic %in% levels(resources$`Main topic`)){

    resources %>% filter(`Main topic`==topic)

  } else{

    print("Introduce a correct topic/subtopic, please")

  }
}