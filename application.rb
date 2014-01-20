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
      when "show :id"
        puts "K3"
        #insert display here
      when "quit"
        puts "Goodbye!"
      else 
        puts "Wrong answer! Try again, Biatch!"
        run 
      end
  end
  
  # Prints the main menu only
  def show_main_menu
    puts "Welcome to the app. What's next?"
    puts " new      - Create a new contact"
    puts " list     - List all contacts"
    puts " show :id - Display contact details"
    puts " quit     - Quits the program"
    print "> "
  end

  def new_contact
    puts "Cool, can you tell me your full name?"
    name = gets.chomp
    puts "...and your email?"
    email = gets.chomp
    puts "Thanks, bro!"
    contact = Contact.new(name, email)
    @contacts.push(contact)
    run
    #complete
  end

  def list_all
    @contacts.each do |contact|
      puts contact.to_s
    end
    
    run
    #complete
  end

  def display
  end

 
end