require 'date'

class DateUtils
  def self.parse(str)
    DateTime.strptime(str, '%d/%m/%Y %H:%M:%S')
  end
end
