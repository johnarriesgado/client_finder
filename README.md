# Client Finder
## _A Command-line Application_

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

This is a minimalist command-line application built using Ruby. It allows users to search through a JSON dataset of clients and perform two operations:

1. **Search Clients:** Search through all clients and return those with names or email partially matching a given search query.
2. **Find Duplicates:** Find out if there are any clients with the same email in the dataset and show those duplicates if any are found.

## Usage

To use the application, follow these steps:

1. Clone this repository to your local machine.
```
git clone https://github.com/johnarriesgado/client_finder.git
```
2. Navigate to the project directory.
3. Run the application using the following commands:

  ```bash
    > ruby client_finder.rb
  ```

4. And respond according to the given prompt.

### Examples

  #### Search
  ```
    > ruby client_finder.rb
    Enter command (search or duplicates):
    > search
    Find client:
    > SEARCH_QUERY
    {"full_name"=>"SEARCH_QUERY Smith", "email"=>"search_query.smith@yahoo.com"}
  ```
  ##### Replace `[SEARCH_QUERY]` with the search query you want to use.

  #### Find Duplicates
  ```
    > ruby client_search.rb
    Enter command (s or search, d or duplicates):
    > duplicates
    Duplicate emails found:
    "jane.smith@yahoo.com"
  ```
  #### Invalid Input
  ```
    > ruby client_search.rb
    Enter command (s or search, d or duplicates):
    > lorem
    Invalid option.
    Enter command (s or search, d or duplicates):
  ```

## Dataset

The application uses a JSON dataset containing client information. The dataset is provided in the `client.json` file.

## Requirements

- Ruby installed on your machine
  ```
  Ruby version: ruby-3.1.0
  ```

### Assumptions
- The JSON dataset provided (`clients.json`) follows a specific format where each client object contains `id`, `full_name`, and `email` fields.
- The script assumes that the JSON dataset is always located in the same directory as the script itself.
- Input only accepts two options: `search or duplicates`.
- Input operators only accepts downcase commands. 
- For the search operation
  - partial matches are considered for both `full_name` and `email` fields.
  - returned dataset for matches includes all fields. no security options added in place
  - Any input from user is for search client and not to exit application.
- For the duplicates operation
  - Only returns the duplicate emails.
  - No option to search for a specific duplicate. For example, searching if `jane@gmail.com` has any duplicates
- The search query is assumed to be case-insensitive. For example, searching for "Jane" will match both "Jane" and "jane" in names and emails.
- User will provide valid inputs, search queries, and email addresses.
- The output format for displaying client details is assumed to be JSON.
- IDs are not used for searching queries.

### Suggestions for Improvement
- Implement better error handling for invalid user inputs to provide better user experience.
- Add a more robust input validation to ensure that the user provides valid input.
- Enhance the search functionality to allow for case-insensitive searches.
- Add security to results. Identify what client want and only return needed data. (i.e dont include ids)
- Consider optimizing the code for better performance, especially for large datasets.
- Provide an option to export the search results or duplicate findings to a file with complete details for further analysis.
- Add additional features such as pagination, sorting, filtering, or targetted searching for duplicates to enhance the user experience and provide more flexibility in interacting with the dataset.
