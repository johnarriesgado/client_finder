require 'rspec'
require 'json'
TEST_ENV=true
require_relative 'client_search'

RSpec.describe 'ClientSearch' do
  let(:clients) { JSON.parse(File.read('clients.json')) }

  describe '#search_clients' do
    it 'returns matching clients' do
      query = 'jane'
      results = search_clients(clients, query)
      expect(results).to be_an(Array)
      expect(results).not_to be_empty
      results.each do |client|
        expect(client['full_name'].downcase).to include(query)
      end
    end

    it 'returns matching clients even if query is email' do
      query = '@hotmail'
      results = search_clients(clients, query)
      expect(results).to be_an(Array)
      expect(results).not_to be_empty
      results.each do |client|
        expect(client['email'].downcase).to include(query)
      end
    end

    it 'returns empty array if no matching clients found' do
      query = 'nonexistent'
      results = search_clients(clients, query)
      expect(results).to eq([])
    end
  end

  describe '#find_duplicate_emails' do
    it 'returns duplicate emails' do
      duplicates = find_duplicate_emails(clients)
      expect(duplicates).to be_an(Array)
      expect(duplicates).not_to be_empty
      duplicates.each do |email|
        expect(clients.count { |client| client['email'] == email }).to be > 1
      end
    end

    it 'returns empty array if no duplicate emails found' do
      # Create a new dataset without duplicate emails for testing
      unique_clients = clients.uniq { |client| client['email'] }
      expect(find_duplicate_emails(unique_clients)).to eq([])
    end
  end

  describe '#stop_search' do
    it 'exits the program after printing a goodbye message' do
      expect { stop_search }.to output("Thank you for using client finder. Goodbye!\n").to_stdout.and raise_error(SystemExit)
    end
  end
end
