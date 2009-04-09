class Table < ActiveRecord::Base
  validates_presence_of :data
  
  validate :data_is_valid_csv
  
  def data_is_valid_csv
    CSV.parse(data)
    
    rescue CSV::IllegalFormatError
      errors.add(:data, "is not valid csv")
  end
  
end
