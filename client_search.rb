require 'json'
require_relative 'search_module'
require_relative 'rate_module'
require_relative 'duplicate_module'

# Read and parse the JSON dataset
json_file = ARGV[0] || 'clients.json'
puts "Reading data from file: #{json_file}"
clients = JSON.parse(File.read(json_file))

# Command Codes
COMMANDS = {
  'search' => %w[s search],
  'rate' => %w[r rate rating],
  'duplicates' => %w[d dupes duplicates duplicate],
  'quit' => %w[quit exit x q]
} # Extra codes added for testing

# Check if clients have a 'rating' field
allow_rating_filter = clients.any? { |client| client.key?('rating') }

# Remove the 'rate' command if clients do not have a 'rating' field
COMMANDS.delete('rate') unless allow_rating_filter

invalid_count = 0

# Exit function
def stop_search
  puts 'Thank you for using client finder. Goodbye!'
  exit
end

# Main loop to execute COMMANDS based on user input
loop do
  break if defined?(TEST_ENV) # this way loop wont run in test

  puts "Enter command 'search',#{allow_rating_filter ? ' \'rate\',' : ''} 'duplicates', or 'quit' to exit:"
  input = STDIN.gets.chomp.downcase
  stop_search if COMMANDS['quit'].include?(input)

  case input
  when *COMMANDS['search']
    SearchModule.handle(clients)
  when *COMMANDS['rate']
    RateModule.handle(clients)
  when *COMMANDS['duplicates']
    DuplicateModule.handle(clients)
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
