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

    def inspect
      rows.map { |row| row.join }.join("\n")
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

  private

  def add_layer
    layers << Layer.new(width: width, height: height)
  end

end
