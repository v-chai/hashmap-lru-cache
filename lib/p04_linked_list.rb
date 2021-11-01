
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next if @prev
    @next.prev = @prev if @next
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : self.head.next
  end

  def last
    empty? ? nil : self.tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }

  end

  def include?(key)
    any? { |node| node.key == key}
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = self.tail.prev 
    self.tail.prev.next = new_node
    new_node.next = self.tail
    self.tail.prev = new_node
    new_node
  end

  def update(key, val)
    each {|node| node.val = val if node.key == key }
  end

  def remove(key)
    each do |node| 
      if node.key == key
        node.remove
        return node.val
      end
    end
  end

  def each
    ele = @head
    until ele.next == @tail
      yield ele.next
      ele = ele.next
    end

  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
