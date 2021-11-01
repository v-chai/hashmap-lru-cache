require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  include Enumerable
  attr_reader :prc, :max
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      update_node!(@map[key])
    elsif @map.count >= @max
      eject!
      calc!(key)
    else 
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  attr_reader :store, :map

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    new_node = @store.append(key,val)
    @map.set(key,new_node)
    new_node.val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @map[node.key] = @store.append(node.key, node.val)
    node.val
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
    nil
  end
end
