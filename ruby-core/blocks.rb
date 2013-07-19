#!/usr/bin/env ruby -wKU

# HW 1-7: Iterators, Blocks, Yield
class CartesianProduct
    include Enumerable
    def initialize(vector1,vector2)
      @vector1, @vector2 = vector1, vector2
    end

    def each(&block)
      @vector1.each do |value_v1|
        @vector2.each do |value_v2|
          yield [value_v1,value_v2]
        end
      end
    end
end
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# Nothing printed since Cartesian product of anything with an empty collection is empty
