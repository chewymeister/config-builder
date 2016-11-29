require 'yaml'

class Mason
  # class << self
  def initialize args
    @template = args[:template]
    @stub = args[:stub]
  end

  def merge!(template = @template, stub = @stub)
    @result = template.merge(stub) do |key, template_value, stub_value|
      if needs_to_be_merged? stub_value
        merge!(template_value, stub_value)
      else
        stub_value
      end
    end
  end

  def merged_result
    @result
  end

  private

  def needs_to_be_merged? value
    value.class == Hash
  end
end
