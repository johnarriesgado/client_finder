require 'json'

# Read and parse the JSON dataset
# TODO: add capability to search from given JSON dataset
# Uncomment this flag to enable feature
# json_file = ARGV[0] || 'clients.json'
json_file = 'clients.json'
clients = JSON.parse(File.read(json_file))

# Command Codes
COMMANDS = {
  'search' => %w[s search],
  'duplicates' => %w[d dupes duplicates duplicate],
  'quit' => %w[quit exit x q]
} # Extra codes added for testing

invalid_count = 0

# Search for clients by name or email
def search_clients(clients, query)
  clients.select { |c| c['full_name'].downcase.include?(query) || c['email'].downcase.include?(query) }
end

# Find clients with duplicate emails
def find_duplicate_emails(clients)
  duplicates = clients.group_by { |c| c['email'] }.values.select { |group| group.size > 1 }.flatten
  duplicates.map { |client| client['email'] }.uniq
end

# Exit function
def stop_search
  puts 'Thank you for using client finder. Goodbye!'
  exit
end

# Method to print empty message dynamically
def empty_msg_for(type)
  puts "No #{type} found"
end

# Main loop to execute COMMANDS based on user input

loop do
  break if defined?(TEST_ENV) # this way loop wont run in test

  puts "Enter command 'search', 'duplicates', or 'quit' to exit:"
  input = gets.chomp.downcase
  stop_search if COMMANDS['quit'].include?(input)

  case input
  when *COMMANDS['search']
    puts "Enter the search query:"
    results = search_clients(clients, gets.chomp.downcase)
    # TODO: add capability to choose which field to search for (ie name, email, or both)
    # Uncomment this flag to enable feature
    # puts "Enter the field you want to search by (e.g., full_name, email):"
    # field = gets.chomp.downcase
    # puts "Enter the search query:"
    # query = gets.chomp.downcase
    # results = search_clients(clients, field, query)
    # puts results.empty? ? empty_msg_for('matching clients') : results.map(&:to_json).join("\n")
    puts results.empty? ? empty_msg_for('matching clients') : results.map(&:to_json).join("\n")
  when *COMMANDS['duplicates']
    duplicates = find_duplicate_emails(clients)
    puts duplicates.empty? ?
      empty_msg_for('duplicate emails') : "Duplicate emails found:\n#{duplicates.map(&:to_json).join("\n")}"
  else
    invalid_count += 1
    if invalid_count >= 3
      puts "You've entered too many invalid COMMANDS. Exiting."
      stop_search
    else
      puts "You've entered an invalid command."
    end
  end
end