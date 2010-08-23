require 'ostruct'

class PatchedOpenStruct < OpenStruct
  def id
    @table[:id]
  end
  
  def type
    @table[:type]
  end
end

class DeepOpenStruct
  def self.load(item)
    raise ArgumentError, "DeepOpenStruct must be passed a Hash or Array" unless(item.is_a?(Hash) || item.is_a?(Array))
    if(item.is_a?(Hash))
      item = item.merge(item) do |key, value, oldvalue|
        if(value.is_a?(Hash) || value.is_a?(Array))
          DeepOpenStruct.load(value)
        else
          value
        end
      end
      return PatchedOpenStruct.new(item)
    elsif(item.is_a?(Array))
      return item.map do |value|
        if(value.is_a?(Hash) || value.is_a?(Array))
          DeepOpenStruct.load(value)
        else
          value
        end
      end
    end
  end
end