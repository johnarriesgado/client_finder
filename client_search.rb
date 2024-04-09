require 'json'

# Read and parse the JSON dataset
clients = JSON.parse(File.read('clients.json'))

# Command Codes
commands = {
  'search' => %w[s search],
  'duplicates' => %w[d dupes duplicates duplicate],
  'quit' => %w[quit exit x q]
} # Extra codes added for testing

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

# Main loop to execute commands based on user input
loop do
  puts "Enter command 'search', 'duplicates', or 'quit' to exit:"
  input = gets.chomp.downcase
  stop_search if commands['quit'].include?(input)

  case input
  when *commands['search']
    puts "Find client:"
    results = search_clients(clients, gets.chomp.downcase)
    puts results.empty? ? empty_msg_for('matching clients') : results.map(&:to_json).join("\n")
  when *commands['duplicates']
    duplicates = find_duplicate_emails(clients)
    puts duplicates.empty? ?
      empty_msg_for('duplicate emails') : "Duplicate emails found:\n#{duplicates.map(&:to_json).join("\n")}"
  else
    puts 'Invalid option.'
  end
end