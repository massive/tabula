module TabulaTags
  include Radiant::Taggable
  
  # <r:table:each name="test">
  #   <r:value name="1"/><br/>
  # </r:table:each>
  
  tag 'table' do |tag|
    tag.expand
  end
  
  tag 'table:each' do |tag|
    table_name = tag.attr['name']
    table = Table.find_by_title(table_name)
    
    rows = parse_table(table)        
    
    results = []    
    rows.each do |row|
      tag.locals.row = row
      results << tag.expand
    end    
    results
  end
  
  tag 'table:each:value' do |tag|             
    row = tag.locals.row
    value_name = tag.attr['name']          
    row[value_name]        
  end
  
  keys.each do |title|
    tag "table:each:#{title}" do |inner_tag|
      row[value_name]
    end
  end
    
  def parse_table(table)
    results = []
    rows = CSV.parse(table.data)    
    @keys = rows.shift    
    
    rows.each do |values|
      results << Hash.zip(keys, values)
    end
    results    
  end
  
end

class Hash
  #
  # Create a hash from an array of keys and corresponding values.
  def self.zip(keys, values, default=nil, &block)
    hsh = block_given? ? Hash.new(&block) : Hash.new(default)
    keys.zip(values) { |k,v| hsh[k]=v }
    hsh
  end
end
