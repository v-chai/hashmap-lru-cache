class MaxIntSet
  attr_reader :store
  def initialize(max)
    raise ArgumentError if max < 1 || !max.is_a?(Integer)
    @max = max
    @store = Array.new(max+1) {false}
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false
    else
      raise "Elements must be integers from 0 to #{@max}"
    end
  end

  def include?(num)
    if is_valid?(num)
      @store[num]
    else
      raise "Elements must be integers from 0 to #{@max}"
    end
  end

  private

  def is_valid?(num)
    num >= 0 && num <= @max && num.is_a?(Integer)
  end

end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
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
