#' Get the list of current data sets and their resources
#' @description  Use \code{datasetlist()} to manage the catalogue of data sets
#' on the \href{https://opendata-ajuntament.barcelona.cat/en/}{Open Data BCN website}.
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
#'  and their resources, execute the function without arguments.}
#'  \item{You can filter by topic and obtain a subset.}
#'  \item{If you are having difficulties finding a certain data set,
#' you can also filter by more specific topics.}
#' }
#' @examples
#' # Retrieves all the current data sets
#' datasetlist()
#'
#' # Only shows data sets about population
#' datasetlist(topic = "Population")
#'
#' # Only shows data sets about sports
#' datasetlist(subtopic = "Sport")
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr select rename mutate_at filter
#' @importFrom jsonlite fromJSON
#' @export datasetlist

datasetlist <- function(topic, subtopic){

  # List of current datasets and their resources
  path <- "https://opendata-ajuntament.barcelona.cat/data/api/action/current_package_list_with_resources?limit=500"
  datasetlist <- jsonlite::fromJSON(path, flatten=TRUE)$result %>%
    dplyr::select(title, resources, organization.parent.description, organization.description,
           fuente, department, author) %>%
    dplyr::rename(Title=title,
           Topic=organization.parent.description,
           ID=resources,
           Subtopic=organization.description,
           Source=fuente,
           Department=department,
           Author=author) %>%
    dplyr::mutate_at(c(3, 4, 5, 6, 7), as.factor)

  # Select 4 fields of the ID list: Name, ID, Format and URL
  for(i in 1:nrow(datasetlist)){

    datasetlist$ID[[i]] <- datasetlist$ID[[i]] %>%
      dplyr::select(name, id, format, url)

    names(datasetlist$ID[[i]]) <- c("Name", "ID", "Format", "URL")

  }

  # Function call without arguments
  if(missing(topic) && missing(subtopic)){

    datasetlist

  # Function call with the subtopic argument
  } else if(missing(topic) && subtopic %in% levels(datasetlist$Subtopic)){

    datasetlist %>% dplyr::filter(Subtopic==subtopic)

  # Function call with the topic argument
  } else if(missing(subtopic) && topic %in% levels(datasetlist$Topic)){

    datasetlist %>% dplyr::filter(Topic==topic)

  # Error message if you use two input parameters
  } else if(!any(missing(topic), missing(subtopic))){

    stop("Use one argument, please")

  # Error message if you introduce an incorrect topic/subtopic
  } else{

    stop("Introduce a correct topic/subtopic, please")

  }

}
