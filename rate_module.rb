module RateModule
  def self.handle(clients)
    puts "Enter the minimum rating:"
    rate = STDIN.gets.chomp.downcase
    results = filter_by_rating(clients, rate)
    puts results.empty? ? empty_msg_for('matching clients') : results.map(&:to_json).join("\n")
  end

  private

  def self.filter_by_rating(clients, query)
    clients.select { |c| c['rating'].to_f >= query.to_f }
  end

  def self.empty_msg_for(type)
    puts "No #{type} found"
  end
end
