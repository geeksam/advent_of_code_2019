class SIF
  class Layer
    attr_reader :width, :height, :rows
    def initialize(width:, height:)
      @width, @height = width, height
      @rows = [[]]
    end

    def complete?
      rows.length == height && rows.last.length == width
    end

    def add_pixel(n)
      if rows.last.length == width
        rows << []
      end
      rows.last << n
    end

    def count_of(n)
      rows.map {|row| row.count(n) }.inject(0, :+)
    end

    def each_pixel
      (0...height).each do |y|
        (0...width).each do |x|
          yield x, y, rows[y][x]
        end
      end
    end

    def inspect
      rows.map { |row| row.join }.join("\n")
    end
  end

  class PixelStack
    attr_reader :list
    def initialize
      @list = []
    end

    def add_pixel(n)
      list << n
    end

    def value
      list.each do |n|
        case n
        when 0, 1 ; return n
        when 2    ; # continue
        end
      end
      fail "they can't *all* be transparent!"
    end
  end

  attr_reader :width, :height, :layers
  def initialize(data, width:, height:)
    @width, @height = width, height
    @layers = []
    data.scan(/./) do |char|
      add_pixel char.to_i
    end
  end

  def add_pixel(n)
    add_layer if layers.empty? || layers.last.complete?
    layers.last.add_pixel(n)
  end

  def inspect
    layers.map.with_index { |layer, i|
      "Layer #{i+1}:\n" + layer.inspect + "\n"
    }.join("\n")
  end

  def layer_with_fewest(n)
    layers.sort_by { |layer| layer.count_of(n) }.first
  end

  def flatten_for_inspection
    pixel_stacks = Hash.new { |hash, key| hash[key] = PixelStack.new }

    layers.each do |layer|
      layer.each_pixel do |x, y, n|
        pixel_stacks[ [x,y] ].add_pixel n
      end
    end

    s = ""
    (0...height).each do |y|
      (0...width).each do |x|
        stack = pixel_stacks[ [x,y] ]
        s << stack.value.to_s
      end
      s << "\n" unless y == height-1
    end
    s.strip
  end

  def to_s
    flatten_for_inspection
      .gsub("0", " ")
      .gsub("1", "#")
  end

  private

  def add_layer
    layers << Layer.new(width: width, height: height)
  end

end
