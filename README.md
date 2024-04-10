# Client Finder
## _A Command-line Application_

[![Branch Status](https://img.shields.io/github/last-commit/johnarriesgado/client_finder/master)](https://github.com/johnarriesgado/client_finder/branches)

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
```
cd client_finder
```

3. Run the application using the following commands:
```
ruby client_search.rb
```

4. Provide a response based on the instructions given.
```
Enter command 'search', 'duplicates', or 'quit' to exit:
|
```

### Examples

  #### Search
  ##### Replace `[SEARCH_QUERY]` with the search query you want to use.

  ##### When Client is found.
  ```
    > ruby client_search.rb
    Enter command 'search', 'duplicates', or 'quit' to exit:
    > search
    Enter the search query:
    > SEARCH_QUERY
    {"full_name"=>"SEARCH_QUERY Smith", "email"=>"search_query.smith@yahoo.com"}
  ```
  ##### When no Client is found.
  ```
    > ruby client_search.rb
    Enter command 'search', 'duplicates', or 'quit' to exit:
    > search
    Enter the search query:
    > SEARCH_QUERY
    No matching clients found.
  ```

  #### Find Duplicates
  ##### When duplicates are found.
  ```
    > ruby client_search.rb
    Enter command 'search', 'duplicates', or 'quit' to exit:
    > duplicates
    Duplicate emails found:
    "jane.smith@yahoo.com"
  ```
  ##### When no duplicates found.
  ```
    > ruby client_search.rb
    Enter command 'search', 'duplicates', or 'quit' to exit:
    > duplicates
    No duplicate emails found.
  ```

  #### Invalid Input
  ```
    > ruby client_search.rb
    Enter command 'search', 'duplicates', or 'quit' to exit:
    > lorem
    Invalid option.
    Enter command 'search', 'duplicates', or 'quit' to exit:
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
  - partial matches are considered for both `full_name` and `email` fields only. The `id` field is not used.
  - returned dataset for matches includes all fields. no security options added in place
  - Any input from user is for search client and not to exit application.
- For the duplicates operation
  - Only returns the duplicate emails.
  - No option to search for a specific duplicate. For example, searching if `jane@gmail.com` has any duplicates
- The search query is assumed to be case-insensitive. For example, searching for "Jane" will match both "Jane" and "jane" in names and emails.
- User will provide valid inputs, search queries, and email addresses.
- The output format for displaying client details is assumed to be JSON.
- IDs are not used for searching queries.
- There should be a limit to the number of invalid command entered.

### Suggestions for Improvement
- Implement better error handling for invalid user inputs to provide better user experience.
- Add a more robust input validation to ensure that the user provides valid input.
- Enhance the search functionality to allow for case-insensitive searches.
- Add security to results. Identify what client want and only return needed data. (i.e dont include ids)
- Consider optimizing the code for better performance, especially for large datasets.
- Provide an option to export the search results or duplicate findings to a file with complete details for further analysis.
- Add additional features such as pagination, sorting, filtering, or targetted searching for duplicates to enhance the user experience and provide more flexibility in interacting with the dataset.
