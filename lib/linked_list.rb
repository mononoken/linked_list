# frozen_string_literal: true

require_relative 'node'

# List of connected Nodes
class LinkedList
  attr_reader :head, :tail

  # List factory
  def self.create(*values)
    case values.count
    when 0
      EmptyLinkedList.new
    else
      LinkedList.new(values[0], *values[1..])
    end
  end

  # FIX_ME Messy implementation
  def initialize(first_value = nil, *node_values)
    @head = Node.new(first_value)
    @tail = @head
    node_values.each { |value| append(value) }
  end

  def append(value)
    @tail.next_node = Node.new(value)
    @tail = @tail.next_node
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def size(node = head)
    if node.nil?
      0
    else
      1 + size(node.next_node)
    end
  end

  def at(index)
    current_node = @head
    index.times do
      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    previous_tail = @tail

    current_node = @head
    (size - 2).times do
      current_node = current_node.next_node
    end

    current_node.next_node = nil
    @tail = current_node
    previous_tail
  end

  def contains?(value)
    current_node = @head
    until current_node.nil? || current_node.value == value
      current_node = current_node.next_node
    end
    return false if current_node.nil?

    current_node.value == value
  end

  def find(value)
    current_node = @head
    index = 0
    until current_node.nil? || current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    return nil if current_node.nil?

    index
  end

  # Format: ( value ) -> ( value ) -> ( value ) -> nil
  def to_s(node = head)
    if node == @tail
      "( #{@tail.value} ) -> nil"
    else
      "( #{node.value} ) -> " + to_s(node.next_node)
    end
  end

  # Extra credit
  def insert_at(value, index)
    return if index >= size

    new_node = Node.new(value)

    current_node = at(index)
    new_node.next_node = current_node

    if index == 0
      @head = new_node
    else
      before_node = at(index - 1)
      before_node.next_node = new_node
    end

    new_node
  end

  # Extra credit
  def remove_at(index)
    return if index >= size

    current_node = at(index)
    before_node = at(index - 1)
    next_node = at(index + 1)

    if index == 0
      @head = next_node
    elsif index == size - 1
      @tail = previous_node
    else
      before_node.next_node = next_node
    end

    current_node.next_node = nil
    current_node
  end
end

# List with no nodes.
class EmptyLinkedList < LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def begin_with(value)
    @head = Node.new(value)
    @tail = @head
  end

  def append(value)
    begin_with(value)
  end

  def prepend(value)
    begin_with(value)
  end

  def size
    0
  end

  def at(index)
    puts to_s
  end

  def pop
    puts to_s
  end

  def contains?
    puts to_s
  end

  def find(value)
    puts to_s
  end

  def to_s
    'List is empty.'
  end

  def insert_at(value, index)
    puts to_s
  end

  def remove(index)
    puts to_s
  end
end

class SingularLinkedList < LinkedList
end

# Three cases. Empty list, list with one node (both head and tail), and list with > 1 nodes.
