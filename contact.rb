class Contact
  
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :email
  
  def initialize(name, email)
    # TODO: assign local variables to instance variables
    @first_name  = name.split(" ").first
    @last_name   = name.split(" ").last
    @email      = email
  end
  
  def to_s
    # TODO: return string representation of Contact
    "#{@first_name.to_s} #{@last_name.to_s} - #{@email.to_s}"
  end
  
end