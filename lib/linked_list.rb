# frozen_string_literal: true

require_relative 'node'

# List of connected Nodes
class LinkedList
  attr_reader :head, :tail

  def initialize(head_value, *node_values)
    @head = Node.new(head_value)
    @tail = @head

    node_values.each { |value| append(value) }
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

  def to_s(node = head)
    # Format: ( value ) -> ( value ) -> ( value ) -> nil
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
