# baRcelona

## Overview

* **Catalogue management**. baRcelona is used to consult and manage the catalogue information available on the [Open Data BCN portal](https://opendata-ajuntament.barcelona.cat/en/node), 
such as data sets and their associated resources: ID, topic, author, source, department, etc. 

* **Retrieve CSV files**. Allows you to read and load the CSV data sets directly in your RStudio environment. 

## Open Data BCN

> Open Data or Public Sector Information Openness is a movement driven by public administrations with the main objective of
**maximize available public resources**, exposing the information generated or guarded by public bodies, allowing its access and 
use for the **common good and for the benefit of anyone and any entity interested**.

> **Open Data BCN**, a project that was born in 2010, implementing the portal in 2011, has evolved and is now part of the Barcelona
Ciutat Digital strategy, fostering a pluralistic digital economy and developing a new model of urban innovation based on the 
transformation and digital innovation of the public sector and the implication among companies, administrations, the academic world, 
organizations, communities and people, with a clear public and citizen leadership. 

## Installation

```R
# install.packages("devtools")
devtools::install_github("xavivg91/baRcelona")
```
## Usage

`library(baRcelona)` will load the following core functions:

* `datasetlist()`, for catalogue management.
* `get.csv()`, for CSV data sets.


## How it works

Let’s say we want to obtain a sport data set. First, we need to execute the `dataselist()` function to see all the
sports data sets available on the Open Data BCN portal.

```R
# List of sports data sets available
datasets <- datasetlist(subtopic = "Sport")
```
Once executed, check out the saved data frame and copy the resource ID of the CSV you want to consult (inside the ID column). 
Then, paste the ID as an input argument of the `get.csv()` function. 

```R
# Read and load the CSV data set
sportdataset <- get.csv(id = "cd8d0d2b-b97a-4aba-b1c8-e25696379a58")
```

Easy, right?
