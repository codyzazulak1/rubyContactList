require 'term/ansicolor'

class String
  include Term::ANSIColor
end

class Application
 
  def initialize
    # Start with an empty array of contacts.
    # TODO: Perhaps stub (seed) some contacts so we don't 
    # have to create some every time we restart the app.
    @contacts = []
  end
 
  def run
    show_main_menu
    input = gets.chomp.downcase
    case input
      when "new"
        new_contact
        #complete
      when "list"
        list_all
        #complete
      when "show"
        puts "enter contacts ID number:"
        id = gets.chomp.to_i
        display(id)
        run
        #complete
      when "find"
        puts "search for a contacts" + " first name".bold + ":"
        find
      when "quit"
        puts "Fine! Goodbye!"
        #complete
      else 
        puts "\n Wrong answer! Try again loser!".red.bold, "\n"
        run 
        #complete
      end
  end
  
  # Prints the main menu only
  def show_main_menu
    puts "Welcome to the app. What's next?".underscore
    puts " new".bold + "      - Create a new contact"
    puts " list".bold + "     - List all contacts"
    puts " show".bold + "     - Display contact details"
    puts " find".bold + "     - Seach for a contact"
    puts " quit".bold + "     - Quits the program"
    print "> "
  end

  def new_contact
    puts "Cool, can you tell me your" + " full name".bold + "?"
    name = gets.chomp
    puts "...and your" + " email".bold + "?"
    email = gets.chomp
    if ( duplicate ( email ) )
      puts "Error! Contact already exists!".red.bold
    else
      puts "Thanks, bro!"
      index = @contacts.length + 1
      contact = Contact.new(name, email, index)
      @contacts.push(contact)
    end
    run
    #complete
  end

  def duplicate(email)
    @contacts.each do |contact|
      if email == contact.email
        return true
    end
  end
    false
  end

  def list_all
    @contacts.each do |contact|
      puts contact.to_s
    end
    run
    #complete
  end

  def display(id)
    puts @contacts[id - 1].to_s
    #complete
  end

  def find
    name = gets.chomp
    index = index_of(name)
    if ( index )
      puts @contacts[index].to_s 
    else
      puts "Error! Name doesn't exist!".red.bold
    end
    run
    #complete
  end

  def index_of(name)
    @contacts.each_with_index do |contact, index|
      if name == contact.first_name
        return index
    end
  end
    false
  end

end