class Contact < ActiveRecord::Base
  
  validates :email, uniqueness: true
  validates :importance, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  
  def to_s
    "ID#:#{id.to_s} #{first_name.to_s} #{last_name.to_s} - #{email.to_s} - " + "#{importance.to_s}".bold
  end
  
end
