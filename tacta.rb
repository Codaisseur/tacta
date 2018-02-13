require './contacts_file'

def index(contacts)
  contacts.each_with_index do |contact, index|
    puts "#{index + 1}) #{contact[:name]}"
  end
end

def show(contact)
  puts contact[:name].to_s
  puts "phone: #{contact[:phone]}"
  puts "email: #{contact[:email]}"
end

def ask(prompt)
  print prompt
  gets.chomp
end

def create_new
  contact = {}

  puts
  puts "Enter contact info:"

  contact[:name]  = ask("Name? ")
  contact[:phone] = ask("Phone? ")
  contact[:email] = ask("Email? ")

  contact
end

def action_show(contacts, index)
  contact = contacts[index - 1]

  puts
  show(contact)
  puts
end

def action_new(contacts)
  contact = create_new

  contacts << contact
  write_contacts(contacts)

  puts
  puts "New contact created:"
  puts

  show(contact)
  puts
end

def action_delete(contacts)
  puts
  response = ask("Delete which contact? ")

  index = response.to_i

  puts
  puts "Contact for #{contacts[index - 1][:name]} deleted."

  contacts.delete_at(index - 1)
  write_contacts(contacts)
  puts
end

def action_error
  puts
  puts "Sorry, I don't recognize that command."
  puts
end

def action_search
  puts
  pattern = ask("Search for? ")
  puts

  contacts.each do |contact|
    if contact[:name] =~ /\b#{pattern}/i
      show(contact)
      puts
    end
  end
end

loop do
  contacts = read_contacts

  index(contacts)

  puts
  response_options = "(n for new, d for delete, s for search, q to quit)"
  response = ask("Who would you like to see #{response_options}? ")

  break if response == "q"

  if response == "n"
    action_new(contacts)
  elsif response == "d"
    action_delete(contacts)
  elsif response == "s"
    action_search(contacts)
  elsif response =~ /[0-9]+/
    action_show(contacts, response.to_i)
  else
    action_error
  end
end

puts
puts "Bye!"
