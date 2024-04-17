module DuplicateModule
  def self.handle(clients)
    dupes = find_duplicate_emails(clients)
    puts dupes.empty? ?
             empty_msg_for('duplicate emails') : "Duplicate emails found:\n#{dupes.map(&:to_json).join("\n")}"
  end

  private

  def self.find_duplicate_emails(clients)
    dupes = clients.group_by { |c| c['email'] }.values.select { |group| group.size > 1 }.flatten
    dupes.map { |client| client['email'] }.uniq
  end

  def self.empty_msg_for(type)
    puts "No #{type} found"
  end
end
