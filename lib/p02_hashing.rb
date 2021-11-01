class Integer
  # Integer#hash as implemented in Ruby core
end

class Array
  def hash
    # Uses bitwise XOR to improve uniformity 
    each_with_index.inject(0) do |intermediate_hash, (el, i)|
      (el.hash + i.hash) ^ intermediate_hash
    end
  end
end

class String
  def hash
    # Converts to array and maps integer ordinal to each element; 
    # then uses the Array#hash method defined above
    chars.map(&:ord).hash
  end
end

class Hash
  # Convert dictionary to array of tuples. Then sort so that ordering is uniform.
  # Finally, uses Array#hash method defined above to return single hash
  def hash
    to_a.sort_by(&:hash).hash
  end
end
