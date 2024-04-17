module SearchModule
  def self.handle(clients)
    # New loop to get field name
    field = ''
    loop do
      puts "Enter the field you want to search by ('name' or 'email'):"
      field = STDIN.gets.chomp.downcase
      if ['name', 'email'].include?(field)
        field = 'full_name' if field == 'name'
        break
      else
        puts "Invalid field. Please enter 'name' or 'email'."
      end
    end

    puts "Enter the search query:"
    query = STDIN.gets.chomp.downcase
    results = search_clients(clients, field, query)
    puts results.empty? ? empty_msg_for('matching clients') : results.map(&:to_json).join("\n")
  end

  private

  def self.search_clients(clients, field, query)
    clients.select { |c| c[field].downcase.include?(query) }
  end

  def self.empty_msg_for(type)
    puts "No #{type} found"
  end
end
