require 'term/ansicolor'

class String
  include Term::ANSIColor
end

class Application
 
  def run
    show_main_menu
    input = gets.chomp.downcase
    case input
      when "new"
        new_contact
      when "list"
        list_all
      when "show"
        puts "\nenter contacts ID number:\n"
        puts "\n"
        id = gets.chomp.to_i
        display(id)
        run
      when "value"
        value
      when "delete"
        puts "\nsearch for a contacts id to" + " delete:\n".bold
        id = gets.chomp.to_i
        delete(id)
      when "search"
        puts "\nsearch for a contacts" + " first name".bold + ":\n"
        find
      when "quit"
        puts "\nFine! Goodbye!\n"
      else 
        puts "\n Invalid command, try again!".red.bold, "\n"
        run 
      end
  end
  
  def show_main_menu
    puts "\n   Welcome to your contacts! What's next?   ".underline
    puts "|" + " new".bold + "      - Create a new contact          |"
    puts "|" + " list".bold + "     - List all contacts             |"
    puts "|" + " show".bold + "     - Display contact details       |"
    puts "|" + " value".bold + "    - Display contacts by importance|"
    puts "|" + " search".bold + "   - Search for a contact          |"
    puts "|" + " delete".bold + "   - Delete a contact              |"
    puts "|".underline + " quit".bold.underline + "     - Quits the program             |\n".underline
    print "\n> "
  end

  def new_contact
    puts "\nCool, can you tell me your" + " full name".bold + "?\n"
    puts "\n"
    name        = gets.chomp
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
        success    = Contact.create(first_name: "#{first_name}", last_name: "#{last_name}", email: "#{email}", importance: "#{importance}").valid? 
        if success == true
          puts "\nContact created!\n"
        else 
          puts "\nFailed to create contact!".bold.red
        end
      end
    run
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
  end

  def display(id)
    contact = Contact.find_by(id: "#{id}")
    if ( contact )
      puts "\n"
      puts contact.to_s
    else
      puts "\nError! Contact doesn't exist!".red.bold
    end
  end

  def delete(id)
    puts "\nconfirm to delete contact: (y/n)\n".bold
    puts Contact.find(id).to_s
    puts "\n"
    confirmation       = gets.chomp.downcase
      if confirmation == "y"
        contact        = Contact.find_by(id: "#{id}")
        contact.destroy
        puts "\nContact deleted!".red.bold
      end
    run
  end

  def find
    name  = gets.chomp
    index = index_of(name)
      if ( index )
        puts Contact.all[index].to_s 
      else
        puts "\nError! Name doesn't exist!\n".red.bold
      end
    run
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