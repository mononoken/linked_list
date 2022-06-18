# frozen_string_literal: true

# Node for use with a LinkedList.
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# List of connected Nodes
class LinkedList
  attr_reader :head, :tail

  def initialize(head_value, *node_values)
    @head = Node.new(head_value)

    previous_node = @head
    node_values.each do |node_value|
      current_node = Node.new(node_value)
      previous_node.next_node = current_node unless previous_node.nil?
      previous_node = current_node
    end

    @tail = previous_node
  end

  def append(value)
    append_node = Node.new(value)
    @tail.next_node = append_node
    @tail = append_node
  end

  def prepend(value)
    prepend_node = Node.new(value, @head)
    @head = prepend_node
  end

  def size
    size = 0
    current_node = @head
    until current_node.nil?
      size += 1
      current_node = current_node.next_node
    end
    size
  end

  def at(index)
    if index == 0
      @head
    else
      current_node = @head
      index.times do
        current_node = current_node.next_node
      end
      current_node
    end
  end

  def pop
    # Remove last element from the list
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

  def to_s
    # Format: ( value ) -> ( value ) -> ( value ) -> nil
    list_string = ''
    list_string += "( #{@head.value} )" unless @head.nil?
    current_node = @head.next_node
    until current_node.nil?
      list_string += " -> ( #{current_node.value} )"
      current_node = current_node.next_node
    end
    list_string
  end

  # Extra credit
  def insert_at(value, index)
  end

  # Extra credit
  def remove_at(index)
  end
end
