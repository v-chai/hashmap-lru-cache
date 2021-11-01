class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      resize!
    end
    if self[key.hash].include?(key)
      print "Already in set"
    else
      self[key.hash].push(key)
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    return nil if !include?(key)
    self[key.hash].delete(key)
    @count -= 1
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    hashes = @store.flatten
    @store = Array.new(num_buckets*2) { Array.new }
    hashes.each do |key|
      self[key.hash].push(key)
    end
  end


end



class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count >= num_buckets
      resize!
    end
    if self.include?(num)
      print "Set already contains #{num}"
    else
      self[num].push(num)
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  protected

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    vals = @store.flatten
    # @store.push(*Array.new(num_buckets) { Array.new })
    @store = Array.new(num_buckets*2) { Array.new }
    vals.each do |val|
      self[val].push(val)
    end
  end
end