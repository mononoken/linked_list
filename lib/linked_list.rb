# frozen_string_literal: true

require_relative 'node'

# List of connected Nodes
class LinkedList
  attr_reader :head

  def initialize(head_value = nil, *other_values)
    if head_value.nil? && other_values.empty?
      @head = nil
    else
      @head = Node.new(head_value)
      other_values.each { |value| append(value) }
    end
  end

  def append(value)
    return @head = value if head.nil?

    tail.next_node = Node.new(value)
  end

  def prepend(value)
    return @head = value if head.nil?

    @head = Node.new(value, head)
  end

  def size(node = head)
    if node.nil?
      0
    else
      1 + size(node.next_node)
    end
  end

  def tail(node = head)
    return node if node.next_node.nil?

    tail(node.next_node)
  end

  def at(index)
    pointer = @head
    index.times do
      pointer = pointer.next_node
    end
    pointer
  end

  def pop
    return 'List is empty.' if head.nil?

    previous_tail = tail

    if size == 1
      @head = nil
    else
      new_tail = at(size - 2)
      new_tail.next_node = nil
    end
    previous_tail
  end

  def contains?(value, node = head)
    if node.nil?
      false
    elsif value == node.value
      true
    else
      contains?(value, node.next_node)
    end
  end

  def find(value, node = head)
    if node.nil?
      nil
    elsif value == node.value
      node
    else
      find(value, node.next_node)
    end
  end

  # Format: ( value ) -> ( value ) -> ( value ) -> nil
  def to_s(node = head)
    return 'List is empty.' if head.nil?

    if node == tail
      "( #{tail.value} ) -> nil"
    else
      "( #{node.value} ) -> " + to_s(node.next_node)
    end
  end

  # Extra credit
  def insert_at(value, index)
    return 'Index invalid.' if index >= size

    new_node = Node.new(value, at(index))

    if index.zero?
      @head = new_node
    else
      at(index - 1).next_node = new_node
    end
    head
  end

  # Extra credit
  def remove_at(index)
    return 'Index invalid.' if index >= size
    return 'Nothing to remove.' if size.zero?

    removed_node = at(index)

    at(index - 1).next_node = at(index + 1)
    removed_node.next_node = nil
    removed_node
  end
end
