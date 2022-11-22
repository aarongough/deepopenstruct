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
  VERSION = '0.1.3'

  def self.load(item)
    raise ArgumentError, 'DeepOpenStruct must be passed a Hash or Array' unless item.is_a?(Hash) || item.is_a?(Array)

    if item.is_a?(Hash)
      item = item.merge(item) do |_key, value, _oldvalue|
        if value.is_a?(Hash) || value.is_a?(Array)
          DeepOpenStruct.load(value)
        else
          value
        end
      end
      PatchedOpenStruct.new(item)
    elsif item.is_a?(Array)
      item.map do |value|
        if value.is_a?(Hash) || value.is_a?(Array)
          DeepOpenStruct.load(value)
        else
          value
        end
      end
    end
  end
end
