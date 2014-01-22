require 'term/ansicolor'

class String
  include Term::ANSIColor
end

class Application
 
  def initialize
    # Start with an empty array ofContact.all.
    # TODO: Perhaps stub (seed) someContact.all so we don't 
    # have to create some every time we restart the app.
    # Contact.all = []
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
        puts "\nenter contacts ID number:\n"
        puts "\n"
        id = gets.chomp.to_i
        display(id)
        run
        #complete
      when "value"
        value
      when "delete"
        puts "\nsearch for a contacts id to" + " delete:\n".bold
        id = gets.chomp.to_i
        delete(id)
      when "find"
        puts "\nsearch for a contacts" + " first name".bold + ":\n"
        find
      when "quit"
        puts "\nFine! Goodbye!\n"
        #complete
      else 
        puts "\n Invalid command, try again!".red.bold, "\n"
        run 
        #complete
      end
  end
  
  # Prints the main menu only
  def show_main_menu
    puts "\nWelcome to the app. What's next?"
    puts " new".bold + "      - Create a new contact"
    puts " list".bold + "     - List all contacts"
    puts " show".bold + "     - Display contact details"
    puts " value".bold + "    - Display contacts by importance"
    puts " find".bold + "     - Seach for a contact"
    puts " delete".bold + "   - Delete a contact"
    puts " quit".bold + "     - Quits the program\n"
    print "\n> "
  end

  def new_contact
    puts "\nCool, can you tell me your" + " full name".bold + "?\n"
    puts "\n"
    name = gets.chomp
    first_name  = name.split(" ").first
    last_name   = name.split(" ").last
    puts "\n...and your" + " email".bold + "?\n"
    puts "\n"
    email = gets.chomp
    if ( duplicate ( email ) )
      puts "\nError! Contact already exists!\n".red.bold
    else
      puts "\ngive this contact an importance value (1 to 5)\n"
      puts "\n"
      importance = gets.chomp.to_i
      # index = Contact.all.length + 1
      contact = Contact.create(first_name: "#{first_name}", last_name: "#{last_name}", email: "#{email}", importance: "#{importance}")
      # Contact.all.push(contact)
      puts "\nContact created!\n"
    end
    run
    #complete
  end

  def duplicate(email)
    Contact.all.each do |contact|
      if email == contact.email
        return true
    end
  end
    false
  end

  def list_all
    Contact.all.each do |contact|
      puts contact.to_s
    end
    run
    #complete
  end

  def display(id)
    contact = Contact.find_by(id: "#{id}")
    if ( contact )
      puts "\n"
      puts contact.to_s
    else
      puts "\nError! Contact doesn't exist!".red.bold
    end
    #complete
  end

  def delete(id)
    puts "\nconfirm to delete contact: (y/n)\n".bold
    puts Contact.find(id).to_s
    puts "\n"
    confirmation = gets.chomp.downcase

    if confirmation == "y"
      contact = Contact.find_by(id: "#{id}")
      contact.destroy
      puts "\nContact destroyed".red.bold
    end
    run
  end


  def find
    name = gets.chomp
    index = index_of(name)
    if ( index )
      puts Contact.all[index].to_s 
    else
      puts "\nError! Name doesn't exist!\n".red.bold
    end
    run
    #complete
  end

  def value
    Contact.all.order(importance: :desc).each do |contact|
      puts contact.to_s
    end
    run
  end


  def index_of(name)
    Contact.all.each_with_index do |contact, index|
      if name == contact.first_name
        return index
    end
  end
    false
  end

end